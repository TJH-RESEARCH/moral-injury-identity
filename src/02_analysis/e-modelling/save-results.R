
# SAVE COEFFICIENTS ---------------------------------------------------------
boot_coefs <-
  boot_output %>%
  dplyr::select(-c(fits, splits, extracts, preds, fit_indices)) %>%
  unnest(cols = results) %>% 
  select(mediation, model, everything())


boot_coefs %>% print()



# SAVE MEDIATION PATHS ----------------------------------------------------
boot_paths <-
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

boot_paths %>% print()



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
boot_model_extracts <-
  boot_output %>%
  dplyr::select(-c(fits, splits, preds, fit_indices, results)) %>%
  select(mediation, model, id, everything())

boot_model_extracts %>% print()


