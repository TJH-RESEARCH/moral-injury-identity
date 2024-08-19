
library(kableExtra)


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
