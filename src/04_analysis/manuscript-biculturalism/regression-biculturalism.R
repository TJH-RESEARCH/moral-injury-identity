


# Run the WIS cluster -----------------------------------------------------
source(here::here('src/04_analysis/manuscript-moral-injury-identity-wound/cluster-wis.R'))



# Correlation -------------------------------------------------------------

data %>% 
  select(biis_harmony, 
         biis_blendedness, 
         biis_total, 
         civilian_commit_total,
         (starts_with('wis') & contains('total') & !contains('cluster'))) %>% 
  corrr::correlate()
  

# Regression --------------------------------------------------------------
data %>% 
  lm(mcarm_total ~  biis_harmony + biis_blendedness + scc_total, .) %>% 
  lm.beta::lm.beta() %>% 
  broom::tidy()


# Robust to other measure of reintegration? -------------------------------
data %>% 
  lm(m2cq_mean ~  biis_harmony + biis_blendedness + scc_total, .) %>% 
  lm.beta::lm.beta() %>% 
  broom::tidy()


# SEM ---------------------------------------------------------------------


