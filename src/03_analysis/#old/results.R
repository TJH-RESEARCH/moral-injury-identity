

# Results -----------------------------------------------------------------
(results_wis_0             <- model_wis_0             %>% lm.beta::lm.beta() %>% summary())
(results_wis               <- model_wis               %>% lm.beta::lm.beta() %>% summary())
(results_wis_controls      <- model_wis_controls      %>% lm.beta::lm.beta() %>% summary())
(results_biis_0            <- model_biis_0            %>% lm.beta::lm.beta() %>% summary())
(results_biis              <- model_biis              %>% lm.beta::lm.beta() %>% summary())
(results_biis_controls     <- model_biis_controls     %>% lm.beta::lm.beta() %>% summary())
(results_full              <- model_full              %>% lm.beta::lm.beta() %>% summary())
(results_full_controls     <- model_full_controls     %>% lm.beta::lm.beta() %>% summary())
(results_interact          <- model_interact          %>% lm.beta::lm.beta() %>% summary())
(results_interact_controls <- model_interact_controls %>% lm.beta::lm.beta() %>% summary())

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


