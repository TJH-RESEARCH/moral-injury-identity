

# Load Packages -----------------------------------------------------------
library(lavaan)


# DAG suggests that conditioning on:
# combat, era, ptsd, sex_male, trauma
# will adjust the model to get the total effect of MI on MCARM
# This is still mediated by WIS and Civilian identity, 
# at the first level, and BIIS harmony and blendedness at the 
# second level. 

# Adjustment set: 
# Y = MCARM: Disability, Era, PTSD, Sex
# Y = WIS: Era, PTSD, Sex
# Y = Civilian ID: Era, PTSD, Sex
# Increased precision: 
# Y = MCARM: Branch, Rank, Years Separated, Years of Service
# Y = WIS: Job like military*
# Y = Civilian ID: Worship, Military Family, Years Separated, Job like military*

# *Job like military was not measured for those who are not employed.


# Model Direct -----------------------------------------------------------------

model_sem_direct <- 
  
  "
  
 # Regression Equations:
 mcarm_total ~ biis_harmony + biis_blendedness + mios_total + mios_ptsd_symptoms + service_era_persian_gulf + service_era_post_911 + service_era_vietnam + sex_male + disability
 biis_harmony + biis_blendedness ~ wis_total + civilian_commit_total
 wis_total ~ mios_total + mios_ptsd_symptoms + service_era_persian_gulf + service_era_post_911 + service_era_vietnam + sex_male + branch_air_force + branch_marines + branch_navy + race_white + military_family + years_service + years_separation + rank_e1_e3 + rank_e7_e9 + nonenlisted
 civilian_commit_total ~ mios_total + mios_ptsd_symptoms + years_separation + service_era_persian_gulf + service_era_post_911 + service_era_vietnam + sex_male + military_family + worship 
 
  "

fit_sem_direct <- lavaan::sem(model_sem_direct,  
                              meanstructure = F, 
                              data = data)

fit_sem_direct %>% lavaan::summary()
fit_sem_direct %>% semPlot::semPaths(layout = 'tree2', 
                                     whatLabels = 'est',
                                     residuals = F,
                                     rotation = 2
)


# Coefficients ------------------------------------------------------------

fit_sem_direct_sum <- fit_sem_direct %>% broom::tidy()
fit_sem_direct_sum

# Model G -----------------------------------------------------------------


# Total Effect

model_sem_total <- 
  
  "
 # Regression Equations:
 
  mcarm_total ~ mios_total + mios_ptsd_symptoms + service_era_persian_gulf + service_era_post_911 + service_era_vietnam + sex_male + disability
  biis_harmony + biis_blendedness ~ wis_total + civilian_commit_total
  wis_total ~ mios_total + mios_ptsd_symptoms + service_era_persian_gulf + service_era_post_911 + service_era_vietnam + sex_male + branch_air_force + branch_marines + branch_navy + race_white + military_family + years_service + years_separation + rank_e1_e3 + rank_e7_e9 + nonenlisted
  civilian_commit_total ~ mios_total + mios_ptsd_symptoms + years_separation + service_era_persian_gulf + service_era_post_911 + service_era_vietnam + sex_male + military_family + worship 
  
  "

fit_sem_total <- lavaan::sem(model_sem_total,  
                             meanstructure = F, 
                             data = data)
fit_sem_total %>% lavaan::summary()
fit_sem_total %>% semPlot::semPaths(layout = 'tree2')
fit_sem_total %>% lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 'AIC'))

fit_sem_total_sum <- fit_sem_total %>% broom::tidy()

fit_sem_total_sum %>% filter(
  term ==  "mcarm_total ~ mios_total"
)

# Inspect Path ------------------------------------------------------------

results <- 
  fit_sem_direct_sum %>% 
    filter(
      term ==  "mcarm_total ~ mios_total" |
        term ==    "mcarm_total ~ biis_blendedness" |
        term ==  "mcarm_total ~ biis_harmony" |
        term ==  "biis_harmony ~ wis_total" |
        term ==  "biis_blendedness ~ wis_total" |
        term ==  "biis_harmony ~ civilian_commit_total" |
        term ==  "biis_blendedness ~ civilian_commit_total" |
        term ==  'civilian_commit_total ~ mios_total' |
        term ==  'wis_total ~ mios_total'
    ) %>% mutate(model = 'direct') %>% 
    bind_rows(
      fit_sem_total_sum %>% filter(
        term ==  "mcarm_total ~ mios_total"
      ) %>% mutate(model = 'total')
    ) %>% select(model, everything())

