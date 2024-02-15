# INTERNAL CONSISTENCY


# BIIS-2 Harmony vs Conflict ----------------------------------------------
results_biis <-
  data %>% 
  select(biis_1,
         biis_2,
         biis_3,
         biis_4,
         biis_5,
         biis_6,
         biis_7,
         biis_8,
         biis_9,
         biis_10) %>%
  psych::alpha()

results_biis  %>% print()


# Moral Injury ------------------------------------------------------------
results_mios <- data %>% select(mios_1:mios_14) %>% psych::alpha()

results_mios %>% print()

cronbachs_alpha <-
  tibble(
    measure = c('BIIS-2',
                'MIOS'),
    variable = c('Identity Dissonance', 
                 'Moral Injury Symptoms'),
    cronbachs_alpha =   c(
      round(results_biis$total[,'raw_alpha'], 2), 
      round(results_mios$total[,'raw_alpha'], 2))
  )
cronbachs_alpha

# WIS Centrality -------------------------------------------------------------------
results_wis_centrality <-
  data %>% 
  select(starts_with('wis_centr') & !ends_with('total')) %>%
  psych::alpha()

results_wis_centrality %>% print()

# WIS Connection -------------------------------------------------------------------
results_wis_connection <-
  data %>% 
  select(starts_with('wis_connection') & !ends_with('total')) %>%
  psych::alpha()

results_wis_connection %>% print()

# WIS Interdependence -------------------------------------------------------------------
results_wis_interdependent <-
  data %>% 
  select(starts_with('wis_int') & !ends_with('total')) %>%
  psych::alpha()

results_wis_interdependent %>% print()



# Print -------------------------------------------------------------------
cronbachs_alpha %>% print(n = 100)

# Save --------------------------------------------------------------------
cronbachs_alpha %>% readr::write_csv(here::here('output/stats/cronbachs-alpha.csv'))

# Message -----------------------------------------------------------------
message('Internal consistency (i.e., Cronbachs alpha) saved to `output/stats/cronbachs-alpha.csv`')

## Clean up
rm(cronbachs_alpha, results_biis, results_m2cq, results_mios)



data %>% select(bipf_total)
