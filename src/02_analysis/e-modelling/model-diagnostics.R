
# ANALYZE REGRESSION DIAGNOSTICS
## Check residuals of individual regressions.


# Load functions ----------------------------------------------------------
source(here::here('src/01_config/functions/function-plot-lm.R'))

# Diagnostics -------------------------------------------------------------
plot_lm(model_biis_1)
plot_lm(model_wis_interdependent_1)
plot_lm(model_wis_private_regard_1)
plot_lm(model_biis_interact_1)


plot_lm(model_biis_2)
plot_lm(model_wis_interdependent_2)
plot_lm(model_wis_private_regard_2)
plot_lm(model_biis_interact_2)


# Clean up
rm(plot_lm)