results %>% mutate(p.value = round(p.value, digits =2))



# Plot Path Diagram -------------------------------------------------------

dag_basic <- dagitty::dagitty(
  "dag{
  Conflict -> MCARM; Compart -> MCARM; MI -> MCARM; MI -> WIS; MI -> CivilianID; WIS -> Compart; WIS -> Conflict;CivilianID -> Compart;CivilianID -> Conflict
  MI [exposure]
  MCARM [outcome]
  }")

ggdag::tidy_dagitty(dag_basic) %>% 
  mutate(index = c(7,5,2,1,NA,9,3,8,6,4)) %>% 
  arrange(index)

results %>% 
  filter(model != 'total') %>% 
  mutate(
  to = str_split_fixed(term, 
                          pattern = ' ~ ', 
                          n = 2)[,1],
  name = str_split_fixed(term, 
                          pattern = ' ~ ', 
                          n = 2)[,2]
  ) %>% 
    select(model, term, name, to, everything()) %>% 
  mutate(index = c(1,2,3,4,5,6,7,8,9))



lavaanToGraph(fit_sem_total) %>% 
  ggdag::tidy_dagitty() %>% 
  filter(name == 'biis_blendedness' & to == 'mcarm_total' |
         name == 'biis_harmony' & to == 'mcarm_total' |
         name == 'wis_total' & to == 'biis_blendedness' |
         name == 'wis_total' & to == 'biis_harmony' |
         name == 'civilian_commit_total' & to == 'biis_blendedness' |
         name == 'civilian_commit_total' & to == 'biis_harmony' |
         name == 'mios_total' & to == 'civilian_commit_total' |
         name == 'mios_total' & to == 'wis_total' | 
         name =='mcarm_total' | is.na(to)
         ) %>% 
  ggdag::ggdag(dag_basic, 
               edge_type = 'link', 
               text_size = 4, 
               text_col = "#0072B2", 
               node = F) + ggdag::theme_dag()
  



# Mediation ---------------------------------------------------------------



# Percent of MI->MCARM effect that is indirect:

(1 - (
  results %>% 
    filter(model == 'direct' & 
             term == 'mcarm_total ~ mios_total') %>% 
    select(estimate)
  /
    results %>% 
    filter(model == 'total' & 
             term == 'mcarm_total ~ mios_qtotal') %>% 
    select(estimate)
  )) * 100 %>% round(digits = 2)


# Standardized Estimates --------------------------------------------------

fit_sem_direct %>% 
  standardizedsolution() %>% 
  tibble() %>% 
  filter(
      lhs ==  'mcarm_total' & rhs == 'mios_total' |
      lhs ==  'mcarm_total' & rhs == 'biis_blendedness' |
      lhs ==  'mcarm_total' & rhs == 'biis_harmony' |
      lhs ==  'biis_harmony' & rhs == 'wis_total' |
      lhs ==  'biis_blendedness' & rhs == 'wis_total' |
      lhs ==  'biis_harmony' & rhs == 'civilian_commit_total' |
      lhs ==  'biis_blendedness' & rhs == 'civilian_commit_total' |
      lhs ==  'civilian_commit_total' & rhs == 'mios_total' |
      lhs ==  'wis_total' & rhs == 'mios_total'
  ) %>% 
  mutate(model = 'direct') %>% 
  bind_rows(
    fit_sem_total %>% 
      standardizedsolution() %>% 
      filter(
        lhs ==  'mcarm_total' & rhs == 'mios_total'
    ) %>% mutate(model = 'total')
  ) %>% select(model, everything())

results %>% mutate(p.value = round(p.value, digits =2))



# Save Fit Measures -------------------------------------------------------

tibble(
  
  metric = fit_sem_direct %>% 
    lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 
                          'nfi', 'nnfi', 'AIC')) %>% 
      as.matrix() %>% row.names(),
  
  value = fit_sem_direct %>% 
    lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 
                          'nfi', 'nnfi', 'AIC')) %>% as.numeric()
  
  ) %>% 
  mutate(model = 'fit_sem_direct') %>% 
  bind_rows(
    tibble(
      metric = fit_sem_total %>% 
        lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 
                          'nfi', 'nnfi', 'AIC')) %>% 
        as.matrix() %>% row.names(),
  
  value = fit_sem_total %>% 
    lavaan::fitMeasures(c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr', 
                          'nfi', 'nnfi', 'AIC')) %>% as.numeric()
  ) %>% mutate(model = 'fit_sem_total')
)
