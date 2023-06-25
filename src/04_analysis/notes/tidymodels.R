

library(tidymodels)


# Split the Data to Training and Testing -------------------------------------
set.seed(2075)
data_split <- rsample::initial_split(data,            # Original data.
                                     prop = 3/4       # Percentage split.
)

# Create data frames for the two sets:
data_train <- rsample::training(data_split)
data_test  <- rsample::testing(data_split)

# Split Cross Validation: Folds -------------------------------------------------------
set.seed(23456)
data_folds <- rsample::vfold_cv(data_train,     # Always with the training data. Testing data is reserved for the very end. 
                                v = 10          # Number of folds.
)

recipe_total <- 
  
  # First add the data (you can also add a formula here)
  recipes::recipe(data) %>% 
  
  # Update Roles: Independent variables
  recipes::update_role(
  
    mios_total,
    mios_ptsd_symptoms_total,
    bipf_total,
    sex,
    race_asian, race_native, race_black, race_latino, race_white,
    branch_army, branch_air_force, branch_marines, branch_navy,
    highest_rank,
    years_separation,
    service_era_vietnam, service_era_persian_gulf, service_era_post_911,
  
  new_role = "predictor") %>%
  
  # Assign the Y dependent:
  recipes::update_role(wis_total, new_role = "outcome") %>% 
  
  # Transformations
  recipes::step_inverse(bipf_total) %>% 
  recipes::step_interact(terms = ~ mios_total:mios_ptsd_symptoms_total)

recipe_connection <- 
  
  # First add the data (you can also add a formula here)
  recipes::recipe(data) %>% 
  
  # Update Roles: Independent variables
  recipes::update_role(
    
    mios_total,
    mios_ptsd_symptoms_total,
    bipf_total,
    sex,
    race_asian, race_native, race_black, race_latino, race_white,
    branch_army, branch_air_force, branch_marines, branch_navy,
    highest_rank,
    years_separation,
    service_era_vietnam, service_era_persian_gulf, service_era_post_911,
    
    new_role = "predictor") %>%
  
  # Assign the Y dependent:
  recipes::update_role(wis_connection_total, new_role = "outcome") %>% 
  
  # Transformations
  recipes::step_inverse(bipf_total) %>% 
  recipes::step_interact(terms = ~ mios_total:mios_ptsd_symptoms_total)

## 2. Linear Regression
model_lm <- parsnip::linear_reg() %>% parsnip::set_engine("lm")


# Model 0: Null Model ------------------------------------------------------------

model_0 <-
  model_lm %>%
  fit(wis_total ~
        1, 
      data = data)
model_0 %>% broom::tidy()



# Model 1: Bivariate ------------------------------------------------------
model_1 <-
  model_lm %>%
  fit(wis_total ~
        mios_total, 
      data = data)
model_1 %>% broom::tidy()


# Model 2: Confounders  ---------------------------------------------------------------
model_2 <-
  model_lm %>%
  fit(wis_total ~
        mios_total +
        mios_ptsd_symptoms_total +
        bipf_total, 
      data = data)
model_2 %>% broom::tidy()

# Model 2b: Confounders + Interaction ---------------------------------------------------------------
model_2b <-
  model_lm %>%
  fit(wis_total ~
        mios_total +
        mios_ptsd_symptoms_total +
        mios_total:mios_ptsd_symptoms_total +
        bipf_total, 
      data = data)
model_2b %>% broom::tidy()

# Model 2c: Confounders + Interaction + Inverse ---------------------------------------------------------------
model_2c <-
  model_lm %>%
  recipes::step_inverse(bipf_total) %>% 
  fit(wis_total ~
        mios_total +
        mios_ptsd_symptoms_total +
        mios_total:mios_ptsd_symptoms_total +
        bipf_total, 
      data = data)
  
model_2c %>% summary()
model_2c %>% broom::tidy()


# Model 3: Demographics ---------------------------------------------------
model_3 <-
  model_lm %>%
  fit(wis_total ~
        mios_total +
        mios_ptsd_symptoms_total +
        bipf_total +
        sex +
        race_asian + race_native + race_black + race_latino + race_white +
        branch_army + branch_air_force + branch_marines + branch_navy +
        highest_rank +
        years_separation +
        service_era_vietnam + service_era_persian_gulf + service_era_post_911, 
      data = data)
model_3 %>% broom::tidy()


# Model 3b: Demographics + Interaction ---------------------------------------------------------------
model_3b <-
  model_lm %>%
  recipes::step_interact(terms = ~ mios_total:mios_ptsd_symptoms_total) %>% 
  fit(wis_total ~
        mios_total +
        mios_ptsd_symptoms_total +
        bipf_total +
        sex +
        race_asian + race_native + race_black + race_latino + race_white +
        branch_army + branch_air_force + branch_marines + branch_navy +
        highest_rank +
        years_separation +
        service_era_vietnam + service_era_persian_gulf + service_era_post_911, 
      data = data)
model_3b %>% broom::tidy()


# Model 3c: Demographics + Interaction + Inverse ---------------------------------------------------------------
model_3c <-
  model_lm %>%
  fit(wis_total ~
        mios_total +
        mios_ptsd_symptoms_total +
        bipf_total +
        sex +
        race_asian + race_native + race_black + race_latino + race_white +
        branch_army + branch_air_force + branch_marines + branch_navy +
        highest_rank +
        years_separation +
        service_era_vietnam + service_era_persian_gulf + service_era_post_911, 
      data = data) %>% 
  recipes::step_inverse(bipf_total) %>% 
  recipes::step_interact(terms = ~ mios_total:mios_ptsd_symptoms_total)

model_3c %>% broom::tidy()