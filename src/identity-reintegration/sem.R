


library(lavaan)

model_1 <-
  'mcarm_purpose_connection + mcarm_help_seeking + mcarm_beliefs_about_civilians + mcarm_resentment_regret + mcarm_regimentation ~ wis_centrality_total'


fit_1 <- lavaan::sem(model_1,  
                         meanstructure = F, 
                         data = data)
fit_1 %>% summary()
fit_1 %>% semPlot::semPaths()
fit_1 %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))


model_full_1 <-
  lm(mcarm_regimentation ~ 
      wis_centrality_total + 
      wis_connection_total + 
      wis_family_total + 
      wis_interdependent_total + 
      wis_private_regard_total + 
      wis_public_regard_total, data = data)

model_full_1 %>% summary()
model_full_1 %>% plot()

library(lavaan)

model_full <-
  'mcarm_purpose_connection + mcarm_help_seeking + mcarm_beliefs_about_civilians + mcarm_resentment_regret + mcarm_regimentation ~ wis_centrality_total + wis_connection_total + wis_family_total + wis_interdependent_total + wis_private_regard_total + wis_public_regard_total'


fit_full <- lavaan::sem(model_full,  
                         meanstructure = F, 
                         data = data)
fit_full %>% summary()
fit_full %>% semPlot::semPaths()
fit_full %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




model_latent <-
  '
reintegration =~ mcarm_purpose_connection + mcarm_help_seeking + mcarm_beliefs_about_civilians + mcarm_resentment_regret + mcarm_regimentation 
military_identity =~ wis_centrality_total + wis_connection_total + wis_family_total + wis_interdependent_total + wis_private_regard_total + wis_public_regard_total
reintegration ~ military_identity'

fit_latent <- lavaan::sem(model_latent,  
                        meanstructure = F, 
                        data = data)
fit_latent %>% summary()
fit_latent %>% semPlot::semPaths()
fit_latent %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))

