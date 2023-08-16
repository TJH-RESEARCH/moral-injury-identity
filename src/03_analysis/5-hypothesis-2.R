
# HYPOTHESIS 2

## Identity Dissonance mediates the impact of moral injury on reintegration. 


# c Path ------------------------------------------------------------------
## Equivalent to Model 3 that tested Hypothesis 1
model_c <-
  data %>% 
  lm(m2cq_mean ~ 
       mios_total +
       ptsd_positive_screen +
       military_exp_combat +
       officer + 
       sex_male +
       military_family_none +
       race_white +
       discharge_reason +
       disability, 
     .)

## b and c_prime, 
model_b <- 
  data %>% 
  lm(m2cq_mean ~ 
       mios_total +
       biis_harmony + 
       ptsd_positive_screen +
       military_exp_combat +
       officer + 
       sex_male +
       military_family_none +
       race_white +
       discharge_reason +
       disability, 
     .)


## a path
model_a <- data %>% lm(biis_harmony ~ mios_total, .)

# Results -----------------------------------------------------------------
model_c %>% lm.beta::lm.beta() %>% summary()
model_b %>% lm.beta::lm.beta() %>% summary()
model_a %>% lm.beta::lm.beta() %>% summary()


# Save Results: Coefficients -------------------------------------------------------------------------

mediation_regression <-
  model_c %>% 
  lm.beta::lm.beta() %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  mutate(model = 'c') %>% 
  bind_rows(
    model_b %>% 
      lm.beta::lm.beta() %>% 
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = 'b')) %>% 
  bind_rows(
    model_a %>% 
      lm.beta::lm.beta() %>%
      broom::tidy(conf.int = T, conf.level = 0.95) %>% 
      mutate(model = 'a')
  )


## Print:
mediation_regression %>% print(n = 100)

# Write to CSV in output folder -------------------------------------------

mediation_regression %>% 
  mutate(across(c(estimate, std_estimate, std.error, conf.low, conf.high), ~ round(.x, 3)),
         across(c(p.value, statistic), ~ round(.x, 4))
  ) %>% 
  write_csv(here::here('output/results/mediation-regression.csv'))

# Message:
if(exists('mediation_regression')) message('Results of mediation analysis regressions saved as `output/results/mediation-regression.csv`')

# Clean Up
rm(mediation_regression)
