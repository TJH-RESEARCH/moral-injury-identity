

# mediation
## optional implementations packages: bmem, plspm, lavaan, mediation, mma

## draw dags

# Is moral injury's negative effect on reintegration mediated by private regard


# lavaan ------------------------------------------------------------------
data_mediation <- 
  data %>% 
  select(mios_total, mcarm_total, wis_private_regard_total)

model <- ' # direct effect
              mcarm_total ~ c*mios_total
           # mediator
             wis_private_regard_total ~ a*mios_total
             mcarm_total ~ b*wis_private_regard_total
           # indirect effect (a*b)
             ab := a*b
           # total effect
             total := c + (a*b)
         '
fit <- lavaan::sem(model, data = data_mediation)
summary(fit)



# mediate -----------------------------------------------------------------

# Example 1: Linear Outcome and Mediator Models
####################################################
b <- lm(mcarm_total ~ mios_total, data = data)
c <- lm(mcarm_total ~ mios_total + wis_private_regard_total, data = data)

# Estimation via quasi-Bayesian approximation
contcont <- mediation::mediate(b, c, sims=50, treat="mios_total", mediator="wis_private_regard_total")
summary(contcont)
plot(contcont)





# Example -------------------------------------------------------------------------

C1 <- rnorm(10000)                    # Generate first random confounder
X  <- rbinom(10000, 1, plogis(.8*C1)) # Generate random tx variable as a function of C1
C2 <- rnorm(10000, .8*X)              # Generate second confounder as function of tx
M  <- rnorm(10000, .8*X + .8*C2)      # Generate mediator as function of tx and second confounder
Y  <- rnorm(10000, .8*X + .8*M + .8*C1 + .8*C2) # Model outcome
tbl <- tibble(
  C1 = C1,
  C2 = C2,
  X = X,
  M = M,
  Y = Y) 

mod_y <- lm(Y ~ X*M + C1 + C2, data = tbl) %>% 
  broom::tidy() %>% 
  mutate_if(is.numeric, ~round(.x, 3)) %>% 
  mutate(p.value = if_else(
    p.value < 0.001,
    true  = "< 0.001", 
    false = as.character(round(p.value, 3))))

mod_m <- lm(M ~ X + C2, data = tbl) %>% 
  broom::tidy() %>% 
  mutate_if(is.numeric, ~round(.x, 3)) %>% 
  mutate(p.value = if_else(
    p.value < 0.001,
    true  = "< 0.001", 
    false = as.character(round(p.value, 3))))

mod_y
mod_m


# Mediation Model ---------------------------------------------------------
data_mediation <- 
  data %>% 
  select((ends_with('total') | ends_with('mean')) & !c('irvTotal'))




# Model -------------------------------------------------------------------



mod_y <- lm(mcarm_total ~ mios_total * wis_private_total + C1 + C2, data = tbl) %>% 
  broom::tidy() %>% 
  mutate_if(is.numeric, ~round(.x, 3)) %>% 
  mutate(p.value = if_else(
    p.value < 0.001,
    true  = "< 0.001", 
    false = as.character(round(p.value, 3))))

mod_m <- lm(wis_private_total ~ mios_total + C2, data = tbl) %>% 
  broom::tidy() %>% 
  mutate_if(is.numeric, ~round(.x, 3)) %>% 
  mutate(p.value = if_else(
    p.value < 0.001,
    true  = "< 0.001", 
    false = as.character(round(p.value, 3))))

mod_y
mod_m








# -------------------------------------------------------------------------

x <- rnorm(n = 1e5, mean = 3, sd = .5)
y <- rnorm(n = 1e5, mean = 150, sd = 10) + .2 * x

cor.test(x, y, method = 'pearson')

lm(y ~ 1 + x) %>% 
  summary() %>% 
  broom::tidy()









# My main problem with this regression model is I
# don’t account for covariance between the dependent 
# variables. OR does it? eventually I fit the thing in SEM, and it is the same
# found out how to specify SEM models

library(lavaan)

data <- data %>% mutate(highest_rank = as.numeric(highest_rank))




