


library(lavaan)




# Model A -----------------------------------------------------------------


model_sem_a <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_total + civilian_commit_total
 biis_harmony + biis_blendedness ~ wis_total + civilian_commit_total
 
  "

fit_sem_a <- lavaan::sem(model_sem_a,  
                             meanstructure = F, 
                             data = data)
fit_sem_a %>% summary()
fit_sem_a %>% semPlot::semPaths(layout = 'tree')
fit_sem_a %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



# Model B -----------------------------------------------------------------


model_sem_b <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_private_regard_total + wis_centrality_total + wis_connection_total + civilian_commit_total
 biis_harmony + biis_blendedness ~ wis_private_regard_total + wis_centrality_total + wis_connection_total + civilian_commit_total
 
 wis_private_regard_total ~~ wis_centrality_total
 wis_connection_total ~~ wis_private_regard_total
  "

fit_sem_b <- lavaan::sem(model_sem_b,  
                         meanstructure = F, 
                         data = data)
fit_sem_b %>% summary()
fit_sem_b %>% semPlot::semPaths(layout = 'tree')
fit_sem_b %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



# Model C -----------------------------------------------------------------

## adjustment set: WIS and Civilian Identity
## include the precision variables

model_sem_c <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_total + civilian_commit_total + unmet_needs_total + employment_unemployed + disability_percent
 biis_harmony + biis_blendedness ~ wis_total + civilian_commit_total
 
 
  "

fit_sem_c <- lavaan::sem(model_sem_c,  
                         meanstructure = F, 
                         data = data)
fit_sem_c %>% summary()
fit_sem_c %>% semPlot::semPaths(layout = 'tree')
fit_sem_c %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



# Model SEM D -------------------------------------------------------------
## Aim for strong fit

model_sem_d <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + scc_total + difi_distance + wis_total + civilian_commit_total + employment_unemployed + disability_percent
 biis_harmony ~  civilian_commit_total
 biis_blendedness ~ wis_total
 
 
  "

fit_sem_d <- lavaan::sem(model_sem_d,  
                         meanstructure = F, 
                         data = data)
fit_sem_d %>% summary()
fit_sem_d %>% semPlot::semPaths(layout = 'tree')
fit_sem_d %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



# Model SEM E -------------------------------------------------------------

## Add each WIS scale

model_sem_e <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + scc_total + wis_centrality_total + wis_connection_total + wis_family_total + wis_interdependent_total + wis_private_regard_total + wis_public_regard_total + civilian_commit_total + employment_unemployed + disability_percent
 biis_harmony ~  civilian_commit_total + wis_centrality_total + wis_connection_total + wis_family_total + wis_interdependent_total + wis_private_regard_total + wis_public_regard_total
 biis_blendedness ~ wis_centrality_total + wis_connection_total + wis_family_total + wis_interdependent_total + wis_private_regard_total + wis_public_regard_total
 
 
 
  "

fit_sem_e <- lavaan::sem(model_sem_e,  
                         meanstructure = F, 
                         data = data)
fit_sem_e %>% summary()
fit_sem_e %>% semPlot::semPaths(layout = 'tree')
fit_sem_e %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




# Model SEM F -------------------------------------------------------------

## Add each WIS scale

model_sem_f <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + scc_total + wis_centrality_total + wis_connection_total + wis_family_total + wis_interdependent_total + wis_private_regard_total + wis_public_regard_total + civilian_commit_total + employment_unemployed + disability_percent
 biis_harmony ~  civilian_commit_total + wis_family_total + wis_private_regard_total + wis_public_regard_total
 biis_blendedness ~ wis_centrality_total +  wis_private_regard_total + wis_public_regard_total
 
  "

fit_sem_f <- lavaan::sem(model_sem_f,  
                         meanstructure = F, 
                         data = data)
fit_sem_f %>% summary()
fit_sem_f %>% semPlot::semPaths(layout = 'tree')
fit_sem_f %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



# Model SEM G -------------------------------------------------------------

## Add each WIS scale

