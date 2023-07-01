
# Plot differences in Clusters: Box --------------------------------------------------------------------
data %>% 
  select(starts_with('wis') & ends_with('total') & !wis_total | wis_cluster) %>% 
  group_by(wis_cluster) %>% 
  #summarise(across(everything(), ~ mean(.x))) %>% 
  #mutate(across(!wis_cluster, ~ scale(.x))) %>%
  pivot_longer(cols = !wis_cluster) %>%
  ggplot(aes(name, value)) + 
  geom_boxplot() +
  facet_wrap(~ wis_cluster, ncol=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() +
  labs(title = 'Warrior Identity', 
       subtitle = 'Scaled means for WIS subscales by cluster')
