
# ANALYZE REGRESSION DIAGNOSTICS
## Check residuals of individual regressions.


# Load functions ----------------------------------------------------------
source(here::here('src/01_config/functions/function-plot-lm.R'))

# Diagnostics -------------------------------------------------------------
plot_lm(fit_biis)
plot_lm(fit_wis)
plot_lm(fit_interact)
