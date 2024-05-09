
library(lavaan)

# Specify Model --------------------------------------------------------------
model_biis_conflict <- 
  'conflict =~ biis_1 + biis_2 + biis_3 + biis_4 + biis_5 + biis_6 + biis_7 + biis_8 + biis_9 + biis_10'

fit_biis_conflict <- 
  lavaan::cfa(model_biis_conflict, 
              data, 
              std.lv = T, 
              orthogonal = FALSE, 
              estimator = 'MLR')

fit_biis_conflict %>% summary(fit.measures = T, standardized = T)

fit_biis_conflict %>% semTools::reliability() %>% 
  tibble() %>% slice(1) %>% round(2) %>% 
  write_lines(file = here::here('output/stats/alpha-biis-conflict.txt'))

fit_biis_conflict %>% 
  semPlot::semPaths(what = 'std',
                    filename = here::here('output/figures/sem-plots/cfa-biis'),
                    filetype = 'png')

fit_biis_conflict %>% fitMeasures(c("cfi", "gfi", 'agfi', 'rmr', 'rmsea', 'srmr', 'nfi', 'tli'))

