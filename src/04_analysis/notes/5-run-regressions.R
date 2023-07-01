
# RUN REGRESSION

# Military-Civilian Biculturalism?: 
# Bicultural Identity and the Adjustment of Separated Service Members



# Load the custom regression function -----------------------------------
source(here::here('src/01_config/functions/function-regression.R'))
source(here::here('src/01_config/functions/function-get-model-stats.R'))
source(here::here('src/01_config/functions/function-get-results.R'))

# Declare independent variables/covariates -----------------------------------
DV_blend <- 'biis_blendedness'
DV_harmony <- 'biis_harmony'
IV_wis <- c('wis_centrality_total', 
            'wis_connection_total', 
            'wis_family_total', 
            'wis_interdependent_total', 
            'wis_private_regard_total',
            'wis_public_regard_total',
            'wis_skills_total')
IV_wis_total <- 'wis_total'
IV_civ <- 'civilian_commit_total'
IV_interaction <- c('civilian_commit_total:wis_total')


# Fit Models --------------------------------------------------------------

fit_blendedness <- 
  DV_blend %>% map(\(x) lm_custom(data, x, 
                                  c(IV_wis, 
                                  IV_civ)))

fit_harmony <- 
  DV_harmony %>% map(\(x) lm_custom(data, x, 
                                    c(IV_wis, 
                                    IV_civ)))

fit_blendedness_interact <- 
  DV_blend %>% map(\(x) lm_custom(data, x, 
                                  c(IV_wis_total, 
                                    IV_civ,
                                    IV_interaction)))

fit_harmony_interact <- 
  DV_harmony %>% map(\(x) lm_custom(data, x, 
                                    c(IV_wis_total, 
                                      IV_civ,
                                      IV_interaction)))




# Get model stats ---------------------------------------------------------

model_stats <- 
  bind_rows(
    get_model_stats(fit_blendedness),
    get_model_stats(fit_harmony),
    get_model_stats(fit_blendedness_interact),
    get_model_stats(fit_harmony_interact)
  )


# Inspect Model Fit  -----------------------------------------------------
model_stats %>% arrange(desc(adj_r_squared))


# Get coefficients --------------------------------------------------------

model_results <- 
  bind_rows(
    get_results(fit_blendedness),
    get_results(fit_harmony),
    get_results(fit_blendedness_interact),
    get_results(fit_harmony_interact)
  )


# Inspect Model Coefficients ----------------------------------------------

model_results %>% select(!DV) %>% arrange(model) %>% print(n = 100)
model_results %>% select(!DV) %>% arrange(term) %>% print(n = 100)

# Which variables had the greatest standardized effect? 
model_results %>% 
  select(!c(DV, IV), estimate, std_estimate) %>% 
  arrange(model, desc(abs(std_estimate))) %>% print(n = 100)


# Which variables had a statistically significant impact? 
model_results %>% 
  filter(
         term != '(Intercept)',
         p.value <= .05
  ) %>% 
  select(!c(DV, IV), estimate, std_estimate) %>% 
  arrange(model, p.value)

