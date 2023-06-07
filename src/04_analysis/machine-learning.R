


# Hypotheses --------------------------------------------------------------

## 
# 1. Moral injury symptoms predict lower levels of private regard for the military.
# 2. Moral injury symptoms predict lower levels of public regard for the military.
# 3. Moral injury symptoms predict lower levels of connection to the military. 

## Different types of moral injury events have different effects on other facets of military identity. 
# 4. Moral injury events other predict lower levels of military interdependence than other types of moral injuries.
# 5. Moral injury events other predict lower levels of military as family than other types of moral injuries. 
# 6. Moral injuries events self predict lower levels of military centrality than other moral injury events


# The types of hypotheses I can test with these methods are
# prediction, but really prediction using one set of variables
# compared to another. i.e., just MI events vs. MI symptoms vs. both
# or MI vs. PTSD
# or MI alone vs. years service, years separated, and unmet needs
# If MI is a better predictor than the control variables,
# then that suggests it is a good standalone predictor. 
# Obviously, the full model with all posbbible predictors will perform the best
# but be less parsimonious.



# Packages ----------------------------------------------------------------
library(tidyverse)
library(tidymodels)
library(dotwhisker)
library(skimr)
library(rpart.plot)            # for visualizing a decision tree
library(vip)                   # for variable importance plots


data <- data.frame(data)

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


# Recipe -------------------------------------------------------------------
recipe_mios_event_mcarm <- 
  
  # First add the data (you can also add a formula here)
  recipes::recipe(data) %>% 
  
  # Then update the roles of variables. Everything but the outcome is predictor.
  recipes::update_role(mios_event_type, new_role = "predictor") %>%
  
  # Then update the roles of variables. Assign the Y dependent:
  recipes::update_role(mcarm_total, new_role = "outcome") %>% 
  
  # Also, how the variables should be coded and fit to the model.
  recipes::step_dummy(all_factor_predictors()) %>% 
  recipes::step_zv(all_numeric(), all_factor(), all_string()) %>% 
  recipes::step_corr(all_predictors()) %>% 
  recipes::step_normalize(all_numeric())

recipe_mios_symptoms_mcarm <- 
  
  # First add the data (you can also add a formula here)
  recipes::recipe(data) %>% 
  
  # Then update the roles of variables. Everything but the outcome is predictor.
  recipes::update_role(c(mios_shame, 
                         mios_trust), new_role = "predictor") %>%
  
  # Then update the roles of variables. Assign the Y dependent:
  recipes::update_role(mcarm_total, new_role = "outcome") %>% 
  recipes::step_zv(all_numeric(), all_factor(), all_string()) %>% 
  recipes::step_corr(all_predictors()) %>% 
  recipes::step_normalize(all_numeric())


recipe_controls_mcarm <- 
  
  # First add the data (you can also add a formula here)
  recipes::recipe(data) %>% 
  
  # Then update the roles of variables. Everything but the outcome is predictor.
  recipes::update_role(c(unmet_needs_total, 
                         years_service,
                         years_separation,
                         reserve,
                         highest_rank,
                         military_family_total), new_role = "predictor") %>%
  
  # Then update the roles of variables. Assign the Y dependent:
  recipes::update_role(mcarm_total, new_role = "outcome") %>% 
  
  # Also, how the variables should be coded and fit to the model.
  recipes::step_dummy(all_factor_predictors(), all_ordered_predictors()) %>% 
  recipes::step_zv(all_numeric(), all_factor(), all_string()) %>% 
  recipes::step_corr(all_predictors()) %>% 
  recipes::step_normalize(all_numeric())

recipe_ptsd_mcarm <- 
  
  # First add the data (you can also add a formula here)
  recipes::recipe(data) %>% 
  
  # Then update the roles of variables. Everything but the outcome is predictor.
  recipes::update_role(mios_ptsd_symptoms_total, new_role = "predictor") %>%
  
  # Then update the roles of variables. Assign the Y dependent:
  recipes::update_role(mcarm_total, new_role = "outcome") %>% 
  
  # Also, how the variables should be coded and fit to the model.
  recipes::step_dummy(all_factor_predictors()) %>% 
  recipes::step_zv(all_numeric(), all_factor(), all_string()) %>% 
  recipes::step_corr(all_predictors()) %>% 
  recipes::step_normalize(all_numeric())

