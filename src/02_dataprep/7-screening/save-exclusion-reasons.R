
# Exclusion Reasons -------------------------------------------------------

exclusion_reasons <-
  data_exclusions_lenient %>% 
  select(ResponseId, exclusion_reason) %>% 
  mutate(excluded_from = 'Lenient') %>% 
  bind_rows(
    
    data_exclusions_main %>% 
      select(ResponseId, exclusion_reason) %>% 
      mutate(excluded_from = 'Main')
  ) %>% 
  bind_rows(
    
    data_exclusions_simple %>% 
      select(ResponseId, exclusion_reason) %>% 
      mutate(excluded_from = 'Simple')
  ) %>% 
  bind_rows(
    
    data_exclusions_strict %>% 
      select(ResponseId, exclusion_reason) %>% 
      mutate(excluded_from = 'Strict')
  )

rm(data_exclusions_simple, data_exclusions_strict, data_exclusions_main, 
   data_exclusions_lenient, data_exclusions_qualtrics)
