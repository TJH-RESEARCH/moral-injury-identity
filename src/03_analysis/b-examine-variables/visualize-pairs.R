


# Main Variables: Pair Plots --------------------------------------------------------------
data %>% 
  select(mios_total, wis_interdependent_total, biis_conflict) %>% 
  GGally::ggpairs()

# Main Variables: Pair Plots: Square Root Transformation to MIOS ----------------------------------------------
data %>% 
  mutate(mios_total = sqrt(mios_total)) %>% 
  select(mios_total, wis_interdependent_total, biis_conflict) %>% 
  GGally::ggpairs()


# Trauma  ----------------------------------------------
data %>% 
  mutate(mios_screener = as.factor(mios_screener), 
         pc_ptsd_positive_screen = as.factor(pc_ptsd_positive_screen)) %>% 
  select(mios_total, mios_screener, pc_ptsd_positive_screen) %>% 
  GGally::ggpairs()

# Trauma: Square Root Transformation  ----------------------------------------------
data %>% 
  mutate(mios_total = sqrt(mios_total),
         mios_screener = as.factor(mios_screener), 
         pc_ptsd_positive_screen = as.factor(pc_ptsd_positive_screen)) %>% 
  select(mios_total, mios_screener, pc_ptsd_positive_screen) %>% 
  GGally::ggpairs()

## MIOS total is almost bi-modal, with some people not having any symptoms
## and not having exposure to MI event.
## It is worth rerunning analysis with only MI event positive screening


# Identity Dissonance  ----------------------------------------------
data %>% 
  select(scc_total, biis_conflict, biis_blendedness) %>% 
  GGally::ggpairs()


# Warrior Identity Scale  ----------------------------------------------
data %>% 
  select(starts_with('wis_') & ends_with('total')) %>% 
  GGally::ggpairs()




