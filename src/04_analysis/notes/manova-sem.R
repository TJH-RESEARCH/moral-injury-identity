# MANOVA with SEM



# lavaan ------------------------------------------------------------------

library(lavaan)




# Empty Model -----------------------------------------------------------------


model_sem_empty <- 
  "
  
  # Variances
    wis_private_regard_total ~~ wis_private_regard_total
    wis_public_regard_total ~~ wis_public_regard_total
    wis_interdependent_total ~~ wis_interdependent_total
    wis_connection_total ~~ wis_connection_total
    wis_family_total ~~ wis_family_total
    wis_centrality_total ~~ wis_centrality_total
    wis_skills_total ~~ wis_skills_total
  
  # Residual Covariances
    wis_private_regard_total ~~ wis_public_regard_total
    wis_connection_total ~~ wis_family_total
    wis_connection_total ~~ wis_interdependent_total
    wis_interdependent_total ~~ wis_family_total
    
    
  "

fit_sem_empty <- lavaan::sem(model_sem_empty,  
                         meanstructure = T, 
                         data = data)
fit_sem_empty %>% summary()
fit_sem_empty %>% semPlot::semPaths()
fit_sem_empty %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))


# Model 1 -----------------------------------------------------------------


model_sem_1 <- 
  "
  
  # Variances
    wis_private_regard_total ~~ wis_private_regard_total
    wis_public_regard_total ~~ wis_public_regard_total
    wis_interdependent_total ~~ wis_interdependent_total
    wis_connection_total ~~ wis_connection_total
    wis_family_total ~~ wis_family_total
    wis_centrality_total ~~ wis_centrality_total
    wis_skills_total ~~ wis_skills_total
  
  # Regression
    wis_private_regard_total +  wis_public_regard_total + wis_interdependent_total + wis_connection_total + wis_family_total + wis_centrality_total + wis_skills_total ~ mios_total
  
  # Residual Covariances
    wis_private_regard_total ~~ wis_public_regard_total
    wis_connection_total ~~ wis_family_total
    wis_connection_total ~~ wis_interdependent_total
    wis_interdependent_total ~~ wis_family_total
    
    
  "

fit_sem_1 <- lavaan::sem(model_sem_1,  
                         meanstructure = F, 
                         data = data)
fit_sem_1 %>% summary()
fit_sem_1 %>% semPlot::semPaths()
fit_sem_1 %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))

# Model 2 -----------------------------------------------------------------


model_sem_2 <- 
  "
  
  # Variances
    wis_private_regard_total ~~ wis_private_regard_total
    wis_public_regard_total ~~ wis_public_regard_total
    wis_interdependent_total ~~ wis_interdependent_total
    wis_connection_total ~~ wis_connection_total
    wis_family_total ~~ wis_family_total
    wis_centrality_total ~~ wis_centrality_total
    wis_skills_total ~~ wis_skills_total
  
    mios_total ~~ mios_ptsd_symptoms_total
  
  # Regression
    wis_private_regard_total + wis_public_regard_total + wis_interdependent_total + wis_connection_total + wis_family_total + wis_centrality_total + wis_skills_total ~ mios_total + mios_ptsd_symptoms_total
  
  # Residual Covariances
    wis_private_regard_total ~~ wis_public_regard_total
    wis_connection_total ~~ wis_family_total
    wis_connection_total ~~ wis_interdependent_total
    wis_interdependent_total ~~ wis_family_total
    
  "

fit_sem_2 <- lavaan::sem(model_sem_2,  
                         meanstructure = F, 
                         data = data)
fit_sem_2 %>% summary()
fit_sem_2 %>% semPlot::semPaths()
fit_sem_2 %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))


# Model 3 -----------------------------------------------------------------


model_sem_3 <- 
  "
  
  # Variances
    wis_private_regard_total ~~ wis_private_regard_total
    wis_public_regard_total ~~ wis_public_regard_total
    wis_interdependent_total ~~ wis_interdependent_total
    wis_connection_total ~~ wis_connection_total
    wis_family_total ~~ wis_family_total
    wis_centrality_total ~~ wis_centrality_total
    wis_skills_total ~~ wis_skills_total
    
    years_service ~~ years_of_age
    mios_total ~~ mios_ptsd_symptoms_total
  
  # Regression
    wis_private_regard_total + wis_public_regard_total + wis_interdependent_total + wis_connection_total + wis_family_total + wis_centrality_total + wis_skills_total ~ mios_total + mios_ptsd_symptoms_total + years_service + reserve + military_family_total + years_of_age
  
  # Residual Covariances
    wis_private_regard_total ~~ wis_public_regard_total
    wis_connection_total ~~ wis_family_total
    wis_connection_total ~~ wis_interdependent_total
    wis_interdependent_total ~~ wis_family_total
    mios_total ~~ mios_ptsd_symptoms_total
    
  "

fit_sem_3 <- lavaan::sem(model_sem_3,  
                         meanstructure = F, 
                         data = data)
fit_sem_3 %>% summary()
fit_sem_3 %>% semPlot::semPaths(curvePivot = TRUE)
fit_sem_3 %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))
