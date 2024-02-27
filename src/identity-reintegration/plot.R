

data %>% 
  pivot_longer(
    cols = 
      c(mcarm_purpose_connection, 
        mcarm_help_seeking, 
        mcarm_beliefs_about_civilians, 
        mcarm_resentment_regret, 
        mcarm_regimentation)
    ) %>%
  ggplot(aes(x = name, y = value)) + 
  geom_boxplot() +
  geom_point(aes(color = wis_centrality_total), 
             alpha = .99, 
             position = 'jitter') +
  scale_color_continuous(type = 'viridis')