model_sem_g <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + scc_total + wis_centrality_total + wis_connection_total + wis_family_total + wis_interdependent_total + wis_private_regard_total + wis_public_regard_total + civilian_commit_total + employment_unemployed + disability_percent
 biis_harmony ~  civilian_commit_total + wis_family_total + wis_private_regard_total + wis_public_regard_total
 
  "

fit_sem_g <- lavaan::sem(model_sem_g,  
                         meanstructure = F, 
                         data = data)
fit_sem_g %>% summary()
fit_sem_g %>% semPlot::semPaths(layout = 'tree')
fit_sem_g %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




# Model SEM H -------------------------------------------------------------

## Add each WIS scale

model_sem_h <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + scc_total + wis_centrality_total + wis_connection_total + wis_family_total + wis_interdependent_total + wis_private_regard_total + wis_public_regard_total + civilian_commit_total + employment_unemployed + disability_percent
 biis_harmony ~  civilian_commit_total + wis_family_total + wis_private_regard_total + wis_public_regard_total
 
  "

fit_sem_h <- lavaan::sem(model_sem_g,  
                         meanstructure = F, 
                         data = data)
fit_sem_h %>% summary()
fit_sem_h %>% semPlot::semPaths(layout = 'tree')
fit_sem_h %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))








# Model I -----------------------------------------------------------------


model_sem_i <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_total + civilian_commit_total
 biis_harmony ~ wis_total + civilian_commit_total + wis_total:civilian_commit_total
 biis_blendedness ~ wis_total + civilian_commit_total + wis_total:civilian_commit_total
 
  "

fit_sem_i <- lavaan::sem(model_sem_i,  
                         meanstructure = F, 
                         data = data)
fit_sem_i %>% summary()
fit_sem_i %>% semPlot::semPaths(layout = 'tree')
fit_sem_i %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




# Model J -----------------------------------------------------------------

## WIS clusters

model_sem_j <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_cluster_h_1 + wis_cluster_h_2 + civilian_commit_total
 biis_harmony ~ wis_cluster_h_1 + wis_cluster_h_2 + civilian_commit_total
 biis_blendedness ~ wis_cluster_h_1 + wis_cluster_h_2 +  + civilian_commit_total
 
  "

fit_sem_j <- lavaan::sem(model_sem_j,  
                         meanstructure = F, 
                         data = data)
fit_sem_j %>% summary()
fit_sem_j %>% semPlot::semPaths(layout = 'tree')
fit_sem_j %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



# Model K -----------------------------------------------------------------

## WIS clusters + Civilian ID = 4 groups

model_sem_k <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_cluster_h_2 + wis_cluster_h_3 + civilian_commit_total
 biis_harmony ~ wis_cluster_h_2 + wis_cluster_h_3 + civilian_commit_total
 biis_blendedness ~ wis_cluster_h_2 + wis_cluster_h_3 + civilian_commit_total
 
  "

fit_sem_k <- lavaan::sem(model_sem_k,  
                         meanstructure = F, 
                         data = data)
fit_sem_k %>% summary()
fit_sem_k %>% semPlot::semPaths(layout = 'tree')
fit_sem_k %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




# Model L -----------------------------------------------------------------

## WIS clusters + Civilian ID = 4 groups

model_sem_l <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_cluster_h_2 + wis_cluster_h_3 + civilian_commit_total
 scc_total ~ biis_harmony + biis_blendedness
 biis_harmony ~ wis_cluster_h_2 + wis_cluster_h_3 + civilian_commit_total
 biis_blendedness ~ wis_cluster_h_2 + wis_cluster_h_3 + civilian_commit_total
 
  "

fit_sem_l <- lavaan::sem(model_sem_l,
                         meanstructure = F, 
                         data = data)
fit_sem_l %>% summary()
fit_sem_l %>% semPlot::semPaths(layout = 'tree', whatLabels = 'est')
fit_sem_l %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))






# Model M -----------------------------------------------------------------

## WIS clusters + Civilian ID = 4 groups

