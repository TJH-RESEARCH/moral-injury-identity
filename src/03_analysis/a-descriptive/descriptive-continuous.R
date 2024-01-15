# DESCRIPTIVE STATISTICS

## This script creates correlation tables, runs descriptives, 
## binds the results together, formats the table, then prints
## and saves a copy to a file. 


# Create Correlation Table ------------------------------------------

correlation_table <-
  data %>% 
  select(m2cq_mean,
         mios_total, 
         biis_harmony,
         years_separation,
         years_service) %>% 

  corrr::correlate() %>% 
  
  bind_cols(
    data %>% 
  select(m2cq_mean,
         mios_total,
         biis_harmony,
         years_separation,
         years_service) %>% 
      psych::describe() %>% 
      tibble() %>% 
      select(mean, sd, median, min, max, skew, kurtosis) 
  ) %>%
  mutate(across(where(is.numeric), \(x) round(x, 2))) %>% 
  select(term, mean, sd, median, min, max, skew, kurtosis, everything()) %>% 
  rename(M = mean, 
         SD = sd,
         Median = median,
         Min = min,
         Max = max,
         Skew = skew, 
         Kurtosis = kurtosis,
         # Replace column names with numbers
         `1` = m2cq_mean, `2` = mios_total, `3` = biis_harmony, `4` = years_separation, `5` = years_service
  ) %>% 
  mutate(term = str_replace(term, 'm2cq_mean', 'Reintegration'),
         term = str_replace(term, 'mios_total', 'Moral Injury Symptoms'),
         term = str_replace(term, 'biis_harmony', 'Identity Dissonance')
  ) %>% 
  select(-`5`)


# Print:
correlation_table %>% print()

# Write file --------------------------------------------------------------
correlation_table %>% write_csv(here::here('output/tables/c5-correlation-table.csv'))

# Remove variable from environment
rm(correlation_table)

# Message
message('Descriptive table cotinuous variables (Table C5) saved to `output/tables/c5-correlation-table.csv`')


