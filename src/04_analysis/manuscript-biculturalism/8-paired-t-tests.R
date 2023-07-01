
# POST HOC T-TESTS 

## Runs paied t-tests with Tukey's honest significant difference


# Library -----------------------------------------------------------------
library(ggfortify)

# Blendedness -------------------------------------------------------------
results_hsd_blendedness <- TukeyHSD(aov(biis_blendedness ~ mil_civ_cluster, data))

## Print
results_hsd_blendedness %>% broom::tidy()

## Save
results_hsd_blendedness %>% broom::tidy() %>% 
  write_csv('output/tables/tukeyhsd-blendedness.csv')

# Harmony -----------------------------------------------------------------
results_hsd_harmony <- TukeyHSD(aov(biis_harmony ~ mil_civ_cluster, data))  

## Print
results_hsd_harmony %>% broom::tidy()

## Save
results_hsd_harmony %>% broom::tidy() %>% 
  write_csv('output/tables/tukeyhsd-harmony.csv')

