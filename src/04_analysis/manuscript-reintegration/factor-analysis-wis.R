data <-
  data %>% 
  mutate(wis_fk_total = 
           
           wis_private_2 +
           wis_private_3 +
           wis_private_4 +
           wis_private_6 +
           
           wis_interdependent_10 +
           wis_interdependent_11 +
           wis_interdependent_12 +
           
           wis_connection_15 +
           wis_connection_16 +
           wis_connection_17 +
           
           wis_family_18 +
           wis_family_19 +
           wis_family_20 +
           
           wis_centrality_22 +
           wis_centrality_23 +
           wis_centrality_24 +
           
           wis_public_25 +
           wis_public_26 +
           wis_public_27 +
           wis_public_28
           
           )





library(tidyverse)
library(lavaan)



# Confirmatory Factor Analysi


# WIS --------------------------------------------------------------------

data %>% select(starts_with('wis')) %>% psych::describe()

## Internal Consistency


## SEM
model_cfa_wis_31 <-
  '
  centrality =~ wis_centrality_21 + wis_centrality_22 + wis_centrality_23 + wis_centrality_24    
  connection =~ wis_connection_15 + wis_connection_16 + wis_connection_17
  family =~ wis_family_18 + wis_family_19 + wis_family_20
  interdependent =~ wis_interdependent_8 + wis_interdependent_9 + wis_interdependent_10 + wis_interdependent_11 + wis_interdependent_12 + wis_interdependent_13 + wis_interdependent_14
  public =~ wis_public_25 + wis_public_26 + wis_public_27 + wis_public_28
  private =~ wis_private_1 + wis_private_2 + wis_private_3 + wis_private_4 + wis_private_5 + wis_private_6 + wis_private_7
  skills =~ wis_skills_29 + wis_skills_30 + wis_skills_31
  wis =~ 1 * centrality + 1 * connection + 1 * family + 1 * interdependent + 1 * public + 1 * private + 1 * skills
  
    wis ~~ wis'
fit_cfa_wis_31 <- lavaan::cfa(model_cfa_wis_31, data = data)
fit_cfa_wis_31 %>% summary(fit.measures = T, standardized = T)
fit_cfa_wis_31 %>% semPlot::semPaths(curvePivot = TRUE)
lavaan::standardizedsolution(fit_cfa_wis_31)

# Fit Measures:
lavaan::fitMeasures(fit_cfa_wis_31)

# Factor Loadings:
lavaan::inspect(fit_cfa_wis_31, what = "std")$lambda

# EFA ------------------------------------------------------------------
model_efa_wis_31 <-
  data %>% 
  select(starts_with('wis') &
          !contains('cluster') & 
           !ends_with('total')) %>% 
  lavaan::efa(nfactors = 7) 

model_efa_wis_31_sum <- 
  model_efa_wis_31 %>% 
  summary()
model_efa_wis_31_sum

# -------------------------------------------------------------------------


## SEM
model_cfa_wis_20 <-
  '
  centrality =~ wis_centrality_22 + wis_centrality_23 + wis_centrality_24    
  connection =~ wis_connection_15 + wis_connection_16 + wis_connection_17
  family =~ wis_family_18 + wis_family_19 + wis_family_20
  interdependent =~ wis_interdependent_10 + wis_interdependent_11 + wis_interdependent_12
  public =~ wis_public_25 + wis_public_26 + wis_public_27 + wis_public_28
  private =~ wis_private_2 + wis_private_3 + wis_private_4 + wis_private_6
  
  wis =~ 1 * centrality + 1 * connection + 1 * family + 1 * interdependent + 1 * public + 1 * private
  
    wis ~~ wis'
fit_cfa_wis_20 <- lavaan::cfa(model_cfa_wis_20, data = data)
fit_cfa_wis_20 %>% summary(fit.measures = T, standardized = T)
fit_cfa_wis_20 %>% semPlot::semPaths(curvePivot = TRUE)
lavaan::standardizedsolution(fit_cfa_wis_20)

# Fit Measures:
lavaan::fitMeasures(fit_cfa_wis_20)

# Factor Loadings:
lavaan::inspect(fit_cfa_wis_20, what = "std")$lambda

# EFA ------------------------------------------------------------------
model_efa_wis_20 <-
  data %>% 
  select(
    
    
    wis_private_2,
      wis_private_3,
      wis_private_4,
      wis_private_6,
      
      wis_interdependent_10,
      wis_interdependent_11,
      wis_interdependent_12,
      
      wis_connection_15,
      wis_connection_16,
      wis_connection_17,
      
      wis_family_18,
      wis_family_19,
      wis_family_20,
      
      wis_centrality_22,
      wis_centrality_23,
      wis_centrality_24,
      
      wis_public_25,
      wis_public_26,
      wis_public_27,
      wis_public_28
    
  ) %>% 
  lavaan::efa(nfactors = 2:6) 

model_efa_wis_20_sum <- 
  model_efa_wis_20 %>% 
  summary()
model_efa_wis_20_sum
