# INTERNAL CONSISTENCY


# BIIS-2 Harmony vs Conflict ----------------------------------------------
results_biis_conflict <-
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

results_biis_conflict %>% print()


# BIIS-2 Harmony vs Conflict ----------------------------------------------
results_biis_compart <-
  data %>% 
  select(biis_11,
         biis_12,
         biis_13,
         biis_14,
         biis_15,
         biis_16,
         biis_17) %>%
  psych::alpha()

results_biis_compart %>% print()


# BIIS-2 Harmony vs Conflict ----------------------------------------------
results_scc <-
  data %>% 
  select(starts_with('scc') & !ends_with('total')) %>%
  psych::alpha()

results_scc %>% print()


# Moral Injury ------------------------------------------------------------
results_mios <- data %>% select(mios_1:mios_14) %>% psych::alpha()

results_mios %>% print()

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


# WIS Private -------------------------------------------------------------------
results_wis_private <-
  data %>% 
  select(starts_with('wis_private') & !ends_with('total')) %>%
  psych::alpha()

results_wis_private %>% print()


# WIS Public -------------------------------------------------------------------
results_wis_public <-
  data %>% 
  select(starts_with('wis_public') & !ends_with('total')) %>%
  psych::alpha()

results_wis_public %>% print()


# WIS Family -------------------------------------------------------------------
results_wis_family <-
  data %>% 
  select(starts_with('wis_fam') & !ends_with('total')) %>%
  psych::alpha()

results_wis_family %>% print()


# WIS Skills -------------------------------------------------------------------
results_wis_skills <-
  data %>% 
  select(starts_with('wis_skill') & !ends_with('total')) %>%
  psych::alpha()

results_wis_skills %>% print()


# Save alphas -------------------------------------------------------------

cronbachs_alpha <-
  tibble(
    variable = c('Identity Dissonance',
                 'Identity Dissonance',
                 'Identity Dissonance',
                 'Moral Injury Symptoms',
                 'Military Identity Loss',
                 'Military Identity Loss',
                 'Military Identity Loss',
                 'Military Identity Loss',
                 'Military Identity Loss',
                 'Military Identity Loss',
                 'Military Identity Loss'),
    measure = c(
      'BIIS-2 Compartmentalization vs. Blended subscale',
      'BIIS-2 Conflict vs. Harmony subscale',
      'Self Concept Clarity Scale',
      'Moral Injury Outcomes Scale',
      'WIS Centrality subscale',
      'WIS Connection subscale',
      'WIS Family subscale',
      'WIS Interdependence subscale',
      'WIS Private subscale',
      'WIS Public subscale',
      'WIS Skills subscale'),
    cronbachs_alpha =   c(
      round(results_biis_compart$total[,'raw_alpha'], 2), 
      round(results_biis_conflict$total[,'raw_alpha'], 2), 
      round(results_scc$total[,'raw_alpha'], 2),
      round(results_mios$total[,'raw_alpha'], 2),
      round(results_wis_centrality$total[,'raw_alpha'], 2),
      round(results_wis_connection$total[,'raw_alpha'], 2),
      round(results_wis_family$total[,'raw_alpha'], 2),
      round(results_wis_interdependent$total[,'raw_alpha'], 2),
      round(results_wis_private$total[,'raw_alpha'], 2),
      round(results_wis_public$total[,'raw_alpha'], 2),
      round(results_wis_skills$total[,'raw_alpha'], 2)
      )
  )
cronbachs_alpha


# Print -------------------------------------------------------------------
cronbachs_alpha %>% print(n = 100)

# Save --------------------------------------------------------------------
cronbachs_alpha %>% readr::write_csv(here::here('output/stats/cronbachs-alpha.csv'))

# Message -----------------------------------------------------------------
message('Internal consistency (i.e., Cronbachs alpha) saved to `output/stats/cronbachs-alpha.csv`')

## Clean up
rm(cronbachs_alpha, results_biis, results_m2cq, results_mios)



data %>% select(bipf_total)
