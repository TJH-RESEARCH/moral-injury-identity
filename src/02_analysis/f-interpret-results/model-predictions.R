
library(modelr)

# MAKE PREDICTIONS --------------------------------------------------------
### These graph the density of the original outcome variables vs. 
### the predicted outcome variables. This is essentially a 
### "posterior predictive check" which is common to Bayesian data analysis. 
### As the models were fit to the same data that we are now comparing, 
### a good fitting model should have a similar distribution to the original data.


data_baked_wis %>% 
  add_predictions(fit_wis) %>% 
  mutate(id = c(1:nrow(.))) %>% 
  select(id, wis_interdependent_total, pred) %>% 
  pivot_longer(-id) %>% 
  ggplot(aes(value, color = name)) + 
  geom_density()# +
#facet_wrap(~name)

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

data_baked_wis_m2cq %>% 
  add_predictions(fit_wis_m2cq) %>% 
  mutate(id = c(1:nrow(.))) %>% 
  select(id, m2cq_mean, pred) %>% 
  pivot_longer(-id) %>% 
  ggplot(aes(value, color = name)) + 
  geom_density()# +
#facet_wrap(~name)

data_baked_biis_m2cq %>% 
  add_predictions(fit_biis_m2cq) %>% 
  mutate(id = c(1:nrow(.))) %>% 
  select(id, m2cq_mean, pred) %>% 
  pivot_longer(-id) %>% 
  ggplot(aes(value, color = name)) + 
  geom_density() #+
#facet_wrap(~name)