model_0 <- 
  "
  wis_centrality_total ~ 0 * mios_total 
  wis_private_regard_total ~ 0 * mios_total 
  wis_public_regard_total ~ 0 * mios_total 
  wis_family_total ~ 0 * mios_total 
  wis_interdependent_total ~ 0 * mios_total 
  wis_connection_total ~ 0 * mios_total 
  wis_skills_total ~ 0 * mios_total 
  
  # Residual Covariances
    
    wis_centrality_total ~~ 0 * wis_connection_total
    wis_centrality_total ~~ 0 * wis_family_total
    wis_centrality_total ~~ 0 * wis_interdependent_total
    wis_centrality_total ~~ 0 * wis_private_regard_total
    wis_centrality_total ~~ 0 * wis_public_regard_total
    wis_centrality_total ~~ 0 * wis_skills_total
    
    wis_connection_total ~~ 0 * wis_family_total
    wis_connection_total ~~ 0 * wis_interdependent_total
    wis_connection_total ~~ 0 * wis_private_regard_total
    wis_connection_total ~~ 0 * wis_public_regard_total
    wis_connection_total ~~ 0 * wis_skills_total
    
    wis_family_total ~~ 0 * wis_interdependent_total
    wis_family_total ~~ 0 * wis_private_regard_total
    wis_family_total ~~ 0 * wis_public_regard_total
    wis_family_total ~~ 0 * wis_skills_total
    
    wis_interdependent_total ~~ 0 * wis_private_regard_total
    wis_interdependent_total ~~ 0 * wis_public_regard_total
    wis_interdependent_total ~~ 0 * wis_skills_total
    
    wis_private_regard_total ~~ 0 * wis_public_regard_total
    wis_private_regard_total ~~ 0 * wis_skills_total
    
    wis_skills_total ~~ 0 * wis_public_regard_total
"
fit_sem_0 <- lavaan::sem(model_0,  
                         meanstructure = F, 
                         data = data, 
                         orthogonal = T)
fit_sem_0 %>% summary()
fit_sem_0 %>% semPlot::semPaths()
fit_sem_0 %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))

model_1 <- 
  "
  wis_centrality_total ~ b1 * mios_total 
  wis_private_regard_total ~ b2 * mios_total 
  wis_public_regard_total ~ b3 * mios_total 
  wis_family_total ~ b4 * mios_total 
  wis_interdependent_total ~ b5 * mios_total 
  wis_connection_total ~ b6 * mios_total 
  wis_skills_total ~ b7 * mios_total 
  
  # Residual Covariances
    
    wis_centrality_total ~~ 0 * wis_connection_total
    wis_centrality_total ~~ 0 * wis_family_total
    wis_centrality_total ~~ 0 * wis_interdependent_total
    wis_centrality_total ~~ 0 * wis_private_regard_total
    wis_centrality_total ~~ 0 * wis_public_regard_total
    wis_centrality_total ~~ 0 * wis_skills_total
    
    wis_connection_total ~~ 0 * wis_family_total
    wis_connection_total ~~ 0 * wis_interdependent_total
    wis_connection_total ~~ 0 * wis_private_regard_total
    wis_connection_total ~~ 0 * wis_public_regard_total
    wis_connection_total ~~ 0 * wis_skills_total
    
    wis_family_total ~~ 0 * wis_interdependent_total
    wis_family_total ~~ 0 * wis_private_regard_total
    wis_family_total ~~ 0 * wis_public_regard_total
    wis_family_total ~~ 0 * wis_skills_total
    
    wis_interdependent_total ~~ 0 * wis_private_regard_total
    wis_interdependent_total ~~ 0 * wis_public_regard_total
    wis_interdependent_total ~~ 0 * wis_skills_total
    
    wis_private_regard_total ~~ 0 * wis_public_regard_total
    wis_private_regard_total ~~ 0 * wis_skills_total
    
    wis_skills_total ~~ 0 * wis_public_regard_total
"

fit_sem_1 <- lavaan::sem(model_1,  
                         meanstructure = F, 
                         data = data, 
                         orthogonal = T)
fit_sem_1 %>% summary()
fit_sem_1 %>% semPlot::semPaths()
fit_sem_1 %>% fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



model_2 <- 
  "
  wis_centrality_total ~ b1 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family 
  wis_private_regard_total ~ b2 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_public_regard_total ~ b3 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_family_total ~ b4 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_interdependent_total ~ b5 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_connection_total ~ b6 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_skills_total ~ b7 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  
  # Residual Covariances
    
    wis_centrality_total ~~ 0 * wis_connection_total
    wis_centrality_total ~~ 0 * wis_family_total
    wis_centrality_total ~~ 0 * wis_interdependent_total
    wis_centrality_total ~~ 0 * wis_private_regard_total
    wis_centrality_total ~~ 0 * wis_public_regard_total
    wis_centrality_total ~~ 0 * wis_skills_total
    
    wis_connection_total ~~ 0 * wis_family_total
    wis_connection_total ~~ 0 * wis_interdependent_total
    wis_connection_total ~~ 0 * wis_private_regard_total
    wis_connection_total ~~ 0 * wis_public_regard_total
    wis_connection_total ~~ 0 * wis_skills_total
    
    wis_family_total ~~ 0 * wis_interdependent_total
    wis_family_total ~~ 0 * wis_private_regard_total
    wis_family_total ~~ 0 * wis_public_regard_total
    wis_family_total ~~ 0 * wis_skills_total
    
    wis_interdependent_total ~~ 0 * wis_private_regard_total
    wis_interdependent_total ~~ 0 * wis_public_regard_total
    wis_interdependent_total ~~ 0 * wis_skills_total
    
    wis_private_regard_total ~~ 0 * wis_public_regard_total
    wis_private_regard_total ~~ 0 * wis_skills_total
    
    wis_skills_total ~~ 0 * wis_public_regard_total
