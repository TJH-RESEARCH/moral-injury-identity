

# Load the custom regression function -----------------------------------
source(here::here('src/04_analysis/manuscript-1/function-regression.R'))
source(here::here('src/04_analysis/manuscript-1/function-get-model-stats.R'))
source(here::here('src/04_analysis/manuscript-1/function-get-results.R'))

# Declare independent variables/covariates -----------------------------------
DVs <- c('wis_total', 'wis_centrality_total', 'wis_connection_total', 'wis_family_total', 'wis_interdependent_total', 'wis_private_regard_total', 'wis_public_regard_total', 'wis_skills_total')
IV_treatment <- c('mios_total')
IV_adjustment_set_1 <- c('service_era', 'mios_ptsd_symptoms_total', 'sex')
IV_adjustment_set_2 <- c('mios_screener', 'mios_ptsd_symptoms_total', 'mios_criterion_a')
IV_neutral_controls <- c('years_service', 
                         'branch_air_force',
                         'branch_marines',
                         'branch_navy',
                         'race_white', 
                         'military_family')
IV_mediators <- c('bipf_total')





# Fit Models --------------------------------------------------------------

fit_treatment <- 
  DVs %>% map(\(x) lm_custom(data, x, IV_treatment))

fit_set_1 <- DVs %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment, IV_adjustment_set_1)))

#fit_set_2 <- DVs %>% map(\(x) lm_custom(data, x, c(IV_treatment, IV_adjustment_set_2)))

fit_set_1_controls <- DVs %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment, 
                                IV_adjustment_set_1,
                                IV_neutral_controls)))

#fit_set_2_controls <- DVs %>% map(\(x) lm_custom(data, x, c(IV_treatment, IV_adjustment_set_2, IV_neutral_controls)))

fit_set_1_controls_mediate <- DVs %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment, 
                                IV_adjustment_set_1,
                                IV_neutral_controls,
                                IV_mediators)))




# Get model stats ---------------------------------------------------------

model_stats <- 
  bind_rows(
    get_model_stats(fit_treatment),
    get_model_stats(fit_set_1),
    get_model_stats(fit_set_1_controls),
    get_model_stats(fit_set_1_controls_mediate)
  )


# Inspect Model Stats -----------------------------------------------------
model_stats %>% 
  arrange(DV, desc(r_squared)) %>% print(n = 100)
model_stats  %>% 
  arrange(DV, desc(adj_r_squared)) %>% print(n = 100)


# Get coefficients --------------------------------------------------------

model_results <- 
  bind_rows(
    get_results(fit_treatment),
    get_results(fit_set_1),
    get_results(fit_set_1_controls),
    get_results(fit_set_1_controls_mediate)
  )


# Inspect Model Coefficients ----------------------------------------------

model_results  %>% 
  arrange(DV, model) %>% print(n = 1000)

model_results %>% 
  filter(term == 'mios_total') %>% 
  #arrange(estimate) %>% 
  arrange(std_estimate) %>% 
  select(DV, model, estimate, std_estimate) %>% 
  print(n = 1000)


model_results %>% 
  filter(model == 'set_1_controls',
         #DV == 'total',
         term == 'mios_total'
         ) %>% 
  select(!c(model, IV), estimate, std_estimate) %>% 
  print(n = 1000)





