
# CREATE CORRELATION TABLES



# Table 1: WIS Dependent Variables + Independent Variable ---------------------
## Table with means, SD, skew, kurtosis and correlations


table_correlation_identity_wound <-
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
       tibble() %>% 
       select(mean, sd, skew, kurtosis)
     ) %>% 
  mutate(across(where(is.numeric), \(x) round(x, digits = 2))) %>% 
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
         )
  
## Print
table_correlation_identity_wound %>% print()

## Save
table_correlation_identity_wound %>% 
    write_csv(here::here('output/tables/identity-wound-correlation.csv'))

## Message:
message('Correlation table saved as `output/tables/identity-wound-correlation.csv`')

## Clean up:
rm(table_correlation_identity_wound)


