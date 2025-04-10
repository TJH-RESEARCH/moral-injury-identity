
library(tidymodels)
library(modelr)

# A. RECIPES ----------------------------------------------------------------------

## Calculate an MIOS score of 0 for anyone who did not endorse a Moral Injury Event.
data <-
  data %>% 
  mutate(mios_total_robust = ifelse(mios_screener == 0, 0, mios_total))


## Specify the base 'recipe' for all the models:
recipe <-
  recipe(data, 
         vars = 
           c(
             'mios_total',
             'mios_total_robust',
             'wis_private_regard_total',
             'wis_interdependent_total',
             'mios_screener',
             'mios_criterion_a',
             'military_exp_combat',
             'race_black', 'race_white',
             'branch_air_force', 'branch_marines', 'branch_navy',
             'sex_male',
             'service_era_init_pre_vietnam', 'service_era_init_vietnam', 'service_era_init_post_vietnam', 'service_era_init_persian_gulf',
             'mos_combat',
             'years_service',
             'rank_e1_e3', 'rank_e4_e6', 'rank_e7_e9')
         ) %>% 
  
  ### Center all the continuous variables
  step_center(mios_total, 
              mios_total_robust,
              wis_private_regard_total, 
              wis_interdependent_total, 
              years_service) %>% 
  
  ### Scale all the continuous variable to have a mean of 0 and SD of .5:
  step_scale(mios_total, 
             mios_total_robust,
             wis_private_regard_total, 
             wis_interdependent_total, 
             years_service, 
             factor = 2) %>% 
  
  ### subtract the mean from the index variables to give them a new mean of 0:
  step_mutate_at(mios_screener,
                 mios_criterion_a,
                 military_exp_combat,
                 race_black, race_white,
                 branch_air_force, branch_marines, branch_navy,
                 sex_male,
                 service_era_init_pre_vietnam, service_era_init_vietnam, 
                 service_era_init_post_vietnam, service_era_init_persian_gulf,
                 mos_combat,
                 rank_e1_e3, rank_e4_e6, rank_e7_e9, 
                 fn = ~ .x - mean(.x)) %>% 
  
  ### Set the variables that will be predictors in every model:
  update_role(mios_screener, 
              mios_criterion_a, 
              military_exp_combat, 
              race_black, race_white, 
              branch_air_force, branch_marines, branch_navy,
              sex_male, 
              service_era_init_pre_vietnam, service_era_init_vietnam, service_era_init_post_vietnam, service_era_init_persian_gulf,
              mos_combat,
              years_service, 
              rank_e1_e3, rank_e4_e6, rank_e7_e9, 
              new_role = 'predictor')


### Print the recipe:
recipe %>% print()

### Save a copy of the prepared data ('baked' according to the 'recipe'): 
data_baked <- recipe %>% prep(., data) %>% bake(., NULL)


### Check that transformations made everything the same scale (i.e., mean = 0)
data_baked %>% summarize(across(where(is.numeric), ~ round(mean(.x), 14))) %>% t()
### And standard deviations are all between 0-1
data_baked %>% summarize(across(where(is.numeric), ~ sd(.x))) %>% t()
### And that the index variables are still a difference of 1
data_baked %>% summarize(across(where(is.numeric), ~ max(.x) - min(.x))) %>% t()



## Modify the base recipe for each regression model ----------------------------

### Interdependence as the outcome:
recipe_inter <-
  recipe %>% 
  update_role(wis_interdependent_total, new_role = 'outcome')

recipe_inter %>% print()


### Interdependence as a predictor and Moral Injury symptoms as the outcome:
recipe_mios_inter <-
  recipe %>% 
  update_role(wis_interdependent_total, new_role = 'predictor') %>% 
  update_role(mios_total, new_role = 'outcome')

recipe_mios_inter %>% print()


### Private Regard as the outcome
recipe_regard <-
  recipe %>% 
  update_role(wis_private_regard_total, new_role = 'outcome')

recipe_regard %>% print()


### Private Regard as a predictor and Moral Injury Symptoms as the outcome
recipe_mios_regard <-
  recipe %>% 
  update_role(wis_private_regard_total, new_role = 'predictor') %>% 
  update_role(mios_total, new_role = 'outcome')
  
recipe_mios_regard %>% print()


### Robustness check
#### Private Regard with Robust MIOS variable 
recipe_mios_regard_robust <-
  recipe %>% 
  update_role(wis_private_regard_total, new_role = 'predictor') %>% 
  update_role(mios_total_robust, new_role = 'outcome')

recipe_mios_regard_robust %>% print()

### Interdependence with Robust MIOS variable 
recipe_mios_inter_robust <-
  recipe %>% 
  update_role(wis_interdependent_total, new_role = 'predictor') %>% 
  update_role(mios_total_robust, new_role = 'outcome')

