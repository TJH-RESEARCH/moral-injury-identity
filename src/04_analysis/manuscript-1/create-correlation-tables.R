# Correlation Tables



# Table 1: WIS Dependent Variables + Independent Variable ---------------------

data %>% 
  select(
    wis_centrality_total,
    wis_connection_total,
    wis_family_total,
    wis_interdependent_total,
    wis_private_regard_total,
    wis_public_regard_total,
    wis_skills_total,
    wis_total,
    mios_total
  ) %>% 
  cor() %>% 
  round(2) %>% view()


# -------------------------------------------------------------------------

data %>% 
  mutate(highest_rank = as.numeric(highest_rank),
         sex = as.numeric(sex)) %>% 
  select(wis_total, 
         mios_total, 
         mios_ptsd_symptoms_total,
         bipf_total,
         sex,
         branch_air_force, branch_army, branch_marines, branch_navy, branch_multiple, branch_public_health,
         race_asian, race_native, race_black, race_latino, race_white,
         service_era_vietnam, service_era_persian_gulf, service_era_post_911, 
         disability,
         n_deploy,
         reserve,
         highest_rank,
         years_separation,
         years_service,
         military_family) %>%
  cor()
