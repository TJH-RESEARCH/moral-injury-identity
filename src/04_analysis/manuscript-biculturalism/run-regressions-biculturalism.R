

# Load the custom regression function -----------------------------------
source(here::here('src/04_analysis/manuscript-moral-injury-identity-wound/function-regression.R'))
source(here::here('src/04_analysis/manuscript-moral-injury-identity-wound/function-get-model-stats.R'))
source(here::here('src/04_analysis/manuscript-moral-injury-identity-wound/function-get-results.R'))

# Declare independent variables/covariates -----------------------------------
DV_mcarm <- c('mcarm_total')
DV_blend <- c('biis_blendedness')
DV_harm <-  c('biis_harmony')

IV_treatment <- c('biis_harmony', 'biis_blendedness')
IV_adjustment_set_1 <- c('wis_total', 'civilian_commit_total')
IV_neutral_controls <- c('employment_unemployed', 
                         'disability_percent',
                         'education_num')
IV_mios_ptsd <- c('mios_ptsd_symptoms_none', 'mios_total')
IV_interact <- c('wis_total:civilian_commit_total')
IV_mediators <- c('scc_total')



# Fit Models --------------------------------------------------------------

fit_treatment <- 
  DV_mcarm %>% 
    map(\(x) lm_custom(data, x, IV_treatment))

fit_set <- 
  DV_mcarm %>% 
    map(\(x) lm_custom(data, x, c(IV_treatment, IV_adjustment_set_1)))

fit_controls <- 
  DV_mcarm %>% 
    map(\(x) lm_custom(data, x, c(IV_treatment, 
                                IV_adjustment_set_1,
                                IV_neutral_controls)))

fit_interact <- 
  DV_mcarm %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment, 
                                IV_adjustment_set_1,
                                IV_interact,
                                IV_neutral_controls)))
fit_mios <- 
  DV_mcarm %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment, 
                                IV_mios_ptsd,
                                IV_adjustment_set_1,
                                IV_neutral_controls)))

fit_mios_interact <- 
  DV_mcarm %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment, 
                                IV_mios_ptsd,
                                IV_adjustment_set_1,
                                IV_interact,
                                IV_neutral_controls)))


fit_mediate <- 
  DV_mcarm %>% 
    map(\(x) lm_custom(data, x, c(IV_treatment, 
                                  IV_mios_ptsd,
                                  IV_adjustment_set_1,
                                  IV_neutral_controls,
                                  IV_mediators)))

fit_mediate_interact <- 
  DV_mcarm %>% 
  map(\(x) lm_custom(data, x, c(IV_treatment, 
                                IV_mios_ptsd,
                                IV_adjustment_set_1,
                                IV_interact,
                                IV_neutral_controls,
                                IV_mediators)))

fit_harm <- 
  DV_harm %>% 
  map(\(x) lm_custom(data, x, c(IV_adjustment_set_1)))

fit_harm_interact <- 
  DV_harm %>% 
  map(\(x) lm_custom(data, x, c(IV_adjustment_set_1, 
                                IV_interact)))

fit_blend <- 
  DV_blend %>% 
  map(\(x) lm_custom(data, x, c(IV_adjustment_set_1)))

fit_blend_interact <- 
  DV_blend %>% 
  map(\(x) lm_custom(data, x, c(IV_adjustment_set_1, 
                                IV_interact)))



# Get model stats ---------------------------------------------------------

model_stats <- 
  bind_rows(
    get_model_stats(fit_treatment),
    get_model_stats(fit_set),
    get_model_stats(fit_controls),
    get_model_stats(fit_mios),
    get_model_stats(fit_mios_interact),
    get_model_stats(fit_mediate),
    get_model_stats(fit_mediate_interact),
    get_model_stats(fit_harm),
    get_model_stats(fit_harm_interact),
    get_model_stats(fit_blend),
    get_model_stats(fit_blend_interact)
  )

# Inspect Model Stats -----------------------------------------------------
model_stats %>% 
  arrange(DV, desc(r_squared)) %>% 
  select(!c(IV))

model_stats  %>% 
  arrange(DV, desc(adj_r_squared))

# Which set of predictors is performing the best?
model_stats %>% 
  group_by(model) %>% 
  summarise(mean_r_sq = mean(r_squared),
            mean_adj_r_sq = mean(adj_r_squared)) %>% 
  arrange(desc(mean_adj_r_sq))

model_stats  %>% 
  filter(model == 'mediate' | model ==  'harm' | model == 'blend') %>% 
  arrange(desc(adj_r_squared))



# Get coefficients --------------------------------------------------------

model_results <- 
  bind_rows(
    get_results(fit_treatment),
    get_results(fit_set),
    get_results(fit_controls),
    get_results(fit_mios),
    get_results(fit_mios_interact),
    get_results(fit_mediate),
    get_results(fit_mediate_interact),
    get_results(fit_harm),
    get_results(fit_harm_interact),
    get_results(fit_blend),
    get_results(fit_blend_interact)
  )

# Inspect Model Coefficients ----------------------------------------------

model_results  %>% 
  arrange(model) %>% print(n = 100)

model_results  %>% 
  filter(model == 'mediate_interact') %>% 
  arrange(DV, model)

model_results  %>% 
  filter(DV == 'biis_harmony') %>% 
  arrange(model)

model_results  %>% 
  filter(DV == 'biis_harmony') %>% 
  arrange(model)

model_results  %>% 
  filter(model == 'blend') %>% 
  arrange(DV, model)

model_results  %>% 
  filter(model == 'blend_interact') %>% 
  arrange(DV, model)

model_results %>% 
  filter(term == 'biis_harmony') %>% 
  #arrange(estimate) %>% 
  arrange(std_estimate) %>% 
  select(DV, term, model, estimate, std_estimate, p.value)


# Which variables had the greatest standardized effect? 
model_results %>% 
  filter(model == 'mediate',
         #term == 'mios_total'
         ) %>% 
  select(!c(model, IV), estimate, std_estimate) %>% 
  arrange(DV, desc(abs(std_estimate)))


# Which variables had a statistically significant impact? 
model_results %>% 
  filter(model == 'mediate',
         term != '(Intercept)',
         p.value <= .05
  ) %>% 
  select(!c(model, IV), estimate, std_estimate) %>% 
  arrange(DV, p.value) %>% 
  print(n = 1000)