recipe_mios_inter_robust %>% print()


# B. INSTANTIATE REGRESSION MODEL ----------------------------------------------------------------

model_lm <-
  linear_reg() %>% 
  set_engine('lm')

model_lm %>% print()



# C. WORKFLOW SETS ----------------------------------------------------------------
## Cross the instantiated regression model with the recipes and save as a set:

models <-
  workflow_set(
    preproc = list(
      inter = recipe_inter,
      mios_inter = recipe_mios_inter,
      regard = recipe_regard,
      mios_regard = recipe_mios_regard,
      robust_regard = recipe_mios_regard_robust,
      robust_inter = recipe_mios_inter_robust
    ),
    models = list(
      lm = model_lm
    ),
    cross = TRUE
  )

models %>% print(n = 50)
models$info

# D. FIT MODELS -------------------------------------------------------------------

## Make Bootstrapped Data Sets:
set.seed(14020)      ### Set seed for pseudo-random number generator
n_bootstraps <- 2000 ### declare number of samples to bootstrap

boots <- 
  bootstraps(data_baked,           # Use the prepared data
             times = n_bootstraps, 
             apparent = TRUE
             )


## Make functions 

### to extract workflow and fit model to bootstraps:
fit_fun <- function(split, model, ...) {
  fits <-
    models %>% 
    extract_workflow(model) %>% ### Pulls the declared model from workflow sets
    fit(analysis(split)) 
}


fit_aug <- function(fits, newdata) {
  preds <-
    fits %>% 
    extract_model() 
    broom::augment(model = ., newdata = newdata)
}


## Fit models:

### Interdepence as the outcome:
lm_inter_boot <-
  boots %>%
  mutate(fits = map(splits, ~ fit_fun(.x, model = 'inter_lm')),
         results = map(fits, ~ broom::tidy(.x)),
         fit_indices = map(fits, ~ broom::glance(.x))
         )

### Moral Injury as the outcome and interdependence as a predictor:
lm_mios_inter_boot <-
  boots %>%
  mutate(fits = map(splits, ~ fit_fun(.x, model = 'mios_inter_lm')),
         results = map(fits, ~ broom::tidy(.x)),
         fit_indices = map(fits, ~ broom::glance(.x))
  )


### Private Regard as the outcome:
lm_regard_boot <-
  boots %>%
  mutate(fits = map(splits, ~ fit_fun(.x, model = 'regard_lm')),
         results = map(fits, ~ broom::tidy(.x)),
         fit_indices = map(fits, ~ broom::glance(.x))
  )

### Moral Injury Symptoms as the outcome as private regard as a predictor:
lm_mios_regard_boot <-
  boots %>%
  mutate(fits = map(splits, ~ fit_fun(.x, model = 'mios_regard_lm')),
         results = map(fits, ~ broom::tidy(.x)),
         fit_indices = map(fits, ~ broom::glance(.x))
  )



### Moral Injury Symptoms ROBUST as the outcome as private regard as a predictor:
lm_robust_regard_boot <-
  boots %>%
  mutate(fits = map(splits, ~ fit_fun(.x, model = 'robust_regard_lm')),
         results = map(fits, ~ broom::tidy(.x)),
         fit_indices = map(fits, ~ broom::glance(.x))
  )


### Moral Injury as the outcome and interdependence as a predictor:
lm_robust_inter_boot <-
  boots %>%
  mutate(fits = map(splits, ~ fit_fun(.x, model = 'robust_inter_lm')),
         results = map(fits, ~ broom::tidy(.x)),
         fit_indices = map(fits, ~ broom::glance(.x))
  )



# E. SAVE RESULTS ---------------------------------------------------------

## Bind the results together:
boot_output <- 
  bind_rows(
    lm_inter_boot %>% mutate(model = 'lm_inter', mediation = 'inter'),
    lm_mios_inter_boot %>% mutate(model = 'lm_mios_inter', mediation = 'inter'),
    lm_regard_boot %>% mutate(model = 'lm_regard', mediation = 'regard'),
    lm_mios_regard_boot %>% mutate(model = 'lm_mios_regard', mediation = 'regard'),
    lm_robust_regard_boot %>% mutate(model = 'lm_robust_regard', mediation = 'regard'),
    lm_robust_inter_boot %>% mutate(model = 'lm_robust_inter', mediation = 'inter'),
  )

### Add predictions
boot_output$preds <-
  boot_output$fits[1:nrow(boot_output)] %>% 
  map(~ extract_model(.x)) %>% 
  map(~ broom::augment(.x, data = data_baked, se_fit = TRUE))
