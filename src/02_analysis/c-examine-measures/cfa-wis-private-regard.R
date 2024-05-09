
library(lavaan)

# Specify Model --------------------------------------------------------------
model_wis_private_regard <- 
  'private_regard =~ wis_private_1 + wis_private_2 + wis_private_3 + wis_private_4 + wis_private_5 + wis_private_6 + wis_private_7'

# CFA: Maximum Likelihood -------------------------------------------------
fit_wis_private_regard <- 
  lavaan::cfa(model_wis_private_regard, data, std.lv = F, ordered = F, estimator = 'MLR')
fit_wis_private_regard %>% summary(fit.measures = T, standardized = T)
fit_wis_private_regard %>% semTools::reliability()
fit_wis_private_regard %>% 
  semPlot::semPaths(what = 'std',
                    filename = here::here('output/figures/sem-plots/cfa-private-regard'),
                    filetype = 'png')
