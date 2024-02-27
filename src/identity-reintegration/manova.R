
# MANOVA test
results_manova <- 
  data %>% 
  manova(
    cbind(
      mcarm_purpose_connection, 
      mcarm_help_seeking, 
      mcarm_beliefs_about_civilians, 
      mcarm_resentment_regret, 
      mcarm_regimentation) ~ 
    wis_centrality_total, 
    data = .)
results_manova %>% summary()


results_manova %>% broom::tidy()
