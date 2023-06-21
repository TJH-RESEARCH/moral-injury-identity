


library(tidyverse)
library(lavaan)


# Read the data ------------------------------------------------------------
data <- readr::read_csv(here::here('data/processed/data-cleaned.csv'))


# Confirmatory Factor Analysis



# BIIS --------------------------------------------------------------------

data %>% select(starts_with('biis')) %>% psych::describe()

data %>% 
  select(starts_with('biis') &
         !ends_with('harmony') & 
         !ends_with('blendedness') &
         !ends_with('total')) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)


## Internal Consistency
data %>% 
  select(starts_with('biis') &
           !ends_with('harmony') & 
           !ends_with('blendedness') &
           !ends_with('total')) %>% 
  psych::alpha()


## Consistency: BIIS Harmony
data %>% 
  select(biis_1, biis_2, biis_3, biis_4, biis_5, biis_6, biis_7, biis_8, biis_9, biis_10) %>% 
  psych::alpha()

## Consistency: BIIS Blendedness
  data %>% 
    select(biis_11, biis_12, biis_13, biis_14, biis_15, biis_16, biis_17) %>% 
  psych::alpha()
  
## SEM
model_cfa_biis_1 <-
    'harmony =~ biis_1 + biis_2 + biis_3 + biis_4 + biis_5 + biis_6 + biis_7 + biis_8 + biis_9 + biis_10
    blendedness =~ biis_11 + biis_12 + biis_13 + biis_14 + biis_15 + biis_16 + biis_17
    biis =~ 1 * harmony + 1 * blendedness
    biis ~~ biis'
fit_cfa_biis_1 <- cfa(model_cfa_biis_1, data = data)
fit_cfa_biis_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_biis_1 %>% semPlot::semPaths(curvePivot = TRUE)
lavaan::standardizedsolution(fit_cfa_biis_1)

# Fit Measures:
lavaan::fitMeasures(model_efa_biis_1)

# Factor Loadings:
inspect(fit_cfa_biis_1, what = "std")$lambda

# EFA
model_efa_biis_1 <-
  data %>% 
  select(starts_with('biis') &
           !ends_with('harmony') & 
           !ends_with('blendedness') &
           !ends_with('total')) %>% 
  lavaan::efa(nfactors = 1:3) 

model_efa_biis_1_sum <- 
  model_efa_biis_1 %>% 
  summary()





model_cfa_biis_harmony <-
  'harmony =~ biis_1 + biis_2 + biis_3 + biis_4 + biis_5 + biis_6 + biis_7 + biis_8 + biis_9 + biis_10
    harmony ~~ harmony'
fit_cfa_biis_harmony <- cfa(model_cfa_biis_harmony, data = data)
fit_cfa_biis_harmony %>% summary(fit.measures = T, standardized = T)
fit_cfa_biis_harmony %>% semPlot::semPaths(curvePivot = TRUE)

model_cfa_biis_blendedness <-
  'blendedness =~ biis_11 + biis_12 + biis_13 + biis_14 + biis_15 + biis_16 + biis_17
    blendedness ~~ blendedness'
fit_cfa_biis_blendedness <- cfa(model_cfa_biis_blendedness, data = data)
fit_cfa_biis_blendedness %>% summary(fit.measures = T, standardized = T)
fit_cfa_biis_blendedness %>% semPlot::semPaths(curvePivot = TRUE)


# Civilian Commitment -----------------------------------------------------

data %>% select(starts_with('civilian_commit')) %>% psych::describe()

## Corr Plot: Civilian Commitment
data %>% 
  select(starts_with('civilian_commit') & !ends_with('total')) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)

