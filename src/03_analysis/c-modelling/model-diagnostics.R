
# ANALYZE REGRESSION DIAGNOSTICS
## Check residuals of individual regressions.


# Load functions ----------------------------------------------------------
source(here::here('src/01_config/functions/function-plot-lm.R'))

# Diagnostics -------------------------------------------------------------
plot_lm_base(model_wis_0)
plot_lm_base(model_wis_1_bivariate)
plot_lm_base(model_wis_2_adjust)
plot_lm_base(model_wis_3b1_crit)
# plot_lm_base(model_wis_3b2_instrument)
plot_lm_base(model_wis_3c1_proxy)
plot_lm_base(model_wis_4b1_controls)

plot_lm_base(model_biis_0)
plot_lm_base(model_biis_1_bivariate)
plot_lm_base(model_biis_2_adjust)
plot_lm_base(model_biis_3b1_crit)
# plot_lm_base(model_biis_3b2_instrument)
plot_lm_base(model_biis_3c1_proxy)
plot_lm_base(model_biis_4b1_controls)



# Clean up
rm(plot_lm, plot_lm_base)