model_sem_m <- 
  "
  
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_cluster_h_3 + civilian_commit_total
 scc_total ~ biis_harmony
 biis_harmony ~ wis_cluster_h_2 + civilian_commit_total
 biis_blendedness ~ wis_cluster_h_2 + wis_cluster_h_3
 
  "

fit_sem_m <- lavaan::sem(model_sem_m,
                         meanstructure = F, 
                         data = data)
fit_sem_m %>% summary()
fit_sem_m %>% semPlot::semPaths(layout = 'tree', whatLabels = 'par',)
fit_sem_m %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))





# Model N -----------------------------------------------------------------

## WIS clusters + Civilian ID = 4 groups

model_sem_n <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + wis_cluster_h_3 + civilian_commit_total
 scc_total ~ biis_harmony
 biis_harmony ~ wis_cluster_h_2 + civilian_commit_total + wis_cluster_h_2:civilian_commit_total
 biis_blendedness ~ wis_cluster_h_2 + wis_cluster_h_3
 
  "

fit_sem_n <- lavaan::sem(model_sem_n,
                         meanstructure = F, 
                         data = data)
fit_sem_n %>% summary()
fit_sem_n %>% semPlot::semPaths(layout = 'tree', whatLabels = 'par',)
fit_sem_n %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




# Model O -----------------------------------------------------------------
data <-
  data %>% 
  mutate(civ_high = as.numeric(civilian_commit_total > median(civilian_commit_total)),
         high_mil_civ = civ_high * wis_cluster_h_2,
         high_civ_low_mil = civ_high * wis_cluster_h_3,
         low_civ_mil = ((civ_high - 1) * -1)  * wis_cluster_h_3,
         low_civ_high_mil = ((civ_high - 1) * -1)  * wis_cluster_h_2,
         )
  

model_sem_o <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + scc_total + difi_distance + high_mil_civ
 scc_total ~ biis_harmony + biis_blendedness
 biis_harmony ~ high_mil_civ
 biis_blendedness ~ high_mil_civ
 
  "

fit_sem_o <- lavaan::sem(model_sem_o,
                         meanstructure = F, 
                         data = data)
fit_sem_o %>% summary()
fit_sem_o %>% semPlot::semPaths(layout = 'tree', whatLabels = 'par',)
fit_sem_o %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))



# Model P -----------------------------------------------------------------
model_sem_p <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + wis_cluster_high + civilian_commit_total + employment_unemployed + disability_percent
 biis_harmony ~  wis_cluster_high + civilian_commit_total + wis_cluster_high:civilian_commit_total
 biis_blendedness ~  wis_cluster_high + civilian_commit_total + wis_cluster_high:civilian_commit_total
 
  "

fit_sem_p <- lavaan::sem(model_sem_p,
                         meanstructure = F, 
                         data = data)
fit_sem_p %>% summary()
fit_sem_p %>% semPlot::semPaths(layout = 'tree', whatLabels = 'par',)
fit_sem_p %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




# Good --------------------------------------------------------------------
## Use the sum WIS (continuous) and the sum civilian (continuous)
## DAG shows adjustment set {WIS, Civ} for mcarm on biis regression
## Precision set: Education, Unmet needs, Other discharge
##                Employed, PTSD, MI, Disabled
## Mediator: Self Concept Clarity

## start with an interaction term for WIS and Civilian
### shows no interaction & weakens the effect of each individually
## remove interaction term

# create numeric variable of education
data <- 
data %>% 
  mutate(education_num = as.numeric(data$education))

data <- 
  data %>% 
  mutate(discharge_other = ifelse(discharge_reason == 'Other', 1, 0))

## discharge other doesn't have enough respondents


# Model Q -----------------------------------------------------------------
## with interaction terms
model_sem_q <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + wis_total + civilian_commit_total + employment_unemployed + disability_percent + education_num + mios_ptsd_symptoms_none + mios_total
 biis_harmony ~  wis_total + civilian_commit_total + wis_total:civilian_commit_total
 biis_blendedness ~  wis_total + civilian_commit_total + wis_total:civilian_commit_total
 
  "

