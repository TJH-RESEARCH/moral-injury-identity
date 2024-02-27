# DESCRIPTIVE STATISTICS

## This script creates correlation tables, runs descriptives, 
## binds the results together, formats the table, then prints
## and saves a copy to a file. 



# Create Correlation Table ------------------------------------------

correlation_table <-
  data %>% 
  select(mios_total, 
         biis_harmony,
         wis_interdependent_total,
         years_separation,
         years_service) %>% 

  corrr::correlate() %>% 
  
  bind_cols(
    data %>% 
  select(mios_total, 
         biis_harmony,
         wis_interdependent_total,
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
         `1` = mios_total, 
         `2` = biis_harmony,
         `3` = wis_interdependent_total,
         `4` = years_separation, 
         `5` = years_service
  ) %>% 
  mutate(term = str_replace(term, 'wis_interdependent_total', 'Identity Loss'),
         term = str_replace(term, 'mios_total', 'Moral Injury Symptoms'),
         term = str_replace(term, 'biis_harmony', 'Identity Dissonance'),
         term = str_replace(term, 'years_separation', 'Years Separated'),
         term = str_replace(term, 'years_service', 'Years of Service')
  ) %>% 
  select(-`5`)


# Print:
correlation_table %>% print()
correlation_table %>% kableExtra::kbl()

# Write file --------------------------------------------------------------
correlation_table %>% write_csv(here::here('output/tables/correlation-table.csv'))

# Remove variable from environment
rm(correlation_table)

# Message
message('Descriptive table cotinuous variables saved to `output/tables/correlation-table.csv`')


