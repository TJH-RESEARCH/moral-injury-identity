
library(kableExtra) # Package for conversion to latex


# RESULTS: ALL COEFFICIENTS -----------------------------------------------
results_coefs <-
  left_join(
    # Get coefficients from original data sets
    coefs %>% 
      filter(id == 'Apparent') %>%  # Apparent is the original data, not bootsrapped
      select(model, term, estimate, path),
    
    # Get standard deviation of coefficients across the bootstrap samples
    coefs %>% 
      filter(id != 'Apparent') %>% 
      group_by(model, term) %>% 
      reframe(model, term, sd_boot = sd(estimate), path) %>% 
      unique() %>% 
      select(model, term, sd_boot, path),
    
    by = c('model' = 'model', 'term' = 'term', 'path' = 'path')
    
  ) %>% 
  # Calculate a test statistic
  mutate(statistic = abs(estimate / sd_boot),
         p_z = pt(statistic, df = Inf, lower.tail = FALSE)) %>% 
  select(model, term, path, estimate, sd_boot, statistic, p_z)

results_coefs %>% print(n = 100)


# RESULTS: PATHS ONLY -------------------------------------------------------------------
## Same as above but filter only for the a, b, and c' paths
results_paths <-
  results_coefs %>% 
  filter(!is.na(path)) %>% 
  arrange(path)

results_paths %>% print()


# MEAN OF BOOTSTRAP PATH ESTIMATES ------------------------------------------------

results_paths_boot <-
  coefs %>% 
  filter(id != 'Apparent' & !is.na(path)) %>% 
  group_by(model, path, term) %>% 
  summarize(mean_estimate = mean(estimate),
            se_estimate = sd(estimate),
            statistic = abs(mean_estimate / se_estimate),
            p_z = pt(statistic, df = Inf, lower.tail = FALSE)) %>% 
  select(model, term, path, mean_estimate, se_estimate, statistic, p_z) %>% 
  arrange(path)

results_paths_boot %>% print()


# INDIRECT EFFECT ---------------------------------------------------------
## Find the indirect effect by using the bootstrap samples,
## and multiplying a and b coefficients

result_indirect_all_coefs <-
  coefs %>% 
  filter(id != 'Apparent' & !is.na(path)) %>% # bootstraps only
  select(c(id, mediation, path, estimate)) %>% 
  pivot_wider(names_from = path, values_from = estimate) %>%
  group_by(mediation) %>% 
  ## Multiply a and b paths for the indirect effect:
  mutate(ab = a * b,
         c =  c_prime + ab) %>% 
  
  ungroup() %>% 
  arrange(mediation, ab) %>% 
  group_by(mediation) %>% 
  
  ## Percentile confidence intervals:
  mutate(order = c(1:n_bootstraps),
         pci_lower_95 = if_else(order == as.integer(0.5 * (1 - 95/100) * n_bootstraps), 1, 0),
         pci_upper_95 = if_else(order == as.integer(1 + 0.5 * (1 + 95/100) * n_bootstraps), 1, 0)
  )

result_indirect_all_coefs %>% print()


# SAVE INDIRECT EFFECTS -----------------------------------------
result_indirect <-
  bind_rows(
    result_indirect_all_coefs %>% filter(pci_lower_95 == 1) %>% select(ab, pci_lower_95),
    result_indirect_all_coefs %>% filter(pci_upper_95 == 1) %>% select(ab, pci_upper_95)
  ) %>% 
  mutate(pci_lower_95 = ab * pci_lower_95,
         pci_upper_95 = ab * pci_upper_95) %>% 
  pivot_longer(-c(mediation, ab)) %>%
  filter(!is.na(value)) %>% 
  pivot_wider(id_cols = mediation, values_from = value, names_from = name) %>% 
  
  # Join the Percentile Confidence Intervals with Bootsrapped Mean & SD of AB 
  right_join(
    
    result_indirect_all_coefs %>%
      group_by(mediation) %>%
      summarize(mean_ab = mean(ab),
                se_ab = sd(ab),
                statistic = abs(mean_ab / se_ab),
                p_z = pt(statistic, df = Inf, lower.tail = FALSE)),
    
    by = c('mediation' = 'mediation')
  ) %>% 
  
  # Rearrange columns
  select(mediation, mean_ab, se_ab, statistic, p_z, everything()) %>% 
  ungroup()