fit_sem_q <- lavaan::sem(model_sem_q,
                         meanstructure = F, 
                         data = data)
fit_sem_q %>% summary()
fit_sem_q %>% semPlot::semPaths(layout = 'tree', whatLabels = 'par',)
fit_sem_q %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))


# Model R -----------------------------------------------------------------

## No interaction terms

model_sem_r <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + wis_total + civilian_commit_total + employment_unemployed + disability_percent + education_num + mios_ptsd_symptoms_none + mios_total
 biis_harmony ~  wis_total + civilian_commit_total
 biis_blendedness ~  wis_total + civilian_commit_total
 
  "

fit_sem_r <- lavaan::sem(model_sem_r,
                         meanstructure = F, 
                         data = data)
fit_sem_r %>% summary()
fit_sem_r %>% semPlot::semPaths(layout = 'tree', whatLabels = 'par',)
fit_sem_r %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))





# Model S -----------------------------------------------------------------

## No MI or PTSD

model_sem_s <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + biis_blendedness + wis_total + civilian_commit_total + employment_unemployed + disability_percent + education_num
 biis_harmony ~  wis_total + civilian_commit_total
 biis_blendedness ~  wis_total + civilian_commit_total
 
  "

fit_sem_s <- lavaan::sem(model_sem_s,
                         meanstructure = F, 
                         data = data)
fit_sem_s %>% summary()
fit_sem_s %>% semPlot::semPaths(layout = 'tree', whatLabels = 'par',)
fit_sem_s %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))





# Model T -----------------------------------------------------------------

## Include MI and PTSD
## Drop the coefficients that are not statistically significant
### you should really only do that with theoretical rationales 

model_sem_t <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + wis_total + civilian_commit_total + employment_unemployed + education_num + mios_ptsd_symptoms_none + mios_total
 biis_harmony ~  wis_total + civilian_commit_total
 biis_blendedness ~  wis_total
 
  "

fit_sem_t <- lavaan::sem(model_sem_t,
                         meanstructure = F, 
                         data = data)
fit_sem_t %>% summary()
fit_sem_t %>% semPlot::semPaths(layout = 'tree', whatLabels = 'par',)
fit_sem_t %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))

fit_sem_t %>% lavaan::fitMeasures()


lm(mcarm_total ~ biis_harmony + wis_total + civilian_commit_total + employment_unemployed + education_num + mios_ptsd_symptoms_none + mios_total, data) %>% summary()
lm(biis_harmony ~  wis_total + civilian_commit_total, data) %>% summary()
lm(biis_blendedness ~ wis_total, data) %>% summary()



# Model U -----------------------------------------------------------------

## Mediator SCC

model_sem_u <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + wis_total + civilian_commit_total + scc_total + employment_unemployed + education_num + mios_ptsd_symptoms_none + mios_total
 scc_total ~ biis_harmony
 biis_harmony ~  wis_total + civilian_commit_total
 biis_blendedness ~  wis_total
 
 
 biis_blendedness ~~ 0 * mcarm_total
  "

fit_sem_u <- lavaan::sem(model_sem_u,
                         meanstructure = T, 
                         data = data)
fit_sem_u %>% summary()
fit_sem_u %>% 
  semPlot::semPaths(layout = 'tree2', whatLabels = 'par',)
fit_sem_u %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))




# Model V -----------------------------------------------------------------

## Mediator SCC

model_sem_v <- 
  "
 # Regression
 
 mcarm_total ~ biis_harmony + wis_total + civilian_commit_total + scc_total + employment_unemployed + education_num + mios_ptsd_symptoms_none + mios_total
 scc_total ~ biis_harmony
 biis_harmony ~  wis_total + civilian_commit_total
 biis_blendedness ~  wis_total
 
 
 biis_blendedness ~~ 0 * mcarm_total
  "

fit_sem_v <- lavaan::sem(model_sem_v,
                         meanstructure = T, 
                         data = data)
fit_sem_v %>% summary()
fit_sem_v %>% 
  semPlot::semPaths(layout = 'tree2', whatLabels = 'par',)
fit_sem_v %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))


