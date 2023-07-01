

# ANOVA


# Blendedness -------------------------------------------------------------
results_aov_blended <- 
  data %>% 
    rename(Civilian = civilian_cluster, 
           Military = wis_cluster) %>% 
    aov(biis_blendedness ~ Civilian * Military, .)

## Print Results
results_aov_blended %>% summary()

## Tidy results
results_aov_blended %>% broom::tidy()

## Coefficients
results_aov_blended$coefficients


# Harmony -----------------------------------------------------------------
results_aov_harmony <- 
  data %>% 
  rename(Civilian = civilian_cluster, 
         Military = wis_cluster) %>% 
  aov(biis_harmony ~ Civilian * Military, .)

## Print
results_aov_harmony %>% summary()

## Tidy results
results_aov_harmony %>% broom::tidy()

## Coefficients
results_aov_harmony$coefficients



# Non-Parametric ANOVA----------------------------------------------------------

kruskal.test(biis_blendedness ~ 
               mil_civ_cluster, data)

kruskal.test(biis_harmony ~ 
               mil_civ_cluster, data)

stats::oneway.test(biis_harmony ~ mil_civ_cluster, data)
stats::oneway.test(biis_blendedness ~ mil_civ_cluster, data)