result_indirect %>% print()


# RESULTS TABLES: INDIRECT EFFECTS --------------------------------------------------------
result_indirect %>% 
  mutate(mediation = c('Interdependence', 'Regard')) %>% 
  rename(
    Mediator = mediation, 
    ab = mean_ab,
    SE = se_ab,
    z = statistic,
    p = p_z,
    `PCI Lower` = pci_lower_95,
    `PCI Upper` = pci_upper_95
  ) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 3))) %>% 
  kbl(caption = "Indirect Effects",
      format = "latex",
      align = "l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, html_font = "helvetica") %>% 
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)



# RESULTS TABLE: MODEL FITS --------------------------------------------------------------
boot_indices %>% 
  filter(id == 'Apparent') %>% 
  select(c(model, r.squared, AIC, nobs)) %>% 
  rename(
    Model = model,
    `R^2` = r.squared,
    n = nobs
  ) %>% 
  mutate(
    Model = c('Interdependence', 'Moral Injury ~ Interdependence', 
              'Regard', 'Moral Injury ~ Regard'),
    across(where(is.numeric),  ~ round(.x, 2))) %>% 
  kbl(caption = "Model Fit",
      format = "latex",
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)




# RESULTS TABLES: Coefficients --------------------------------------------

## Base
results_coefs_base_format <-
results_coefs %>% 
  mutate(
    term = case_when(
      term == 'mios_screener' ~ 'Moral Injury Event',
      term == 'mios_criterion_a' ~ 'Criterion A Event',
      term == 'military_exp_combat' ~ 'Prior Combat Deployment',
      term == 'race_black' ~ 'Race/Ethnicity: Black or African American',
      term == 'race_white' ~ 'Race/Ethnicity: White or Caucasian',
      term == 'branch_air_force' ~ 'Branch: Air Force',
      term == 'branch_marines' ~ 'Branch: Marines',
      term == 'branch_navy' ~ 'Branch: Navy',
      term == 'sex_male' ~ 'Gender: Male',
      term == 'service_era_init_pre_vietnam' ~ 'Service Era: Pre-Vietnam',
      term == 'service_era_init_vietnam' ~ 'Service Era: Vietnam',
      term == 'service_era_init_post_vietnam' ~ 'Service Era: Post-Vietnam',
      term == 'service_era_init_persian_gulf' ~ 'Service Era: Persian Gulf',
      term == 'mos_combat' ~ 'Occupational Specialty: Combat',
      term == 'years_service' ~ 'Years of Service',
      term == 'rank_e1_e3' ~ 'Highest Pay Grade: E-1 to E-3',
      term == 'rank_e4_e6' ~ 'Highest Pay Grade: E-4 to E-6',
      term == 'rank_e7_e9' ~ 'Highest Pay Grade: E-7 to E-9',
      term == 'wis_interdependent_total' ~ 'Military Identity: Interdependence',
      term == 'wis_private_regard_total' ~ 'Military Identity: Regard',
      term == '(Intercept)' ~ '(Intercept)',
      .default = NA
    )
  ) %>% 
  rename(
    Term = term,
    beta = estimate,
    SE = sd_boot, 
    z = statistic,
    p = p_z
  ) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 3)))
  
  
# Interdependence
results_coefs_base_format %>% 
  filter(model == 'lm_inter') %>% 
  select(-model) %>% 
  kbl(caption = "Regression Coefficients: Interdependence",
      format = "latex",
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)


# Moral Injury ~ Interdependence 
results_coefs_base_format %>% 
  filter(model == 'lm_mios_inter') %>% 
  select(-model) %>% 
  kbl(caption = "Regression Coefficients: Moral Injury ~ Interdependence",
      format = "latex",
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)


# Moral Injury ~ Regard 
results_coefs_base_format %>% 
  filter(model == 'lm_regard') %>% 
  select(-model) %>% 
  kbl(caption = "Regression Coefficients: Regard",
      format = "latex",
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)


# Moral Injury ~ Regard 
results_coefs_base_format %>% 
  filter(model == 'lm_mios_regard') %>% 
  select(-model) %>% 
  kbl(caption = "Regression Coefficients: Moral Injury ~ Regard",
      format = "latex",
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)
