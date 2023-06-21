
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

