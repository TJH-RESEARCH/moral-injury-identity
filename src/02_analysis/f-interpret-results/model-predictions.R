
# MAKE PREDICTIONS --------------------------------------------------------

data_baked_biis %>% 
  add_predictions(fit_biis) %>% 
  mutate(id = c(1:nrow(.))) %>% 
  select(id, biis_conflict, pred) %>% 
  pivot_longer(-id) %>% 
  ggplot(aes(value, color = name)) + 
  geom_density() #+
#facet_wrap(~name)

data_baked_interact %>% 
  add_predictions(fit_interact) %>% 
  mutate(id = c(1:nrow(.))) %>% 
  select(id, biis_conflict, pred) %>% 
  pivot_longer(-id) %>% 
  ggplot(aes(value, color = name)) + 
  geom_density() #+
#facet_wrap(~name)

data_baked_wis %>% 
  add_predictions(fit_wis) %>% 
  mutate(id = c(1:nrow(.))) %>% 
  select(id, wis_interdependent_total, pred) %>% 
  pivot_longer(-id) %>% 
  ggplot(aes(value, color = name)) + 
  geom_density()# +
#facet_wrap(~name)
