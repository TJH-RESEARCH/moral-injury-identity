
# Multiverse
data_multiverse <-
  data_original %>% 
  mutate(dataset_categorical = 'Original',
         dataset_number = 1) %>% 
  bind_rows(
    data_original %>% 
      filter(dataset_main == 1) %>% 
      mutate(dataset_categorical = 'Main',
             dataset_number = 2)
  ) %>% 
  bind_rows(
    data_original %>% 
      filter(dataset_simple == 1) %>% 
      mutate(dataset_categorical = 'Simple',
             dataset_number = 3)
  ) %>% 
  bind_rows(
    data_original %>% 
      filter(dataset_strict == 1) %>% 
      mutate(dataset_categorical = 'Strict',
             dataset_number = 4)
  ) %>% 
  bind_rows(
    data_original %>% 
      filter(dataset_lenient == 1) %>% 
      mutate(dataset_categorical = 'Lenient',
             dataset_number = 5)
  )


results_robust_data <- list(NULL)
source(here::here('src/03_analysis/e-robustness/fit-data/robustness-data-original.R'))
source(here::here('src/03_analysis/e-robustness/fit-data/robustness-data-simple.R'))
source(here::here('src/03_analysis/e-robustness/fit-data/robustness-data-lenient.R'))
source(here::here('src/03_analysis/e-robustness/fit-data/robustness-data-main.R'))
source(here::here('src/03_analysis/e-robustness/fit-data/robustness-data-strict.R'))

results_robust_data



# Plot --------------------------------------------------------------------


results_robust_data %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(model, data_set, fill = estimate)) +
  geom_tile() +
  scale_fill_continuous(type = 'viridis') +
  geom_text(aes(label = round(estimate, 2), color = -estimate)) +
  scale_color_continuous(type = 'viridis') +
  labs(title = 'Moral Injury: Unstandardized Coefficients')




# Plot --------------------------------------------------------------------

results_robust_data %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(model, data_set, fill = -p.value)) +
  geom_tile() +
  scale_fill_continuous(type = 'viridis') +
  geom_text(aes(label = round(p.value, 2), color = p.value)) +
  scale_color_continuous(type = 'viridis') +
  labs(title = 'Moral Injury: P Value on Coefficients')


