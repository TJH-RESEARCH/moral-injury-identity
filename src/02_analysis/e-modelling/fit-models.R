library(tidymodels)


# A. RECIPES ----------------------------------------------------------------------


### Identity Connection -----------------------------------------------------------------

recipe_wis <-
  recipes::recipe(wis_interdependent_total ~ 
                    mios_total +
                    pc_ptsd_positive_screen + 
                    military_exp_combat +
                    #MOS +
                    service_era_post_911 +
                    service_era_persian_gulf +
                    sex_male +
                    race_black +
                    race_white,
                  data = data) %>% 
  step_center(all_numeric_predictors()) %>% 
  step_scale(mios_total, factor = 2)

recipe_wis %>% prep(., data) 

data_baked_wis <- recipe_wis %>% prep(., data) %>% bake(., NULL)



### Identity Dissonance -----------------------------------------------------------------

recipe_biis <-
  recipes::recipe(biis_conflict ~ 
                    mios_total +
                    pc_ptsd_positive_screen + 
                    military_exp_combat +
                    #MOS +
                    service_era_post_911 +
                    service_era_persian_gulf +
                    sex_male +
                    race_black +
                    race_white,
                  data = data) %>% 
  step_center(all_numeric_predictors()) %>% 
  step_scale(mios_total, factor = 2)

recipe_biis %>% prep(., data) 

data_baked_biis <- recipe_biis %>% prep(., data) %>% bake(., NULL)



### Identity Dissonance -----------------------------------------------------------------

recipe_interact <-
  recipes::recipe(biis_conflict ~ 
                    mios_total +
                    wis_public_regard_total +
                    pc_ptsd_positive_screen + 
                    military_exp_combat +
                    #MOS +
                    service_era_post_911 +
                    service_era_persian_gulf +
                    sex_male +
                    race_black +
                    race_white,
                  data = data) %>% 
  step_center(all_numeric_predictors()) %>% 
  step_scale(mios_total, factor = 2) %>%
  step_interact(terms = ~ mios_total:wis_public_regard_total)

recipe_interact %>% prep(., data) 

data_baked_interact <- recipe_interact %>% prep(., data) %>% bake(., NULL)



# B. DEFINE MODELS ----------------------------------------------------------------

model_lm <-
  linear_reg() %>% 
  set_engine('lm')


# C. WORKFLOW SETS ----------------------------------------------------------------
models <-
  workflow_set(
    preproc = list(
      biis = recipe_biis,
      wis = recipe_wis, 
      interact = recipe_interact
    ),
    models = list(
      lm = model_lm
    ),
    cross = TRUE
  )

models %>% print(n = 50)



# D. FIT MODELS -------------------------------------------------------------------

fit_biis <- 
  models %>% 
  extract_workflow('biis_lm') %>% 
  fit(data)

fit_wis <- 
  models %>% 
  extract_workflow('wis_lm') %>% 
  fit(data)

fit_interact <- 
  models %>% 
  extract_workflow('interact_lm') %>% 
  fit(data)


# E. EXTRACT MODELS ---------------------------------------------------------------

### Total ----
fit_biis     <- fit_biis %>% parsnip::extract_fit_engine()
fit_wis      <- fit_wis %>% parsnip::extract_fit_engine()
fit_interact <- fit_interact %>% parsnip::extract_fit_engine()

