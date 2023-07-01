
# ANALYZE REGRESSION DIAGNOSTICS
## Check residuals of individual regressions.


# Load functions ----------------------------------------------------------
if(!exists('plot_lm')) source(here::here('src/01_config/functions/function-regression.R'))


# Diagnostics -------------------------------------------------------------

plot_lm(data, DV = 'mcarm_total', IVs = c('biis_harmony', 'biis_blendedness', 'mios_total', 'mios_ptsd_symptoms_none', 'service_era_persian_gulf', 'service_era_post_911', 'service_era_vietnam', 'sex_male', 'disability'))

plot_lm(data, DV = 'biis_harmony', IVs = c('wis_total', 'civilian_commit_total'))

plot_lm(data, DV = 'biis_blendedness', IVs = c('wis_total', 'civilian_commit_total'))

plot_lm(data, DV = 'wis_total', IVs = c('mios_total', 'mios_ptsd_symptoms_none', 'service_era_persian_gulf', 'service_era_post_911', 'service_era_vietnam', 'sex_male', 'branch_air_force', 'branch_marines', 'branch_navy', 'race_white', 'military_family', 'years_service', 'years_separation', 'rank_e1_e3', 'rank_e7_e9', 'nonenlisted'))

plot_lm(data, DV = 'civilian_commit_total', IVs = c('mios_total', 'mios_ptsd_symptoms_none', 'years_separation', 'service_era_persian_gulf', 'service_era_post_911', 'service_era_vietnam', 'sex_male', 'military_family', 'worship'))


## All are acceptable, many outstanding
