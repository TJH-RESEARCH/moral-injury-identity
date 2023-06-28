

# Load the custom regression function -----------------------------------
source(here::here('src/04_analysis/manuscript-1/function-regression.R'))
source(here::here('src/04_analysis/manuscript-1/function-get-model-stats.R'))
source(here::here('src/04_analysis/manuscript-1/function-get-results.R'))

# Declare independent variables/covariates -----------------------------------
DVs <- c('wis_total', 'wis_centrality_total', 'wis_connection_total', 'wis_family_total', 'wis_interdependent_total', 'wis_private_regard_total', 'wis_public_regard_total', 'wis_skills_total')
IV_treatment <- c('mios_total')
IV_treatment_sqrt <- c('mios_total_sqrt')
IV_adjustment_set_1 <- c('mios_ptsd_symptoms',
                         'service_era_persian_gulf',
                         'service_era_post_911',
                         'service_era_vietnam',
                         'sex')
IV_adjustment_set_2 <- c('mios_screener', 
                         'mios_ptsd_symptoms', 
                         'mios_criterion_a')
IV_neutral_controls <- c('branch_air_force',
                         'branch_marines',
                         'branch_navy',
                         'race_white', 
                         'military_family',
                         'years_service',
                         'years_separation')
# Job like the military should also be included, but it wasn't
# measured for much of the sample.

# There may be some increase in precision from adding the following:
## rank, 
IV_improve_precision <- c('rank_e1_e3', 
                          'rank_e7_e9',
                          'nonenlisted'
                          )
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

fit_set_1_controls_precision <- DVs %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment, 
                                IV_adjustment_set_1,
                                IV_neutral_controls,
                                IV_improve_precision)))

fit_set_1_cntrl_prec_trans <- DVs %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment_sqrt, 
                                IV_adjustment_set_1,
                                IV_neutral_controls,
                                IV_improve_precision)))



# Get model stats ---------------------------------------------------------

model_stats <- 
  bind_rows(
    get_model_stats(fit_treatment),
    get_model_stats(fit_set_1),
    get_model_stats(fit_set_1_controls),
    get_model_stats(fit_set_1_controls_mediate),
    get_model_stats(fit_set_1_controls_precision)
  )

model_stats <- 
  bind_rows(
    get_model_stats(fit_set_1_controls_precision),
    get_model_stats(fit_set_1_cntrl_prec_trans)
)

model_stats <- 
    get_model_stats(fit_set_1_controls_precision)


# Inspect Model Stats -----------------------------------------------------
model_stats %>% 
  arrange(DV, desc(r_squared)) %>% 
  select(!c(IV, model))

model_stats  %>% 
  arrange(DV, desc(adj_r_squared)) %>% print(n = 100)
model_stats  %>% 
  arrange(desc(adj_r_squared)) %>% print(n = 100)

# Which set of predictors is performing the best?
model_stats %>% 
  group_by(model) %>% 
  summarise(mean_r_sq = mean(r_squared),
            mean_adj_r_sq = mean(adj_r_squared),
            sd_r_sq = sd(r_squared),
            sd_adj_r_sq = sd(adj_r_squared)) %>% 
  arrange(desc(mean_adj_r_sq))


model_stats  %>% 
  filter(model == 'set_1_controls_precision') %>% 
  arrange(desc(adj_r_squared)) %>% print(n = 100)



# Get coefficients --------------------------------------------------------

model_results <- 
  bind_rows(
    get_results(fit_treatment),
    get_results(fit_set_1),
    get_results(fit_set_1_controls),
    get_results(fit_set_1_controls_mediate),
    get_results(fit_set_1_controls_precision)
  )

model_results <- get_results(fit_set_1_controls_precision)

# Inspect Model Coefficients ----------------------------------------------

model_results  %>% arrange(DV, model) %>% print(n = 1000)

model_results %>% 
  filter(term == 'mios_ptsd_symptoms') %>% 
  #arrange(estimate) %>% 
  arrange(std_estimate) %>% 
  select(DV, term, estimate, std_estimate, p.value) %>% print(n = 1000)


# Which variables had the greatest standardized effect? 
model_results %>% 
  filter(model == 'set_1_controls_precision',
         DV != 'total',
         #term == 'mios_total'
         ) %>% 
  select(!c(model, IV), estimate, std_estimate) %>% 
  arrange(DV, desc(abs(std_estimate))) %>% 
  print(n = 1000)


# Which variables had a statistically significant impact? 
model_results %>% 
  filter(model == 'set_1_controls_precision',
         DV != 'total',
         term != '(Intercept)',
         p.value <= .05
  ) %>% 
  select(!c(model, IV), estimate, std_estimate) %>% 
  arrange(DV, p.value) %>% 
  print(n = 1000)

## Marines
model_results %>% 
  filter(model == 'set_1_controls_precision',
         DV != 'total',
         term == 'branch_marines'
  ) %>% 
  select(!c(model, IV), estimate, std_estimate) %>% 
  arrange(DV, desc(abs(std_estimate))) %>% 
  print(n = 1000)

## E-1 to E-3
model_results %>% 
  filter(model == 'set_1_controls_precision',
         DV != 'total',
         term == 'rank_e1_e3'
  ) %>% 
  select(!c(model, IV), estimate, std_estimate) %>% 
  arrange(DV, desc(abs(std_estimate))) %>% 
  print(n = 1000)

## PTSD Symptoms
model_results %>% 
  filter(model == 'set_1_controls_precision',
         DV != 'total',
         term == 'mios_ptsd_symptoms'
  ) %>% 
  select(!c(model, IV), estimate, std_estimate) %>% 
  arrange(DV, desc(abs(std_estimate))) %>% 
  print(n = 1000)