recipe_mios_ptsd_mcarm <- 
  
  # First add the data (you can also add a formula here)
  recipes::recipe(data) %>% 
  
  # Then update the roles of variables. Everything but the outcome is predictor.
  recipes::update_role(c(mios_shame, 
                         mios_trust,
                         mios_event_type,
                         mios_ptsd_symptoms_total), new_role = "predictor") %>%
  
  # Then update the roles of variables. Assign the Y dependent:
  recipes::update_role(mcarm_total, new_role = "outcome") %>% 
  
  # Also, how the variables should be coded and fit to the model.
  recipes::step_dummy(all_factor_predictors()) %>% 
  recipes::step_zv(all_numeric(), all_factor(), all_string()) %>% 
  recipes::step_corr(all_predictors()) %>% 
  recipes::step_normalize(all_numeric())

recipe_full_mcarm <- 
  
  # First add the data (you can also add a formula here)
  recipes::recipe(data) %>% 
  
  # Then update the roles of variables. Everything but the outcome is predictor.
  recipes::update_role(c(mios_shame, 
                         mios_trust,
                         mios_event_type,
                         mios_ptsd_symptoms_total,
                         unmet_needs_total, 
                         years_service,
                         years_separation,
                         reserve,
                         highest_rank,
                         military_family_total), new_role = "predictor") %>%
  
  # Then update the roles of variables. Assign the Y dependent:
  recipes::update_role(mcarm_total, new_role = "outcome") %>% 
  
  # Also, how the variables should be coded and fit to the model.
  recipes::step_dummy(all_factor_predictors(), all_ordered_predictors()) %>% 
  recipes::step_zv(all_numeric(), all_factor(), all_string()) %>% 
  recipes::step_corr(all_predictors()) %>% 
  recipes::step_normalize(all_numeric())


# Prepare and bake the recipe. This shows you what the data 
recipe_mios_event_mcarm %>% 
  recipes::prep() %>% 
  recipes::bake(new_data = NULL)

recipe_mios_symptoms_mcarm %>% 
  recipes::prep() %>% 
  recipes::bake(new_data = NULL)

recipe_mios_ptsd_mcarm %>% 
  recipes::prep() %>% 
  recipes::bake(new_data = NULL)

recipe_controls_mcarm %>% 
  recipes::prep() %>% 
  recipes::bake(new_data = NULL)

recipe_ptsd_mcarm %>% 
  recipes::prep() %>% 
  recipes::bake(new_data = NULL)

recipe_full_mcarm %>% 
  recipes::prep() %>% 
  recipes::bake(new_data = NULL)


# Model Specifications -------------------------------------------------------------------
# To see all available models:
# https://www.tidymodels.org/find/parsnip/

## 1. Elastic Net Regression
model_glm <- 
  parsnip::linear_reg(penalty = tune(),     # The lambda, or the degree to which it should NOT fit the training data.
                      mixture = tune()      # The mixture of ridge and lasso regression. 1 = pure lasso, 0 = pure ridge.
  ) %>% 
  parsnip::set_engine("glmnet")

## 2. Linear Regression
model_lm <- 
  parsnip::linear_reg() %>% 
  parsnip::set_engine("lm")

## 3. Decision Tree Regression
model_tree <- 
  decision_tree(
    cost_complexity = tune(),    # Penalty applied to trees for being more complex.
    tree_depth = tune()          # How many branches of the tree.
  ) %>% 
  set_engine("rpart") %>% 
  set_mode("regression")

## 4. XG Boost Regression
model_xgboost <- 
  boost_tree(
    tree_depth = tune(), 
    learn_rate = tune(), 
    loss_reduction = tune(), 
    min_n = tune(), 
    sample_size = tune(), 
    trees = tune()
  ) %>% 
  set_engine("xgboost") %>% 
  set_mode("regression")

## 5. Random Forest Regression
model_rforest <- 
  parsnip::rand_forest(mode = 'regression',
                       mtry = tune()   # Number of randomly sampled predictors
  ) %>% 
  parsnip::set_engine("randomForest", importance = TRUE) # importance = T to extract variable importance later.

## 6. Neural Network
model_nnet <- 
  parsnip::mlp(hidden_units = tune(), 
               penalty = tune(), 
               epochs = tune()
  ) %>% 
  set_engine("nnet", 
             MaxNWts = 2600
  ) %>% 
  set_mode("regression")

## 7. Support Vector Machine R
model_svm_r <- 
  svm_rbf(
    cost = tune(), 
    rbf_sigma = tune()
  ) %>% 
  set_engine("kernlab") %>% 
  set_mode("regression")


# Workflow Set ------------------------------------------------------------
workflow_set <- 
  workflow_set(
    preproc = list("event_mcarm" = recipe_mios_event_mcarm,
                   "symptoms_mcarm" = recipe_mios_symptoms_mcarm,
                   "ptsd_mcarm" = recipe_ptsd_mcarm,
                   "mios_ptsd_mcarm" = recipe_mios_ptsd_mcarm,
                   "controls_mcarm" = recipe_controls_mcarm,
                   "full_mcarm" = recipe_full_mcarm
                   ),
    models = list('glm' = model_glm, 
                  'lm' = model_lm,
                  'tree' = model_tree,
                  'boost' = model_xgboost,
                  'forest' = model_rforest,
                  'nnet' = model_nnet,
                  'svm' = model_svm_r),
    cross = TRUE 
  )


