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
      mios_total,
      mios_ptsd_symptoms_total
    ) %>% 
    corrr::correlate() %>% 
    bind_cols(
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
                   mios_total,
                   mios_ptsd_symptoms_total
                 ) %>% 
                 psych::describe() %>% 
                 select(mean, sd, skew, kurtosis) %>% 
                 tibble()
               ) %>% 
  mutate(across(where(is.numeric), round, 2)) %>% 
  select(term, mean, sd, skew, kurtosis, everything()) %>% 
  rename(M = mean, 
         SD = sd, 
         Skew = skew, 
         Kurtosis = kurtosis,
         `1` = 6, `2` = 7, `3` = 8, `4` = 9, `5` = 10,
         `6` = 11, `7` = 12, `8` = 13, `9` = 14, `10` = 15) %>% 
  mutate(term = str_remove(term, 'wis_'),
         term = str_remove(term, '_total'),
         term = str_to_title(term)
         ) %>% 
    write_csv(here::here('output/tables/correlation-table-1.csv'))


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
        mios_total,
        mios_ptsd_symptoms_total
      ) %>% 
      psych::describe()


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


