
# Save Results: Coefficients -------------------------------------------------------------------------



 
results_regression <-
  model_wis_0 %>% 
  lm.beta::lm.beta() %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  mutate(model = "0. WIS Null") %>% 
  
  bind_rows(
    model_wis_1_bivariate %>% 
      lm.beta::lm.beta() %>% 
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = "1. WIS Bivariate")
  ) %>% 
  
  bind_rows(
    model_wis_2_adjust %>% 
      lm.beta::lm.beta() %>% 
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = "2. WIS Adjusted")
  ) %>% 
  
  bind_rows(
    model_wis_3b1_crit %>% 
      lm.beta::lm.beta() %>%
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = '3b1. WIS Critical Incident')
  ) %>% 
  
  bind_rows(
    model_wis_3c1_proxy %>% 
      lm.beta::lm.beta() %>%
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = '3c1. WIS Proxy')
  ) %>% 
  
  bind_rows(
    model_wis_4b1_controls %>% 
      lm.beta::lm.beta() %>%
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = '4b1. WIS Controls')
  ) %>% 
  
  bind_rows(

  model_biis_0 %>% 
    lm.beta::lm.beta() %>% 
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    mutate(model = "0. BIIS Null")
  ) %>% 
  
  bind_rows(
    model_biis_1_bivariate %>% 
      lm.beta::lm.beta() %>% 
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = "1. BIIS Bivariate")
  ) %>% 
  
  bind_rows(
    model_biis_2_adjust %>% 
      lm.beta::lm.beta() %>% 
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = "2. BIIS Adjusted")
  ) %>% 
  
  bind_rows(
    model_biis_3b1_crit %>% 
      lm.beta::lm.beta() %>%
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = '3b1. BIIS Critical Incident')
  ) %>% 
  
  bind_rows(
    model_biis_3c1_proxy %>% 
      lm.beta::lm.beta() %>%
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = '3c1. BIIS Proxy')
  ) %>% 
  
  bind_rows(
    model_biis_4b1_controls %>% 
      lm.beta::lm.beta() %>%
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = '4b1. BIIS Controls')
  ) %>% 
  bind_cols(

  bind_rows(
  coeftest_wis_0 %>% broom::tidy(),
  coeftest_wis_1_bivariate %>% broom::tidy(),
  coeftest_wis_2_adjust %>% broom::tidy(),
  coeftest_wis_3b1_crit %>% broom::tidy(),
  coeftest_wis_3c1_proxy %>% broom::tidy(),
  coeftest_wis_4b1_controls %>% broom::tidy(),
  coeftest_biis_0 %>% broom::tidy(),
  coeftest_biis_1_bivariate %>% broom::tidy(),
  coeftest_biis_2_adjust %>% broom::tidy(),
  coeftest_biis_3b1_crit %>% broom::tidy(),
  coeftest_biis_3c1_proxy %>% broom::tidy(),
  coeftest_biis_4b1_controls %>% broom::tidy()) %>% 
    select(std.error, statistic, p.value) %>% 
    rename(std_error_robust = 1, statistic_robust = 2 , p.value_robust =3)
)




## Print:
results_regression %>% print(n = 100)

# Write to CSV in output folder -------------------------------------------

results_regression %>% 
  mutate(across(c(estimate, std_estimate, std.error, conf.low, conf.high, statistic), ~ round(.x, 3))
  ) %>% 
  #mutate(p.value = round(p.value, digits = 4)) %>% 
  write_csv(here::here('output/results/results-regression.csv'))

# Message:
if(exists('results_regression')) message('Results of regression analysis saved as `output/results/results-regression.csv`')

# Clean Up
rm(results_regression)

