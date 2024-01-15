
# ANALYZE REGRESSION DIAGNOSTICS
## Check residuals of individual regressions.


# Load functions ----------------------------------------------------------
source(here::here('src/01_config/functions/function-plot-lm.R'))


# Specify models ----------------------------------------------------------

## b and c_prime, 
model_b <- 
  data %>% 
  lm(m2cq_mean ~ 
       mios_total +
       biis_harmony + 
       ptsd_positive_screen +
       military_exp_combat +
       sex_male +
       race_white + 
       race_black +
       highest_rank_numeric +
       years_separation +
       years_service +
       discharge_other + discharge_medical +
       unmet_needs_any, 
     .)

## a path with covariates
model_a <- 
  data %>% 
  lm(biis_harmony ~ 
       mios_total +
       military_exp_combat +
       sex_male +
       race_white + 
       race_black +
       highest_rank_numeric +
       years_separation +
       years_service +
       discharge_other + 
       discharge_medical +
       unmet_needs_any,  
     .)



# Diagnostics -------------------------------------------------------------

## Null Model
plot_lm_base(model_0) # This will look bad

## Hierarchical Models
plot_lm_base(model_1)
plot_lm_base(model_2)
plot_lm_base(model_3) # This model is used in the mediation analysis, too

## Mediation Models
plot_lm_base(model_a)
plot_lm_base(model_b)

# Clean up
rm(model_0, model_1, model_2, model_a, model_b)

