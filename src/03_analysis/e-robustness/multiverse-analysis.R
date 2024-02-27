
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








# Load the custom regression function -----------------------------------
source(here::here('src/01_config/functions/function-regression.R'))
source(here::here('src/01_config/functions/function-regression-multiverse.R'))
source(here::here('src/01_config/functions/function-get-model-stats.R'))
source(here::here('src/01_config/functions/function-get-results.R'))
source(here::here('src/01_config/functions/function-get-results-multiverse.R'))

# Declare independent variables/covariates -----------------------------------
DV_dissonance_main <- c('biis_conflict')
DV_dissonance_robust <- c('biis_blendedness', 'biis_total', 'scc_total')
DV_loss_main <- c('wis_interdependent_total')
DV_loss_robust <- c('wis_centrality_total', 'wis_connection_total', 'wis_family_total', 'wis_private_regard_total', 'wis_public_regard_total', 'wis_skills_total')
IV_main <- c('mios_total')
IV_robust <- c('mios_screener')
IV_controls <- c('military_exp_combat',
                 'pc_ptsd_positive_screen',
                 'sex_male',
                 'race_white',
                 'race_black',
                 'enlisted',
                 'years_separation',
                 'years_service'
)
IV_mediators <- c('bipf_total')





# Fit Multiverse ----------------------------------------------------------

fit_multiverse_dissonance_main <- 
  map2(.x = c(1:5), 
     .y = c(IV_main), \(x, y) lm_custom_multiverse(data_multiverse = data_multiverse,
                                        DV = c(DV_dissonance_main),
                                        data_set_number = x,
                                        IVs = y))

fit_multiverse_dissonance_main_controls <- 
  map2(.x = c(1:5), 
     .y =  c(DV_dissonance_main), \(x, y) lm_custom_multiverse(data_multiverse = data_multiverse,
                                                   DV = y,
                                                   data_set_number = x,
                                                   IVs = c(IV_main, IV_controls)))




fit_multiverse_dissonance_robust_DV_dataset1 <-
map(.x = DV_dissonance_robust, \(x, y) lm_custom_multiverse(data_multiverse = data_multiverse,
                                                              DV = x,
                                                              data_set_number = 1,
                                                              IVs = c(IV_main, IV_controls)))

fit_multiverse_dissonance_robust_DV_dataset2 <-
  map(.x = DV_dissonance_robust, \(x, y) lm_custom_multiverse(data_multiverse = data_multiverse,
                                                              DV = x,
                                                              data_set_number = 2,
                                                              IVs = c(IV_main, IV_controls)))

fit_multiverse_dissonance_robust_DV_dataset3 <-
  map(.x = DV_dissonance_robust, \(x, y) lm_custom_multiverse(data_multiverse = data_multiverse,
                                                              DV = x,
                                                              data_set_number = 3,
                                                              IVs = c(IV_main, IV_controls)))

fit_multiverse_dissonance_robust_DV_dataset4 <-
  map(.x = DV_dissonance_robust, \(x, y) lm_custom_multiverse(data_multiverse = data_multiverse,
                                                              DV = x,
                                                              data_set_number = 4,
                                                              IVs = c(IV_main, IV_controls)))

fit_multiverse_dissonance_robust_DV_dataset5 <-
  map(.x = DV_dissonance_robust, \(x, y) lm_custom_multiverse(data_multiverse = data_multiverse,
                                                              DV = x,
                                                              data_set_number = 5,
                                                              IVs = c(IV_main, IV_controls)))



fit_multiverse_dissonance_robust_DV_controls <-
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_dissonance_robust, x, c(IV_main, IV_controls))) 

fit_multiverse_loss_main <- 
  c(1:5) %>% # data set numbers
  map2(\(x, y) lm_custom_multiverse(data_multiverse, DV_loss_main, x, IV_main)) 

fit_multiverse_loss_main_controls <- 
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_loss_main, x, c(IV_main, IV_controls))) 

fit_multiverse_loss_robust_DV <-
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_loss_robust, x, IV_main)) 

fit_multiverse_loss_robust_DV_controls <-
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_loss_robust, x, c(IV_main, IV_controls))) 

##

fit_multiverse_dissonance_robust_IV <- 
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_dissonance_main, x, IV_robust)) 

fit_multiverse_dissonance_robust_IV_controls <- 
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_dissonance_main, x, c(IV_robust, IV_controls))) 

fit_multiverse_dissonance_robust_IV_DV <-
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_dissonance_robust, x, c(IV_robust))) 

fit_multiverse_dissonance_robust_IV_DV_controls <-
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_dissonance_robust, x, c(IV_robust, IV_controls))) 

fit_multiverse_loss_robust_IV <- 
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_loss_main, x, c(IV_robust))) 

fit_multiverse_loss_robust_IV_controls <- 
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_loss_main, x, c(IV_robust, IV_controls))) 

fit_multiverse_loss_robust_IV_DV <-
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_loss_robust, x, c(IV_robust))) 

fit_multiverse_loss_robust_IV_DV_controls <-
  c(1:5) %>% # data set numbers
  map(\(x) lm_custom_multiverse(data_multiverse, DV_loss_robust, x, c(IV_robust, IV_controls))) 



# Get model stats ---------------------------------------------------------

