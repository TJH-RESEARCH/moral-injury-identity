
# POST HOC T-TESTS 

## Runs paied t-tests with Tukey's honest significant difference


# Library -----------------------------------------------------------------
library(ggfortify)

# Blendedness -------------------------------------------------------------
results_hsd_blendedness <- TukeyHSD(aov(biis_blendedness ~ mil_civ_cluster, data))

## Print
results_hsd_blendedness %>% broom::tidy() %>% select(!term)

## Save
results_hsd_blendedness %>% 
  broom::tidy() %>% 
  select(!term) %>% 
  mutate(across(!c(contrast, adj.p.value), ~ round(.x, digits = 2))) %>% 
  mutate(adj.p.value = round(adj.p.value, digits = 4)) %>% 
  write_csv('output/results/tukeyhsd-blendedness.csv')

# Harmony -----------------------------------------------------------------
results_hsd_harmony <- TukeyHSD(aov(biis_harmony ~ mil_civ_cluster, data))  

## Print
results_hsd_harmony %>% broom::tidy() %>% select(!term)

## Save
results_hsd_harmony %>% 
  broom::tidy() %>% 
  select(!term) %>% 
  mutate(across(!c(contrast, adj.p.value), ~ round(.x, digits = 2))) %>% 
  mutate(adj.p.value = round(adj.p.value, digits = 4)) %>% 
  write_csv('output/results/tukeyhsd-harmony.csv')

