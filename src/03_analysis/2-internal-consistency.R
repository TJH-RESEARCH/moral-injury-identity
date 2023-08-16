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


# M2C-Q -------------------------------------------------------------------
results_m2cq <-
  data %>% 
  select(starts_with('m2c') & !ends_with('mean')) %>% 
  psych::alpha()

results_m2cq %>% print()

# Moral Injury ------------------------------------------------------------
results_mios <- data %>% select(mios_1:mios_14) %>% psych::alpha()

results_mios %>% print()

internal_consistency <-
  tibble(
    measure = c('BIIS-2 Harmony vs Conflict',
                'M2C-Q',
                'MIOS'),
    alpha =   c(
      results_biis$total[,'raw_alpha'], 
      results_m2cq$total[,'raw_alpha'], 
      results_mios$total[,'raw_alpha'])
  )


# Print -------------------------------------------------------------------
internal_consistency %>% print(n = 100)

# Save --------------------------------------------------------------------
internal_consistency %>% readr::write_csv(here::here('output/tables/internal-consistency.csv'))

# Message -----------------------------------------------------------------
message('Internal consistency table saved to `output/tables/internal-consistency.csv`')

## Clean up
rm(internal_consistency, results_biis, results_m2cq, results_mios)
