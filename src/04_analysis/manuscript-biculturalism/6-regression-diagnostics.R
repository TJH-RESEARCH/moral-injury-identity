
# ANALYZE REGRESSION DIAGNOSTICS

# Military-Civilian Biculturalism?: 
# Bicultural Identity and the Adjustment of Separated Service Members



# Plot Residual Diagnostics: Model Blendedness --------------------------------

plot_fit_blendedness <- 
  plot_lm(data, DV = 'biis_blendedness', IVs = c(IV_wis, IV_civ))

## Residuals vs Fitted: Looks good. Minor deviation on left.
## QQ Plot: Good. Minor deviation top-right.
## Scale location: Good. Minor deviation left.
## Residuals vs. Leverage: Good. No Cook's distance. 



# Plot Residual Diagnostics: Model Harmony ------------------------------------
plot_fit_harmony <- 
  plot_lm(data, DV = 'biis_harmony', IVs = c(IV_wis, IV_civ))

## Residuals vs Fitted: Excellent.
## QQ Plot: Good. Some deviation top-right.
## Scale location: Good. Some deviation left.
## Residuals vs. Leverage: Excellent.

