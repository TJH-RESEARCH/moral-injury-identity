
# ANALYZE REGRESSION DIAGNOSTICS
## Check residuals of individual regressions.


# Load functions ----------------------------------------------------------
source(here::here('src/01_config/functions/function-plot-lm.R'))


# Diagnostics -------------------------------------------------------------

## Null Model
plot_lm_base(model_0) # This will look bad

## Hierarchical Models
plot_lm_base(model_1)
plot_lm_base(model_2)
plot_lm_base(model_3) # This model is used in the mediation analysis, too

## Mediation Analysis
plot_lm_base(model_a)
plot_lm_base(model_b)

# Clean up
rm(model_0, model_1, model_2, model_3, model_a, model_b, model_c)