"

fit_sem_2 <- lavaan::sem(model_2,  
                         meanstructure = F, 
                         data = data, 
                         orthogonal = T)
fit_sem_2 %>% summary()
fit_sem_2 %>% semPlot::semPaths()
fit_sem_2 %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



model_3 <- 
  "
  wis_centrality_total ~ b1 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family 
  wis_private_regard_total ~ b2 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_public_regard_total ~ b3 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_family_total ~ b4 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_interdependent_total ~ b5 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_connection_total ~ b6 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_skills_total ~ b7 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  
  # Residual Covariances
    
    wis_centrality_total ~~ 0 * wis_connection_total
    wis_centrality_total ~~ 0 * wis_family_total
    wis_centrality_total ~~ 0 * wis_interdependent_total
    wis_centrality_total ~~ 0 * wis_private_regard_total
    wis_centrality_total ~~ 0 * wis_public_regard_total
    wis_centrality_total ~~ 0 * wis_skills_total
    
    wis_connection_total ~~ cov1 * wis_family_total
    wis_connection_total ~~ 0 * wis_interdependent_total
    wis_connection_total ~~ 0 * wis_private_regard_total
    wis_connection_total ~~ 0 * wis_public_regard_total
    wis_connection_total ~~ 0 * wis_skills_total
    
    wis_family_total ~~ 0 * wis_interdependent_total
    wis_family_total ~~ 0 * wis_private_regard_total
    wis_family_total ~~ 0 * wis_public_regard_total
    wis_family_total ~~ 0 * wis_skills_total
    
    wis_interdependent_total ~~ 0 * wis_private_regard_total
    wis_interdependent_total ~~ 0 * wis_public_regard_total
    wis_interdependent_total ~~ 0 * wis_skills_total
    
    wis_private_regard_total ~~ cov2 * wis_public_regard_total
    wis_private_regard_total ~~ 0 * wis_skills_total
    
    wis_skills_total ~~ 0 * wis_public_regard_total
"

fit_sem_3 <- lavaan::sem(model_3,  
                         meanstructure = F, 
                         data = data, 
                         orthogonal = T)
fit_sem_3 %>% summary()
fit_sem_3 %>% semPlot::semPaths()
fit_sem_2 %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))
fit_sem_3 %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




model_4 <- 
  "
  wis_centrality_total ~ b1 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family 
  wis_private_regard_total ~ b2 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_public_regard_total ~ b3 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_family_total ~ b4 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_interdependent_total ~ b5 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_connection_total ~ b6 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  wis_skills_total ~ b7 * mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family  
  
  # Residual Covariances
    
    wis_centrality_total ~~ wis_connection_total
    wis_centrality_total ~~ wis_family_total
    wis_centrality_total ~~ wis_interdependent_total
    wis_centrality_total ~~ wis_private_regard_total
    wis_centrality_total ~~ wis_public_regard_total
    wis_centrality_total ~~ wis_skills_total
    
    wis_connection_total ~~ cov1 * wis_family_total
    wis_connection_total ~~ 0 * wis_interdependent_total
    wis_connection_total ~~ 0 * wis_private_regard_total
    wis_connection_total ~~ 0 * wis_public_regard_total
    wis_connection_total ~~ 0 * wis_skills_total
    
    wis_family_total ~~ 0 * wis_interdependent_total
    wis_family_total ~~ 0 * wis_private_regard_total
    wis_family_total ~~ 0 * wis_public_regard_total
    wis_family_total ~~ 0 * wis_skills_total
    
    wis_interdependent_total ~~ 0 * wis_private_regard_total
    wis_interdependent_total ~~ 0 * wis_public_regard_total
    wis_interdependent_total ~~ 0 * wis_skills_total
    
    wis_private_regard_total ~~ cov2 * wis_public_regard_total
    wis_private_regard_total ~~ 0 * wis_skills_total
    
    wis_skills_total ~~ 0 * wis_public_regard_total
"

fit_sem_4 <- lavaan::sem(model_4,  
                         meanstructure = F, 
                         data = data, 
                         orthogonal = T)
fit_sem_4 %>% summary()
fit_sem_4 %>% semPlot::semPaths()
fit_sem_3 %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))
fit_sem_4 %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




# PLS-SEM -----------------------------------------------------------------

library(seminr)

pls_1_model <- relationships(
  paths(from = "mios_total", 
        to = "wis_centrality_total")
)

pls_1 <- 
  estimate_pls(data = data,
               measurement_model = pls_1_model)
## Generating the seminr 

summary_corp_rep <- summary(corp_rep_pls_model)

