
model_results <-
  model_results %>% 
  mutate(IV = 
           if_else(
             IV == 'mios_total, military_exp_combat, pc_ptsd_positive_screen, sex_male, race_white, race_black, enlisted, years_separation, years_service', 
             'mios_total + controls', 
             IV)
  ) %>% 
  mutate(IV = 
           if_else(
             IV == 'mios_screener, military_exp_combat, pc_ptsd_positive_screen, sex_male, race_white, race_black, enlisted, years_separation, years_service', 
             'mios_screener + controls', 
             IV)
  )


model_results %>%   
  mutate(significant_at_05 = factor(if_else(p.value <= .05, T, F))) %>% 
  filter(term == 'mios_total' | term == 'mios_screener') %>% 
  filter(DV == 'interdependent' |
           DV == 'centrality' |
           DV == 'connection' |
           DV == 'family' |
           DV == 'private_regard' |
           DV == 'public_regard' |
           DV == 'skills') %>% 
  ggplot(aes(std_estimate, 
             DV, 
             color = significant_at_05, 
             shape = IV)) +
  geom_point(size = 15, alpha = .8) +
  scale_color_discrete(type = 'viridis') +
  labs(title = 'Moral Injury impact on Military Identity',
       subtitle = 'Comparing Symptoms and Events, with and without Controls') +
  theme_classic()



model_results %>%   
  mutate(significant_at_05 = factor(if_else(p.value <= .05, T, F))) %>% 
  filter(term == 'mios_total' | term == 'mios_screener') %>% 
  filter(DV == 'biis' |
           DV == 'scc' |
           DV == 'biis_conflit' |
           DV == 'biis_blendedness') %>% 
  ggplot(aes(std_estimate, 
             DV, 
             color = significant_at_05, 
             shape = IV)) +
  geom_point(size = 15, alpha = .8) +
  scale_color_discrete(type = 'viridis') +
  labs(title = 'Moral Injury impact on Identity Dissonance',
       subtitle = 'Comparing Symptoms and Events, with and without Controls') +
  theme_classic()


# HEX ---------------------------------------------------------------------



model_results %>%   
  mutate(significant_at_05 = factor(if_else(p.value <= .05, T, F))) %>% 
  filter(term == 'mios_total' | term == 'mios_screener') %>% 
  filter(DV == 'interdependent' |
           DV == 'centrality' |
           DV == 'connection' |
           DV == 'family' |
           DV == 'private_regard' |
           DV == 'public_regard' |
           DV == 'skills') %>% 
  ggplot(aes(IV, 
             DV,
             fill = -std_estimate)) +
  geom_tile() +
  scale_fill_continuous(type = 'viridis') +
  geom_text(aes(label = round(std_estimate, 2), color = std_estimate)) +
  scale_color_continuous(type = 'viridis',) +
  labs(title = 'Moral Injury: Standardized Coefficients')




model_results %>%   
  mutate(significant_at_05 = factor(if_else(p.value <= .05, T, F))) %>% 
  filter(term == 'mios_total' | term == 'mios_screener') %>% 
  filter(DV == 'interdependent' |
           DV == 'centrality' |
           DV == 'connection' |
           DV == 'family' |
           DV == 'private_regard' |
           DV == 'public_regard' |
           DV == 'skills') %>% 
  ggplot(aes(IV, 
             DV,
             fill = -p.value)) +
  geom_tile() +
  scale_fill_continuous(type = 'viridis') +
  geom_text(aes(label = round(p.value, 2), color = p.value)) +
  scale_color_continuous(type = 'viridis',) +
  labs(title = 'Moral Injury: P Value on Coefficients')



model_results %>%   
  mutate(significant_at_05 = factor(if_else(p.value <= .05, T, F))) %>% 
  filter(term == 'mios_total' | term == 'mios_screener') %>% 
  filter(DV == 'interdependent' |
           DV == 'centrality' |
           DV == 'connection' |
           DV == 'family' |
           DV == 'private_regard' |
           DV == 'public_regard' |
           DV == 'skills') %>% 
  ggplot(aes(IV, 
             DV)) +
  geom_tile() +
  scale_fill_continuous(type = 'viridis') +
  geom_text(aes(label = round(p.value, 2), color = significant_at_05)) +
  labs(title = 'Moral Injury: Significance THreshold')

