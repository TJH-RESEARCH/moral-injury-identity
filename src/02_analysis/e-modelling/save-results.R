
# SAVE COEFFICIENTS ---------------------------------------------------------
boot_coefs <-
  boot_output %>%
  dplyr::select(-c(fits, splits, preds, fit_indices)) %>%
  unnest(cols = results) %>% 
  select(mediation, model, everything())

boot_coefs %>% print()

# SAVE FIT INDICIES ------------------------------------------------------------------
boot_indices <-
  boot_output %>%
  dplyr::select(-c(fits, splits, results)) %>%
  unnest(cols = fit_indices) %>% 
  select(mediation, model, everything())

boot_indices %>% print()


# SAVE PREDICTIONS ------------------------------------------------------------------
boot_preds <-
  boot_output %>%
  dplyr::select(-c(fits, splits, fit_indices, results)) %>%
  unnest(cols = preds) %>% 
  select(mediation, model, id, .fitted, everything())

boot_preds %>% print()

# SAVE MODELS ------------------------------------------------------------------
boot_models <-
  boot_output %>%
  dplyr::select(-c(splits, preds, fit_indices, results)) %>%
  select(mediation, model, id, everything())

boot_models %>% print()



# RESULTS: ALL COEFFICIENTS -----------------------------------------------
results_coefs <-
  left_join(
    # Get coefficients from original data
    boot_coefs %>% 
      filter(id == 'Apparent') %>% 
      select(model, term, estimate),
    
    # Get standard deviation of coefficients across the bootstrap samples
    boot_coefs %>% 
      filter(id != 'Apparent') %>% 
      group_by(model, term) %>% 
      reframe(model, term, sd_boot = sd(estimate)) %>% 
      unique() %>% 
      select(model, term, sd_boot),
    
    by = c('model' = 'model', 'term' = 'term')
    
  ) %>% 
  # Calculate a test statistic
  mutate(statistic = abs(estimate / sd_boot),
         p_z = pt(statistic, df = Inf, lower.tail = FALSE))

results_coefs %>% print(n = 100)


# RESULTS: PATHS -------------------------------------------------------------------
results_paths <-
  boot_coefs %>% 
  filter(term == 'mios_criterion_a' | 
           term == 'wis_interdependent_total' | 
           term == 'wis_private_regard_total') %>% 
  
  ## Declare the mediation paths (a, b, and c'):
  mutate(path = case_when(
    model == 'lm_inter' & term == 'mios_criterion_a' ~ 'c_prime',
    model == 'lm_mios_inter' & term == 'mios_criterion_a' ~ 'a',
    model == 'lm_mios_inter' & term == 'wis_interdependent_total' ~ 'b',
    model == 'lm_regard' & term == 'mios_criterion_a' ~ 'c_prime',
    model == 'lm_mios_regard' & term == 'mios_criterion_a' ~ 'a',
    model == 'lm_mios_regard' & term == 'wis_private_regard_total' ~ 'b',
    .default = NA
  ))

results_paths %>% print()


# INDIRECT EFFECT ---------------------------------------------------------
results_boot <-
  results_paths %>% 
  filter(id != 'Apparent') %>% 
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


results_boot %>% print()

# SAVE INDIRECT EFFECTS -----------------------------------------
result_indirect <-
  bind_rows(
    results_boot %>% filter(pci_lower_95 == 1) %>% select(ab, pci_lower_95),
    results_boot %>% filter(pci_upper_95 == 1) %>% select(ab, pci_upper_95)
  ) %>% 
  mutate(pci_lower_95 = ab * pci_lower_95,
         pci_upper_95 = ab * pci_upper_95) %>% 
  pivot_longer(-c(mediation, ab)) %>%
  filter(!is.na(value)) %>% 
  pivot_wider(id_cols = mediation, values_from = value, names_from = name) %>% 
    
  # Join the Percentile Confidence Intervals with Bootsrapped Mean & SD of AB 
  right_join(
      
    results_boot %>%
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
