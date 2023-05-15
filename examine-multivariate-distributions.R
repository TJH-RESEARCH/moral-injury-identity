



# Correlation Table -------------------------------------------------------
data %>% 
  select((ends_with('total') | ends_with('mean')) & !c('irvTotal')) %>% 
  cor()

# M2C-Q x M-CARM ------------------------------------------------------------
data %>% 
  ggplot(aes(m2cq_mean, mcarm_total)) +
  geom_point() + 
  geom_smooth(method = 'lm', formula = 'y ~ x', se = F)

# MIOS x M-CARM ------------------------------------------------------------
data %>% 
  ggplot(aes(mios_total, mcarm_total)) +
  geom_point() + 
  geom_smooth(method = 'lm', formula = 'y ~ x', se = F)

# MIOS x M2C-Q ------------------------------------------------------------
data %>% 
  ggplot(aes(mios_total, m2cq_mean)) +
  geom_point() + 
  geom_smooth(method = 'lm', formula = 'y ~ x', se = F)

# Unmet Needs x M2C-Q ------------------------------------------------------------
data %>% 
  ggplot(aes(unmet_needs_total, m2cq_mean)) +
  geom_point() + 
  geom_smooth(method = 'lm', formula = 'y ~ x', se = F)

