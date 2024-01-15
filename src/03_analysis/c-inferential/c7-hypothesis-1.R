# HYPOTHESIS 1

## Moral injury symptoms predict greater challenges with reintegration, 
##  even when controlling for PTSD and other factors that could 
##  affect reintegration (i.e., - sex, race, combat deployment, 
##  officer/enlisted status, years of service, years of separation). 

# METHOD:
## Hierarchical regression

data %>% 
  mutate(
    race_lump = fct_lump_prop(race, prop = .05)
  ) %>% count(race_lump)

# Null Model --------------------------------------------------------------
model_0 <- data %>% lm(m2cq_mean ~ 1, .)

# Model 1 -----------------------------------------------------------------
## Total Effect of Moral Injury on Reintegration
model_1 <- 
  data %>% 
  lm(m2cq_mean ~ 
       military_exp_combat +
       sex_male +
       race_white +
       race_black +
       highest_rank_numeric +
       years_separation +
       years_service +
       discharge_other + discharge_medical +
       unmet_needs_any, 
     .)

# Model 2 -----------------------------------------------------------------
## Add PTSD as a covariate
model_2 <- 
  data %>% 
  lm(m2cq_mean ~ 
       ptsd_positive_screen + 
       military_exp_combat +
       sex_male +
       race_white +
       race_black +
       highest_rank_numeric +
       years_separation +
       years_service +
       discharge_other + discharge_medical +
       unmet_needs_any, 
     .)

# Model 3 -----------------------------------------------------------------
## Add moral injury symptoms
model_3 <-
  data %>% 
  lm(m2cq_mean ~ 
       mios_total +
       ptsd_positive_screen +
       military_exp_combat +
       sex_male +
       race_white +
       race_black +
       highest_rank_numeric +
       years_separation +
       years_service +
       discharge_other + discharge_medical +
       unmet_needs_any, 
     .)

# Model: Bivariate -----------------------------------------------------------------
## Bivariate Regression
model_bivariate <-data %>% lm(m2cq_mean ~ mios_total, .)


# Results -----------------------------------------------------------------
model_0_results <- model_0 %>% lm.beta::lm.beta() %>% summary()
model_1_results <- model_1 %>% lm.beta::lm.beta() %>% summary()
model_2_results <- model_2 %>% lm.beta::lm.beta() %>% summary()
model_3_results <- model_3 %>% lm.beta::lm.beta() %>% summary()
model_bivariate_results <- model_bivariate %>% lm.beta::lm.beta() %>% summary()

model_0_results %>% print()
model_1_results %>% print()
model_2_results %>% print()
model_3_results %>% print()
model_bivariate_results %>% print()


# Save Results: Coefficients -------------------------------------------------------------------------

hierarchical_regression <-
  model_0 %>% 
    lm.beta::lm.beta() %>% 
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    mutate(model = "0. Null") %>% 
  bind_rows(
  model_1 %>% 
    lm.beta::lm.beta() %>% 
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    mutate(model = "1. Covariates")
  ) %>% 
  bind_rows(
  model_2 %>% 
    lm.beta::lm.beta() %>% 
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    mutate(model = "2. PTSD")
  ) %>% 
  bind_rows(
  model_3 %>% 
    lm.beta::lm.beta() %>%
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    mutate(model = '3. Moral Injury')
  ) %>% 
  bind_rows(
    model_bivariate %>% 
      lm.beta::lm.beta() %>%
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = 'Bivariate')
  )


## Print:
hierarchical_regression %>% print(n = 100)

# Write to CSV in output folder -------------------------------------------

hierarchical_regression %>% 
  mutate(across(c(estimate, std_estimate, std.error, conf.low, conf.high, statistic), ~ round(.x, 3))
  ) %>% 
  #mutate(p.value = round(p.value, digits = 4)) %>% 
  write_csv(here::here('output/results/c7-hierarchical-regression.csv'))

# Message:
if(exists('hierarchical_regression')) message('Results of hierarchical regression analysis saved as `output/results/c7-hierarchical-regression.csv`')

# Clean Up
rm(hierarchical_regression)
 
