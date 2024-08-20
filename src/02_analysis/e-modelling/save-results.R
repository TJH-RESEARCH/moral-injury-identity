
# SAVE COEFFICIENTS ---------------------------------------------------------
## Unnest the coefficients for subsequent analysis

coefs <-
  boot_output %>%
  dplyr::select(-c(fits, splits, preds, fit_indices)) %>%
  unnest(cols = results) %>% 
  select(mediation, model, everything()) %>% 
  
  ## Declare the mediation paths (a, b, and c'):
  mutate(path = case_when(
    model == 'lm_inter' & term == 'mios_criterion_a' ~ 'a',
    model == 'lm_mios_inter' & term == 'mios_criterion_a' ~ 'c_prime',
    model == 'lm_mios_inter' & term == 'wis_interdependent_total' ~ 'b',
    model == 'lm_regard' & term == 'mios_criterion_a' ~ 'a',
    model == 'lm_mios_regard' & term == 'mios_criterion_a' ~ 'c_prime',
    model == 'lm_mios_regard' & term == 'wis_private_regard_total' ~ 'b',
    .default = NA
  ))

coefs %>% print()

# SAVE FIT INDICIES ------------------------------------------------------------------
## Unnest the fit indices
indices <-
  boot_output %>%
  dplyr::select(-c(fits, splits, results)) %>%
  unnest(cols = fit_indices) %>% 
  select(mediation, model, everything())

indices %>% print()


# SAVE PREDICTIONS ------------------------------------------------------------------
## Unnest the predicted values
preds <-
  boot_output %>%
  dplyr::select(-c(fits, splits, fit_indices, results)) %>%
  unnest(cols = preds) %>% 
  select(mediation, model, id, .fitted, everything())

preds %>% print()

# SAVE MODELS ------------------------------------------------------------------
## Unnest the regression objects
models <-
  boot_output %>%
  dplyr::select(-c(splits, preds, fit_indices, results)) %>%
  select(mediation, model, id, everything())

models %>% print()