## Internal Consistency
data %>% 
  select(starts_with('civilian_commit') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_civilian_commit_1 <- 
  'civilian_commit =~  civilian_commit_1 + civilian_commit_2 + civilian_commit_3 + civilian_commit_4
civilian_commit ~~ civilian_commit'

fit_cfa_civilian_commit_1 <- cfa(model_cfa_civilian_commit_1, data = data)
fit_cfa_civilian_commit_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_civilian_commit_1 %>% semPlot::semPaths(curvePivot = TRUE)


# M2CQ --------------------------------------------------------------------

data %>% select(starts_with('m2cq')) %>% psych::describe()

data %>% 
  select(starts_with('m2cq') & !ends_with('mean')) %>% 
  na.omit() %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)

## Internal Consistency: M2CQ
data %>% 
  select(starts_with('m2cq') & !ends_with('mean')) %>%
  psych::alpha()

model_cfa_m2cq_1 <- 
  'm2cq =~ m2cq_1 + m2cq_2 + m2cq_3 + m2cq_4 + m2cq_5 + m2cq_6 + m2cq_7 + m2cq_8 + m2cq_9 + m2cq_10 + m2cq_11 + m2cq_12 + m2cq_13 + m2cq_14 + m2cq_15 + m2cq_16
   m2cq ~~ m2cq'
fit_cfa_m2cq_1 <- cfa(model_cfa_m2cq_1, data = data)
fit_cfa_m2cq_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_m2cq_1 %>% semPlot::semPaths(curvePivot = TRUE)


# MCARM --------------------------------------------------------------------

data %>% select(starts_with('mcarm')) %>% psych::describe()

## Corr Plot: MCARM
data %>% 
  select(starts_with('mcarm') & 
           !ends_with('connection') &
           !ends_with('civilians') &
           !ends_with('seeking') &
           !ends_with('regret') &
           !ends_with('regimentation') &
           !ends_with('total')
         ) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)


## Internal Consistency: MCARM
data %>% 
  select(starts_with('mcarm') & 
           !ends_with('connection') &
           !ends_with('civilians') &
           !ends_with('seeking') &
           !ends_with('regret') &
           !ends_with('regimentation') &
           !ends_with('total')) %>% 
  psych::alpha()

model_cfa_mcarm_1 <- 
  'purpose_connection =~  mcarm_1 + mcarm_2 + mcarm_3 + mcarm_4 + mcarm_5 + mcarm_6
  help_seeking =~ mcarm_7 + mcarm_8 + mcarm_9 + mcarm_10
  beliefs_about_civilians =~ mcarm_11 + mcarm_12 + mcarm_13
  resentment_regret =~ mcarm_14 + mcarm_15 + mcarm_16
  regimentation =~ mcarm_17 + mcarm_18 + mcarm_19 + mcarm_20 + mcarm_21

  mcarm =~ 1 * purpose_connection + 1 * help_seeking + 1 * beliefs_about_civilians + 1 * resentment_regret + 1 * regimentation
  mcarm ~~ mcarm'
fit_cfa_mcarm_1 <- cfa(model_cfa_mcarm_1, data = data)
fit_cfa_mcarm_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_mcarm_1 %>% semPlot::semPaths(curvePivot = T)


# MIOS --------------------------------------------------------------------

data %>% select(starts_with('mcarm')) %>% psych::describe()

## Corr Plot: MIOS Shame
data %>% 
  select(mios_1, mios_3, mios_7, mios_8, mios_12, mios_13, mios_14) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)

## Consistency: MIOS Shame
data %>% 
  select(mios_1, mios_3, mios_7, mios_8, mios_12, mios_13, mios_14) %>% 
  psych::alpha()

## Corr Plot: MIOS Trust Violation
data %>% 
  select(mios_2, mios_4, mios_5, mios_6, mios_9, mios_10, mios_11) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)

## Consistency: MIOS Trust Violation
data %>% 
  select(mios_2, mios_4, mios_5, mios_6, mios_9, mios_10, mios_11) %>% 
  psych::alpha()

## Consistency: MIOS Total
data %>% 
  select(mios_1, mios_3, mios_7, mios_8, mios_12, mios_13, mios_14, 
         mios_2, mios_4, mios_5, mios_6, mios_9, mios_10, mios_11) %>% 
  psych::alpha()
           
