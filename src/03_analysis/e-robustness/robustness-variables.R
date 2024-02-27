





# Load the custom regression function -----------------------------------
source(here::here('src/01_config/functions/function-regression.R'))
source(here::here('src/01_config/functions/function-get-model-stats.R'))
source(here::here('src/01_config/functions/function-get-results.R'))

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





# Fit Models --------------------------------------------------------------

fit_dissonance_main <- 
  DV_dissonance_main %>% 
  map(\(x) lm_custom(data, x, IV_main))

fit_dissonance_main_controls <- 
  DV_dissonance_main %>% 
  map(\(x) lm_custom(data, x, c(IV_main, IV_controls)))

fit_dissonance_robust_DV <-
  DV_dissonance_robust %>% 
  map(\(x) lm_custom(data, x, c(IV_main)))

fit_dissonance_robust_DV_controls <-
  DV_dissonance_robust %>% 
  map(\(x) lm_custom(data, x, c(IV_main, IV_controls)))

fit_loss_main <- 
  DV_loss_main %>% 
  map(\(x) lm_custom(data, x, IV_main))

fit_loss_main_controls <- 
  DV_loss_main %>% 
  map(\(x) lm_custom(data, x, c(IV_main, IV_controls)))

fit_loss_robust_DV <-
  DV_loss_robust %>% 
  map(\(x) lm_custom(data, x, c(IV_main)))

fit_loss_robust_DV_controls <-
  DV_loss_robust %>% 
  map(\(x) lm_custom(data, x, c(IV_main, IV_controls)))

##

fit_dissonance_robust_IV <- 
  DV_dissonance_main %>% 
  map(\(x) lm_custom(data, x, IV_robust))

fit_dissonance_robust_IV_controls <- 
  DV_dissonance_main %>% 
  map(\(x) lm_custom(data, x, c(IV_robust, IV_controls)))

fit_dissonance_robust_IV_DV <-
  DV_dissonance_robust %>% 
  map(\(x) lm_custom(data, x, c(IV_robust)))

fit_dissonance_robust_IV_DV_controls <-
  DV_dissonance_robust %>% 
  map(\(x) lm_custom(data, x, c(IV_robust, IV_controls)))

fit_loss_robust_IV <- 
  DV_loss_main %>% 
  map(\(x) lm_custom(data, x, IV_robust))

fit_loss_robust_IV_controls <- 
  DV_loss_main %>% 
  map(\(x) lm_custom(data, x, c(IV_robust, IV_controls)))

fit_loss_robust_IV_DV <-
  DV_loss_robust %>% 
  map(\(x) lm_custom(data, x, c(IV_robust)))

fit_loss_robust_IV_DV_controls <-
  DV_loss_robust %>% 
  map(\(x) lm_custom(data, x, c(IV_robust, IV_controls)))


# Get model stats ---------------------------------------------------------

model_stats <- 
  bind_rows(
    get_model_stats(fit_dissonance_main),
    get_model_stats(fit_dissonance_main_controls),
    get_model_stats(fit_dissonance_robust_DV),
    get_model_stats(fit_dissonance_robust_DV_controls),
    get_model_stats(fit_loss_main),
    get_model_stats(fit_loss_main_controls),
    get_model_stats(fit_loss_robust_DV),
    get_model_stats(fit_loss_robust_DV_controls),
    get_model_stats(fit_dissonance_robust_IV),
    get_model_stats(fit_dissonance_robust_IV_controls),
    get_model_stats(fit_dissonance_robust_IV_DV),
    get_model_stats(fit_dissonance_robust_IV_DV_controls),
    get_model_stats(fit_loss_robust_IV),
    get_model_stats(fit_loss_robust_IV_controls),
    get_model_stats(fit_loss_robust_IV_DV),
    get_model_stats(fit_loss_robust_IV_DV_controls)
  )


# Inspect Model Stats -----------------------------------------------------
model_stats %>% 
  arrange(DV, desc(r_squared)) %>% print(n = 100)

model_stats %>% 
  arrange(desc(r_squared)) %>% print(n = 100)


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
    get_results(fit_dissonance_main),
    get_results(fit_dissonance_main_controls),
    get_results(fit_dissonance_robust_DV),
    get_results(fit_dissonance_robust_DV_controls),
    get_results(fit_loss_main),
    get_results(fit_loss_main_controls),
    get_results(fit_loss_robust_DV),
    get_results(fit_loss_robust_DV_controls),
    get_results(fit_dissonance_robust_IV),
    get_results(fit_dissonance_robust_IV_controls),
    get_results(fit_dissonance_robust_IV_DV),
    get_results(fit_dissonance_robust_IV_DV_controls),
    get_results(fit_loss_robust_IV),
    get_results(fit_loss_robust_IV_controls),
    get_results(fit_loss_robust_IV_DV),
    get_results(fit_loss_robust_IV_DV_controls)
  )



# Inspect Model Coefficients ----------------------------------------------

model_results  %>% arrange(DV, model) %>% print(n = 1000)

model_results %>% 
  #arrange(estimate) %>% 
  arrange(-std_estimate) %>% 
  #select(DV, term, estimate, std_estimate, p.value) %>% 
  print(n = 1000)


# Which variables had the greatest standardized effect? 
model_results %>% 
  filter(term != '(Intercept)'
  ) %>% 
  arrange(DV, desc(abs(std_estimate))) %>% 
  print(n = 1000)


# Which variables had a statistically significant impact? 
model_results %>% 
  filter(term != '(Intercept)',
         p.value <.05
  ) %>% 
  arrange(DV, desc(p.value)) %>% 
  print(n = 1000)


model_results %>% filter(term == 'mios_total') %>% 
  arrange(-p.value) %>% print(n = 1000)