model_stats <- 
  bind_rows(
    get_model_stats(fit_dissonance_main),
    get_model_stats_multiverse(fit_dissonance_main_controls),
    get_model_stats_multiverse(fit_dissonance_robust_DV),
    get_model_stats_multiverse(fit_dissonance_robust_DV_controls),
    get_model_stats_multiverse(fit_loss_main),
    get_model_stats_multiverse(fit_loss_main_controls),
    get_model_stats_multiverse(fit_loss_robust_DV),
    get_model_stats_multiverse(fit_loss_robust_DV_controls),
    get_model_stats_multiverse(fit_dissonance_robust_IV),
    get_model_stats_multiverse(fit_dissonance_robust_IV_controls),
    get_model_stats_multiverse(fit_dissonance_robust_IV_DV),
    get_model_stats_multiverse(fit_dissonance_robust_IV_DV_controls),
    get_model_stats_multiverse(fit_loss_robust_IV),
    get_model_stats_multiverse(fit_loss_robust_IV_controls),
    get_model_stats_multiverse(fit_loss_robust_IV_DV),
    get_model_stats_multiverse(fit_loss_robust_IV_DV_controls)
  )



# Get coefficients --------------------------------------------------------

#model_results_multiverse <- 
  bind_rows(
    get_results(fit_multiverse_dissonance_main),
    get_results(fit_multiverse_dissonance_robust_DV_dataset1),
    get_results_multiverse(fit_multiverse_dissonance_robust_DV_dataset2),
    get_results_multiverse(fit_multiverse_dissonance_robust_DV_dataset3),
    get_results_multiverse(fit_multiverse_dissonance_robust_DV_dataset4),
    get_results_multiverse(fit_multiverse_dissonance_robust_DV_dataset5)
    )
  fit_multiverse_dissonance_robust_DV_dataset5
    get_results_multiverse(fit_multiverse_dissonance_main_controls)
    get_results_multiverse(fit_multiverse_loss_main),
    get_results_multiverse(fit_multiverse_loss_main_controls),
    get_results_multiverse(fit_multiverse_loss_robust_DV),
    get_results_multiverse(fit_multiverse_loss_robust_DV_controls),
    get_results_multiverse(fit_multiverse_dissonance_robust_IV),
    get_results_multiverse(fit_multiverse_dissonance_robust_IV_controls),
    get_results_multiverse(fit_multiverse_dissonance_robust_IV_DV),
    get_results_multiverse(fit_multiverse_dissonance_robust_IV_DV_controls),
    get_results_multiverse(fit_multiverse_loss_robust_IV),
    get_results_multiverse(fit_multiverse_loss_robust_IV_controls),
    get_results_multiverse(fit_multiverse_loss_robust_IV_DV),
    get_results_multiverse(fit_multiverse_loss_robust_IV_DV_controls)
  )



# Inspect Model Coefficients ----------------------------------------------

model_results_multiverse  %>% select(DV) %>% unique()
  
model_results_multiverse  %>% 
  #filter(dataset == 'Original') %>% 
  arrange(dataset, DV, model) %>% print(n = 100)

model_results_multiverse %>% 
  #arrange(estimate) %>% 
  arrange(-std_estimate) %>% 
  #select(DV, term, estimate, std_estimate, p.value) %>% 
  print(n = 100)


# Which variables had the greatest standardized effect? 
model_results_multiverse %>% 
  filter(term != '(Intercept)'
  ) %>% 
  arrange(DV, desc(abs(std_estimate))) %>% 
  print(n = 1000)


# Which variables had a statistically significant impact? 
model_results_multiverse %>% 
  filter(term != '(Intercept)',
         p.value <.05
  ) %>% 
  arrange(DV, desc(p.value)) %>% 
  print(n = 1000)


model_results_multiverse %>% filter(term == 'mios_total') %>% 
  arrange(-p.value) %>% print(n = 1000)



model_results_multiverse <-
  model_results_multiverse %>% 
  mutate(IV = 
           if_else(
             IV == 'mios_total, military_exp_combat, pc_ptsd_positive_screen, sex_male, race_white, race_black, enlisted, years_separation, years_service', 
             'mios_total + controls', 
             IV)
  ) %>% 
  mutate(IV = 
           if_else(
             IV == 'mios_screener, military_exp_combat, pc_ptsd_positive_screen, sex_male, race_white, race_black, enlisted, years_separation, years_service', 
             'mios_screener + controls', 
             IV)
  )


model_results_multiverse %>%
  mutate(significant_at_05 = factor(if_else(p.value <= .05, T, F))) %>% 
  filter(term == 'mios_total' | term == 'mios_screener') %>% 
  filter(DV == 'interdependent' |
           DV == 'centrality' |
           DV == 'connection' |
           DV == 'family' |
           DV == 'private_regard' |
           DV == 'public_regard' |
           DV == 'skills') %>% 
  ggplot(aes(std_estimate, 
             DV, 
             color = significant_at_05, 
             shape = IV)) +
  geom_point(size = 15, alpha = .8) +
  facet_wrap(~dataset) +
  scale_color_discrete(type = 'viridis') +
  labs(title = 'Moral Injury impact on Military Identity',
       subtitle = 'Comparing Symptoms and Events, with and without Controls') +
  theme_classic()



model_results_multiverse %>%   
  mutate(significant_at_05 = factor(if_else(p.value <= .05, T, F))) %>% 
  filter(term == 'mios_total' | term == 'mios_screener') %>% 
  filter(DV == 'biis' |
           DV == 'scc' |
           DV == 'biis_conflit' |
           DV == 'biis_blendedness') %>% 
  ggplot(aes(std_estimate, 
             DV, 
             color = significant_at_05, 
             shape = IV)) +
  geom_point(size = 15, alpha = .8) +
  facet_grid(~dataset) +
  scale_color_discrete(type = 'viridis') +
  labs(title = 'Moral Injury impact on Identity Dissonance',
       subtitle = 'Comparing Symptoms and Events, with and without Controls') +
  theme_classic()