model_cfa_mios_1 <- 
  'shame =~ mios_1 + mios_3 + mios_7 + mios_8 + mios_12 + mios_13 + mios_14
    trust =~ mios_2 + mios_4 + mios_5 + mios_6 + mios_9 + mios_10 + mios_11
    mios =~ 1*shame + 1*trust
    mios ~~ mios'

fit_cfa_mios_1 <- cfa( 'shame =~ mios_1 + mios_3 + mios_7 + mios_8 + mios_12 + mios_13 + mios_14
    trust =~ mios_2 + mios_4 + mios_5 + mios_6 + mios_9 + mios_10 + mios_11
    mios =~ 1*shame + 1*trust
    mios ~~ mios', data = data)

fit_cfa_mios_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_mios_1 %>% semPlot::semPaths(curvePivot = TRUE)



# SCC --------------------------------------------------------------------

data %>% select(starts_with('scc')) %>% psych::describe()

## Corr Plot: SCC
data %>% 
  select(starts_with('scc') & !ends_with('total')) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)

## Consistency: SCC
data %>% 
  select(starts_with('scc') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_scc_1 <- 
  'scc =~ scc_1 + scc_2 + scc_3 + scc_4 + scc_5 + scc_6 + scc_7 + scc_8 + scc_9 + scc_10 + scc_11 + scc_12
    scc ~~ scc'
fit_cfa_scc_1 <- cfa(model_cfa_scc_1, data = data)
fit_cfa_scc_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_scc_1 %>% semPlot::semPaths(curvePivot = TRUE)


# WIS Scales ---------------------------------------------------------------


## WIS Private Regard
data %>% 
  select(starts_with('wis_private') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_wis_private_1 <-
  'private_regard =~ wis_private_1 + wis_private_2 + wis_private_3 + wis_private_4 + wis_private_5 + wis_private_6 + wis_private_7
  private_regard ~~ private_regard'
fit_cfa_scc_1 <- cfa(model_cfa_scc_1, data = data)
fit_cfa_scc_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_scc_1 %>% semPlot::semPaths(curvePivot = TRUE)


## WIS Interdependence
data %>% 
  select(starts_with('wis_interdependent') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_wis_interdependent_1 <- 
  'interdependent =~ wis_interdependent_8 + wis_interdependent_9 + wis_interdependent_10 + wis_interdependent_11 + wis_interdependent_12 + wis_interdependent_13 + wis_interdependent_14
   interdependent ~~ interdependent'
fit_cfa_interdependent_1 <- cfa(model_cfa_wis_interdependent_1, data = data)
fit_cfa_interdependent_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_interdependent_1 %>% semPlot::semPaths(curvePivot = TRUE)


## WIS Connection
data %>% 
  select(starts_with('wis_connection') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_wis_connection_1 <- 
  'connection =~ wis_connection_15 + wis_connection_16 + wis_connection_17
    connection ~~ connection'
fit_cfa_wis_connection_1 <- cfa(model_cfa_wis_connection_1, data = data)
fit_cfa_wis_connection_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_wis_connection_1 %>% semPlot::semPaths(curvePivot = TRUE)


## WIS Family

data %>% 
  select(starts_with('wis_family') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_wis_family_1 <- 
  'family =~ wis_family_18 + wis_family_19 + wis_family_20
    family ~~ family'
fit_cfa_family_1 <- cfa(model_cfa_wis_family_1, data = data)
fit_cfa_family_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_family_1 %>% semPlot::semPaths(curvePivot = TRUE)


## WIS Centrality

data %>% 
  select(starts_with('wis_centrality') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_wis_centrality_1 <- 
    'centrality =~ wis_centrality_21 + wis_centrality_22 + wis_centrality_23 + wis_centrality_24
      centrality ~~ centrality'
fit_cfa_centrality_1 <- cfa(model_cfa_wis_centrality_1, data = data)
fit_cfa_centrality_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_centrality_1 %>% semPlot::semPaths(curvePivot = TRUE)

## WIS Public

data %>% 
  select(starts_with('wis_public') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_wis_public_1 <- 
  'public_regard =~ wis_public_25 + wis_public_26 + wis_public_27 + wis_public_28
    public_regard ~~ public_regard'
fit_cfa_wis_public_1 <- cfa(model_cfa_wis_public_1, data = data)
fit_cfa_wis_public_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_wis_public_1 %>% semPlot::semPaths(curvePivot = TRUE)


## WIS Skills

data %>% 
  select(starts_with('wis_skills') & !ends_with('total')) %>% 
  psych::alpha()

model_cfa_wis_skills_1 <- 
  'skills =~ wis_skills_29 + wis_skills_30 + wis_skills_31
    skills ~~ skills'
fit_cfa_wis_skills_1 <- cfa(model_cfa_wis_skills_1, data = data)
fit_cfa_wis_skills_1 %>% summary(fit.measures = T, standardized = T)
fit_cfa_wis_skills_1 %>% semPlot::semPaths(curvePivot = TRUE)




## WIS Total Score

data <-
  data %>% 
  mutate(wis_score =
           wis_private_regard_total +
           wis_interdependent_total +
           wis_connection_total +
           wis_family_total +
           wis_centrality_total + 
           wis_public_regard_total + 
           wis_skills_total)

hist(data$wis_score)

data %>% 
  select(starts_with('wis_') & !ends_with('total') & !wis_score) %>% 
  psych::alpha()

model_wis_grand <-
  'private_regard =~ wis_private_1 + wis_private_2 + wis_private_3 + wis_private_4 + wis_private_5 + wis_private_6 + wis_private_7
    interdependent =~ wis_interdependent_8 + wis_interdependent_9 + wis_interdependent_10 + wis_interdependent_11 + wis_interdependent_12 + wis_interdependent_13 + wis_interdependent_14
    connection =~ wis_connection_15 + wis_connection_16 + wis_connection_17
    family =~ wis_family_18 + wis_family_19 + wis_family_20
    centrality =~ wis_centrality_21 + wis_centrality_22 + wis_centrality_23 + wis_centrality_24
    public_regard =~ wis_public_25 + wis_public_26 + wis_public_27 + wis_public_28
    skills =~ wis_skills_29 + wis_skills_30 + wis_skills_31
    
    centrality ~~ centrality
    interdependent ~~ interdependent
    connection ~~ connection
    family ~~ family
    public_regard ~~ public_regard
    private_regard ~~ private_regard
    skills ~~ skills

total =~ 1 * centrality + 1 * interdependent + 1 * connection + 1 * family + 1 * public_regard + 1 * private_regard + 1 * skills
'


fit_wis_grand <- lavaan::cfa(model_wis_grand, data = data)
fit_wis_grand %>% lavaan::summary(fit.measures = T, standardized = T)
fit_wis_grand %>% semPlot::semPaths(curvePivot = TRUE)



lm(wis_score ~ mios_total, data) %>% summary()


# WIS Current Self Concept: Centrality & interdependent
# WIS Memory: Family, connection, & skills
# WIS Regard: public & private

# WIS MEMORY
data %>% 
  select((contains('wis_centrality') | contains('wis_interdependent') | contains('wis_inter')) & !ends_with('total')) %>% 
  psych::alpha()


# WIS MEMORY
data %>% 
  select((contains('wis_family') | contains('wis_connection') | contains('wis_inter')) & !ends_with('total')) %>% 
  psych::alpha()

# WIS REGARD
data %>% 
  select((contains('wis_private') | contains('wis_public')) & !ends_with('total')) %>% 
  psych::alpha()


data <-
  data %>% 
  mutate(wis_regard_score =
           wis_private_regard_total +
           wis_public_regard_total, 
         wis_memory_score = 
           wis_connection_total +
           wis_family_total,
        wis_current_score =
           wis_interdependent_total +
           wis_centrality_total + 
           wis_skills_total)

