# HYPOTHESIS 1

## Moral injury symptoms predict greater challenges with reintegration, 
##  even when controlling for PTSD and other factors that could 
##  affect reintegration (i.e., - sex, race, combat deployment, 
##  officer/enlisted status, disability, and reason for discharge). 

# PLAN

## Hierarchical regression


# Null Model --------------------------------------------------------------
model_0 <- data %>% lm(m2cq_mean ~ 1, .)

# Model 1 -----------------------------------------------------------------
## Total Effect of Moral Injury on Reintegration
model_1 <- 
  data %>% 
  lm(m2cq_mean ~ 
       military_exp_combat +
       officer + 
       sex_male +
       military_family_none +
       race_white +
       discharge_reason +
       disability, 
     .)

# Model 2 -----------------------------------------------------------------
## Add PTSD as a covariate
model_2 <- 
  data %>% 
  lm(m2cq_mean ~ 
       ptsd_positive_screen + 
       military_exp_combat +
       officer + 
       sex_male +
       military_family_none +
       race_white +
       discharge_reason +
       disability, 
     .)

# Model 3 -----------------------------------------------------------------
## Add moral injury symptoms
model_3 <-
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

# Results -----------------------------------------------------------------
model_0_results <- model_0 %>% lm.beta::lm.beta() %>% summary()
model_1_results <- model_1 %>% lm.beta::lm.beta() %>% summary()
model_2_results <- model_2 %>% lm.beta::lm.beta() %>% summary()
model_3_results <- model_3 %>% lm.beta::lm.beta() %>% summary()

# Compare Models ----------------------------------------------------------
hierarchical_comparison <- anova(model_0, model_1, model_2, model_3)

hierarchical_comparison <-
tibble(model = c('null', 1, 2, 3),
       res_df = hierarchical_comparison$Res.Df,
       rss = hierarchical_comparison$RSS,
       df = hierarchical_comparison$Df,
       sum_sq = hierarchical_comparison$`Sum of Sq`,
       f_stat = hierarchical_comparison$`F`,
       p = hierarchical_comparison$`Pr(>F)`,
       r_sq = c(model_0_results$r.squared,
                model_1_results$r.squared,
                model_2_results$r.squared,
                model_3_results$r.squared),
       adj_r_sq = c(model_0_results$adj.r.squared,
                    model_1_results$adj.r.squared,
                    model_2_results$adj.r.squared,
                    model_3_results$adj.r.squared)
       )


## Print:
hierarchical_comparison %>% print()

# Write to CSV in output folder -------------------------------------------

hierarchical_comparison %>% 
  mutate(across(c(sum_sq, r_sq, adj_r_sq), ~ round(.x, 3)),
         across(c(p, f_stat), ~ round(.x, 4))
  ) %>% 
  write_csv(here::here('output/results/hierarchical-comparison.csv'))

# Message:
if(exists('hierarchical_comparison')) message('Results of comparison of nested models saved as `output/results/hierarchical-comparison.csv`')




# Save Results: Coefficients -------------------------------------------------------------------------

hierarchical_regression <-
  model_1 %>% 
    lm.beta::lm.beta() %>% 
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    mutate(model = 1) %>% 
  bind_rows(
  model_2 %>% 
    lm.beta::lm.beta() %>% 
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    mutate(model = 2)) %>% 
  bind_rows(
  model_3 %>% 
    lm.beta::lm.beta() %>%
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    mutate(model = 3)
  )


## Print:
hierarchical_regression %>% print(n = 100)

# Write to CSV in output folder -------------------------------------------

hierarchical_regression %>% 
  mutate(across(c(estimate, std_estimate, std.error, conf.low, conf.high, p.value, statistic), ~ round(.x, 3))
  ) %>% 
  write_csv(here::here('output/results/hierarchical-regression.csv'))

# Message:
if(exists('hierarchical_regression')) message('Results of hierarchical regression analysis saved as `output/results/hierarchical-regression.csv`')

# Clean Up
rm(hierarchical_regression, hierarchical_comparison)