# Tuning and Racing -------------------------------------------------------

library(finetune)
race_ctrl <-
  control_race(
    save_pred = TRUE,
    allow_par = TRUE,
    parallel_over = NULL,   # Automatically chooses between 'everything' and 'resamples.'
    save_workflow = TRUE
  )



#system.time(                   # Check the time it takes to compute Racing. 
workflow_set_tune <-
  workflow_set %>% 
  workflowsets::workflow_map(
    fn = "tune_race_anova",
    # Parameters to pass to 'tune_race_anova'
    seed = 87352,
    resamples = data_folds,
    grid = 10,
    control = race_ctrl)
#)
workflow_set_tune %>% print(n = 100)
workflow_set_tune <- workflow_set_tune[-19,]
workflow_set_tune <- workflow_set_tune[-15,]

workflow_set_tune %>% print(n = 100)

autoplot(
  workflow_set_tune,
  rank_metric = "rsq",  
  metric = "rsq",
  select_best = TRUE    
)

autoplot(
  workflow_set_tune,
  rank_metric = "rmse",  
  metric = "rmse",       
  select_best = TRUE    
)

# View workflows arranged for best predictions
workflow_set_tune %>%
  workflowsets::collect_metrics() %>%
  dplyr::filter(.metric == 'rsq') %>% 
  dplyr::arrange(desc(mean)) %>% print(n = 100)


# Get the best workflow ---------------------------------------------------
# RMSE average deviation of the estimates from the observed values
# RSQ is scaled between 0 and 1. R-Squared

workflow_best_id <-                      # This is the best recipe + model. 
  workflow_set_tune %>%
  workflowsets::collect_metrics() %>%
  dplyr::filter(.metric == 'rsq') %>% 
  dplyr::arrange(desc(mean)) %>%        # Sorting from highest R-Squared to lowest.
  dplyr::slice(1) %>%                   # Then select the highest row,
  dplyr::pull(wflow_id)                 # and pull out the workflow ID.

# With the best workflow ID, then extract the workflow from the Workflow Set.
workflow_best_model <- workflow_set_tune %>% workflowsets::extract_workflow(workflow_best_id)

# Extract Tuning Results  -------------------------------------------------
# Now extract the best tune.
workflow_best_tune <- workflow_set_tune[workflow_set_tune$wflow_id == workflow_best_id, "result"][[1]][[1]]
workflow_best_tune %>% autoplot()

# In prior attemps, I used 'show_best' and 'select_best' on the wrong data
# structure and got an error, on 'workflow_set_tune' instead of 'workflow_best_tune'. 
# When used on this table of 'extracted' tunes, it works.
workflow_best_tune %>% show_best('rsq')
workflow_best_tune_final <- workflow_best_tune %>% select_best('rsq')

# In sum, the best recipe + model was 


# Finalizing Workflow -----------------------------------------------------
## Now that we have the best workflow and its hyperparameters, we finalize it.
## That means we update the model to include the best parameters, as identified
## by the tuning. 
workflow_final <- 
  workflow_best_model %>% 
  finalize_workflow(workflow_best_tune_final)


# Final training + Testing ------------------------------------------------
# last_fit() fits the finalized model on the full training data set 
# and evaluates the finalized model on the testing data (so you pass the 
# split data to it, not just the testing or training data).
fit_final <- 
  workflow_final %>%
  last_fit(data_split)


# Get metrics on the final fit --------------------------------------------
fit_final %>%
  collect_metrics()
# This model explains about 94% of the variance in the Highway MPG!
# looking for lowest RMSE, highest RSq (Rsq is scaled 0-1)


# Predict -----------------------------------------------------------------
# This is the predicted values combined with the observed values in the TEST data. 
# The '.row' indicates the row of the observed value in the original data.
fit_test <- 
  fit_final %>%
  collect_predictions()   
fit_test

# Bind the final predictions to the original test data --------------------
fit_test %>% 
  dplyr::bind_cols(data_test %>% select(-mcarm_total)) %>% 
  
  # Plot final fit ----------------------------------------------------------
ggplot2::ggplot(aes(mcarm_total, .pred)) + 
  ggplot2::geom_smooth(method = 'lm', se = F) + 
  ggplot2::geom_point(alpha = .15) +
  ggplot2::theme_classic() +
  scale_color_discrete()


# Extract the Model Summary -----------------------------------------------
workflowsets::extract_fit_parsnip(fit_final) %>% broom::tidy()

