
# Military-Civilian Biculturalism?: 
# Identity Conflict, Compartmentalization, and Separated Service Members

## This script creates correlation tables, runs descriptives, 
## binds the results together, formats the table, then prints
## and saves a copy to a file. 


# Create Correlation Table: Biculturalism ------------------------------------------

corr_table_biculturalism <-
  data %>% 
  select(
    wis_centrality_total,
    wis_connection_total,
    wis_family_total,
    wis_interdependent_total,
    wis_private_regard_total,
    wis_public_regard_total,
    wis_skills_total,
    biis_blendedness,
    biis_harmony,
    civilian_commit_total) %>% 
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
       biis_blendedness,
       biis_harmony,
       civilian_commit_total
     ) %>% 
     psych::describe() %>% 
     tibble() %>% 
     select(mean, sd, skew, kurtosis) 
  ) %>%
  mutate(across(where(is.numeric), round, 2)) %>% 
  select(term, mean, sd, skew, kurtosis, everything()) %>% 
  rename(M = mean, 
         SD = sd, 
         Skew = skew, 
         Kurtosis = kurtosis,
         # Replace column names with numbers
         `1` = 6, `2` = 7, `3` = 8, `4` = 9, `5` = 10, `6` = 11, `7` = 12, `8` = 13, `9` = 14, `10` = 15
         ) %>% 
  mutate(term = str_remove(term, 'wis_'),
         term = str_remove(term, '_total'),
         term = str_replace(term, '_', ' '),
         term = str_to_title(term)
         )
# Print:
corr_table_biculturalism

# Write file --------------------------------------------------------------
corr_table_biculturalism %>% write_csv(here::here('output/tables/correlation-table-biculturalism.csv'))

# Remove variable from environment
rm(corr_table_biculturalism)
