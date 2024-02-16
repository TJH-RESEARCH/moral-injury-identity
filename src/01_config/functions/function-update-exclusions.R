
update_exclusions <-
function(data_start, data, data_exclusions, exclusion_reason_string){

data_new_exclusions <- 
  anti_join(data_start, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = exclusion_reason_string)

data_exclusions <-
  data_exclusions %>% 
  bind_rows(data_new_exclusions)

rm(data_new_exclusions, data_start)

return(data_exclusions)
}

