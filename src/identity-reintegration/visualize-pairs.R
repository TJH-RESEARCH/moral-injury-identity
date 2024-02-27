


# Reintegration  ----------------------------------------------
data %>% 
  select(mcarm_purpose_connection, 
         mcarm_help_seeking, 
         mcarm_beliefs_about_civilians, 
         mcarm_resentment_regret, 
         mcarm_regimentation) %>% 
  GGally::ggpairs()


# Warrior Identity Scale  ----------------------------------------------
data %>% 
  select(starts_with('wis_') & ends_with('total') & !wis_total) %>% 
  GGally::ggpairs()



# Reintegration  ----------------------------------------------
data %>% 
  select(mcarm_purpose_connection, 
         mcarm_help_seeking, 
         mcarm_beliefs_about_civilians, 
         mcarm_resentment_regret, 
         mcarm_regimentation,
         wis_centrality_total,
         wis_connection_total,
         wis_family_total,
         wis_interdependent_total,
         wis_public_regard_total,
         wis_private_regard_total
         ) %>% 
  GGally::ggpairs()





