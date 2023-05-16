
# Inspect if there is a PTSD-MIOS Event-Symptom Cluster -------------------

data %>% 
  ggplot(aes(x = mios_ptsd_symptoms_total, 
             y = mios_total,
             color = as.factor(mios_screener),
             shape = as.factor(mios_criterion_a))) +
  geom_point(size = 3, alpha = .7)



# Inspect if there is a Identity Cluster ----------------------------------

data %>% 
  ggplot(aes(x = civilian_commit_total, 
             y = wis_public_regard_total,
             color = biis_total)) +
  geom_point(size = 3, alpha = .7)



# Principle Component Analysis: Warrior Identity Scale (WIS) ------------------

pca <- 
  data %>% 
    select(starts_with('wis') & ends_with('total')) %>% 
    prcomp() 

pca %>% 
  summary()

plot(pca, type = "l")


# -------------------------------------------------------------------------


data %>% 
  select(starts_with('wis') & ends_with('total')) %>% 
  cor() %>% 
  broom::tidy()


