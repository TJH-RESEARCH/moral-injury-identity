


data_start <- data


data <-
  data %>% 
  filter(    
    attention_check_biis == 1,
    attention_check_wis == 1,
)


# Label Exclusion Reasons -------------------------------------------------

data_new_exclusions <- 
  anti_join(data_start, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 'Failed attention checks')

data_scrubbed_researcher <-
  data_scrubbed_researcher %>% 
  bind_rows(data_new_exclusions)

rm(data_new_exclusions, data_start)



