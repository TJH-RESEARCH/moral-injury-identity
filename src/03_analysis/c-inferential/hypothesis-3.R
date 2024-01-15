
# Model 3 -----------------------------------------------------------------
## Add moral injury symptoms

library(lavaan) 

sem_model_2 = '
  bipf_total ~ 1 + a*mios_total + ptsd_positive_screen + military_exp_combat + highest_rank_numeric + sex_male + race_white + race_black + years_separation + years_service + discharge_other + discharge_medical + unmet_needs_any
  biis_harmony ~ 1 + c*mios_total + b*bipf_total + ptsd_positive_screen + military_exp_combat + highest_rank_numeric + sex_male + race_white + race_black + years_separation + years_service + discharge_other + discharge_medical + unmet_needs_any

 # direct effect
  direct := c
 
  # indirect effect
  indirect := a*b
 
  # total effect
  total := c + (a*b)
 
'

set.seed(876433112, kind = "Mersenne-Twister") # Set for replication
message('Set random number generator seed...')
message('...running bootstrap...')

model_mediation_2 <- sem(model = sem_model_2,
                       data = data,
                       se = "bootstrap",
                       bootstrap = 5000,
                       parallel ="snow", 
                       ncpus = parallel::detectCores())

message('Bootstrap done.')

model_mediation_2 %>% summary(standardized = TRUE, rsq = TRUE, ci = TRUE) %>% print()



# Print percentile bootstrap 95% confidence intervals

mediation_results_coefs_2 <- 
  parameterEstimates(model_mediation_2, 
                     ci = TRUE, 
                     level = 0.95, 
                     boot.ci.type = "perc",
                     standardized = TRUE) %>% 
  tibble() %>%
  filter(op != "~~") %>% 
  filter(lhs %in% c('wis_connection_total', 'biis_harmony', 'direct', 'indirect', 'total'))%>%  
  mutate(across((where(is.numeric) & !c(pvalue, ci.lower, ci.upper)), ~ round(.x, 3))) %>% 
  #mutate(pvalue = round(pvalue, 4)) %>% 
  select(!c(std.lv, std.nox)) %>% 
  rename(std_estimate = std.all, z.boot = z, p.boot = pvalue, se.boot = se, ci.lower.boot.025 = ci.lower, ci.upper.boot.975 = ci.upper) %>% 
  select(lhs, op, rhs, label, est, std_estimate, everything())


mediation_results_coefs_2 %>% print(n = 200)


mediation_results_brief_2 <-
  mediation_results_coefs_2 %>% 
  filter(label != "") 

# Calculate Percent Direct/Indirect ---------------------------------------
perc_indirect <-as.numeric(mediation_results_brief_2[5,6] / mediation_results_brief_2[6,6])

mediation_results_brief_2 <-
  mediation_results_brief_2 %>% 
  mutate(perc_of_total = c(0, 0, 0, 1 - perc_indirect, perc_indirect,0))









# R-Squared Stats ---------------------------------------------------------
temp <- inspect(model_mediation, 'r2')
tibble(outcome_varibale = temp %>% names(),
       r_squared = temp %>% as.numeric() %>% round(2)
) %>% write_csv(here::here('output/stats/r-squared-mediation.csv'))
rm(temp)



# Print -------------------------------------------------------------------
mediation_results_coefs %>% print()
mediation_results_brief %>% print()

# Save --------------------------------------------------------------------
mediation_results_coefs %>% 
  select(-op) %>% 
  write_csv(here::here('output/results/mediation-results-coefficients.csv'))

mediation_results_brief %>% 
  select(-op) %>% 
  write_csv(here::here('output/results/c9-mediation-results-more-detail.csv'))

mediation_results_brief %>% 
  select(rhs, label, est, std_estimate, perc_of_total, p.boot,
         ci.lower.boot.025, ci.upper.boot.975) %>% 
  write_csv(here::here('output/results/table-4-2-mediation-results-brief.csv'))

# Message -----------------------------------------------------------------
message('Mediation results saved to `output/results/table-4-2-mediation-results.csv`')

rm(mediation_results_coefs, 
   mediation_results_brief,
   model_mediation, 
   sem_model)


