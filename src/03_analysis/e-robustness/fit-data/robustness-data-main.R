
data_set <- 
  'Main'

data <- 
  data_multiverse %>% 
  filter(dataset_categorical == data_set)

# Fit modles source(here::here('src/03_analysis/d-interpret-reults/visualize-results.R'))
source(here::here('src/03_analysis/c-modelling/fit-models.R'))

# Save Results: Coefficients -------------------------------------------------------------------------

results_robust_data <-
  results_robust_data %>% 
  bind_rows(
    
model_wis_0 %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_wis_0') %>% bind_rows(
model_wis %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_wis_bivariate')
  ) %>% bind_rows(
model_wis_controls %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_wis_controls')
  ) %>% bind_rows(
model_biis_0 %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_biis_0')
  ) %>% bind_rows(
model_biis %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_biis_bivariate')
  ) %>% bind_rows(
model_biis_controls %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_biis_controls')
  ) %>% bind_rows(
model_full %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_full')
  ) %>% bind_rows(
model_full_controls %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_full_controls')
) %>% bind_rows(
model_interact %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_interact')
) %>% bind_rows(
model_interact_controls %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(data_set = data_set, model = 'model_interact_controls')
)
)