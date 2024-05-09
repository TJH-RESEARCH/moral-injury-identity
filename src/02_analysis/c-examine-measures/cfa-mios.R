



# Tutorial: https://journals.sagepub.com/doi/full/10.1177/2515245920951747

library(lavaan)

model_cfa_mios <- 
  '
trust_violation ~~ shame

shame =~ mios_1 + mios_3 + mios_7 + mios_8 + mios_12 + mios_13 + mios_14
trust_violation =~ mios_2 + mios_4 + mios_5 + mios_6 + mios_9 + mios_10 + mios_11
        

'

fit_cfa_mios <-
  lavaan::cfa(model_cfa_mios, 
      data = data, 
      std.lv = F, 
      estimator = 'MLR')

fit_cfa_mios %>% summary(fit.measures = T, standardized = T)
fit_cfa_mios %>% semTools::reliability()
fit_cfa_mios %>% 
  semPlot::semPaths(what = 'std',
                    filename = here::here('output/figures/sem-plots/cfa-mios'),
                    filetype = 'png')
fit_cfa_mios %>% fitMeasures(c("cfi", "gfi", 'agfi', 'rmr', 'rmsea', 'srmr', 'nfi', 'tli'))



