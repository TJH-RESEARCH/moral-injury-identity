


# POINT ESTIMATES ---------------------------------------------------------
point_estimates_boot <-
  paths_boot %>% 
  select(c(id, mediation, path, estimate)) %>% 
  pivot_wider(names_from = path, values_from = estimate) %>%
  group_by(mediation) %>% 
  summarise(across(where(is.numeric), ~ mean(.x)))

point_estimates_boot


# STANDARD DEVIATION -----------------------------------------------------
sd_boot <-
  paths_boot %>% 
  select(c(id, mediation, path, estimate)) %>% 
  pivot_wider(names_from = path, values_from = estimate) %>%
  group_by(mediation) %>% 
  summarise(across(where(is.numeric), ~ sd(.x)))

sd_boot



# INDIRECT EFFECT ---------------------------------------------------------
ab <-
  paths_boot %>% 
  select(c(id, mediation, path, estimate, std.error)) %>% 
  pivot_wider(names_from = path, values_from = c(estimate, std.error)) %>%
  group_by(mediation) %>% 
  
  ## Multiply a and b paths for the indirect effect:
  mutate(estimate_ab = estimate_a * estimate_b) %>% 
  
  ungroup() %>% 
  filter(id != 'Apparent') %>% 
  arrange(mediation, estimate_ab) %>% 
  group_by(mediation) %>% 
  
  ## Percentile confidence intervals:
  mutate(order = c(1:n_bootstraps),
         pci_lower_95 = if_else(order == as.integer(0.5 * (1 - 95/100) * n_bootstraps), 1, 0),
         pci_upper_95 = if_else(order == as.integer(1 + 0.5 * (1 + 95/100) * n_bootstraps), 1, 0)
  )


# PERCENTILE CONFIDENCE INTERVALS -----------------------------------------
bind_rows(
  ab %>% filter(pci_lower_95 == 1) %>% select(estimate_ab, pci_lower_95),
  ab %>% filter(pci_upper_95 == 1) %>% select(estimate_ab, pci_upper_95)
) %>% 
arrange(mediation)



# FIT METRICS ------------------------------------------------------------------
fit <-
  bind_rows(
    fit_inter %>% broom::glance() %>% mutate(model = 'inter'),
    fit_mios_inter %>% broom::glance() %>% mutate(model = 'mios_inter'),
    fit_regard %>% broom::glance() %>% mutate(model = 'regard'),
    fit_mios_regard %>% broom::glance() %>% mutate(model = 'mios_regard')
  ) %>% select(model, everything())
fit %>% print()
fit %>% write_csv(here::here('output/tables/model-fit.csv'))

