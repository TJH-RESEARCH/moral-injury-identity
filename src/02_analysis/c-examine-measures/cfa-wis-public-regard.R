
library(lavaan)

# Specify Model --------------------------------------------------------------
model_wis_public_regard <- 
  'public_regard =~ wis_public_25 + wis_public_26 + wis_public_27 + wis_public_28'

# CFA: Maximum Likelihood -------------------------------------------------
fit_wis_public_regard <- 
  lavaan::cfa(model_wis_public_regard, data, std.lv = F, ordered = F, estimator = 'MLR')
fit_wis_public_regard %>% summary(fit.measures = T, standardized = T)
fit_wis_public_regard %>% semTools::reliability()
fit_wis_public_regard %>% 
  semPlot::semPaths(what = 'std',
                    filename = here::here('output/figures/sem-plots/cfa-public-regard'),
                    filetype = 'png')
