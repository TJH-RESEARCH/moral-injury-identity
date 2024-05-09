
library(lavaan)

# Specify Model --------------------------------------------------------------
model_wis_interdependent <- 
  'interdependent =~ wis_interdependent_8 + wis_interdependent_9 + wis_interdependent_10 + wis_interdependent_11 + wis_interdependent_12 + wis_interdependent_13 + wis_interdependent_14'

# CFA: Maximum Likelihood -------------------------------------------------
fit_wis_interdependent <- 
  lavaan::cfa(model_wis_interdependent, data, std.lv = F, ordered = F, estimator = 'MLR')
fit_wis_interdependent %>% summary(fit.measures = T, standardized = T)
fit_wis_interdependent %>% semTools::reliability()
fit_wis_interdependent %>% 
  semPlot::semPaths(what = 'std',
                  filename = here::here('output/figures/sem-plots/cfa-interdependent'),
                  filetype = 'png')
# CFA: Ordinal ------------------------------------------------------------
fit_wis_interdependent_ord <- 
  lavaan::cfa(model_wis_interdependent, data, std.lv = F, ordered = T, estimator = 'WLSMV')
fit_wis_interdependent_ord %>% summary(fit.measures = T, standardized = T)
fit_wis_interdependent_ord %>% semTools::reliability()
fit_wis_interdependent_ord %>% semPlot::semPaths('std')

