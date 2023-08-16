# Calculate Longstring and Average longstring


calculate_longstring <- function(data){

## Longstring: Reverse Code ------------------------------------------------

### Average Longstring: With Reverse Scoring
data <-
  data %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%        # The MIOS and M2C-Q have valid reasons for straightlining 0. Remove them from the survey-wide longstring calculations. 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse = longstr, 
         avgstr_reverse = avgstr) %>% 
  bind_cols(data)

### BIIS - Longstring
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('biis')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse_biis = longstr, 
         avgstr_reverse_biis = avgstr) %>% 
  bind_cols(data)

### M2CQ - Longstring
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('m2cq')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_m2cq = longstr, 
         avgstr_m2cq = avgstr) %>% 
  bind_cols(data)

### MCARM - Longstring
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('mcarm')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse_mcarm = longstr, 
         avgstr_reverse_mcarm = avgstr) %>% 
  bind_cols(data)

### MIOS - Longstring
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('mios')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_mios = longstr, 
         avgstr_mios = avgstr) %>% 
  bind_cols(data)

### SCC - Longstring
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('scc')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse_scc = longstr, 
         avgstr_reverse_scc = avgstr) %>% 
  bind_cols(data)


## Longstring: No Reverse Codes --------------------------------------------

### BIIS - Longstring - No Reverse
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% 
  select(starts_with('biis')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse_biis = longstr, 
         avgstr_no_reverse_biis = avgstr) %>% 
  bind_cols(data)

### MCARM - Longstring - No Reverse
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% 
  select(starts_with('mcarm')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse_mcarm = longstr, 
         avgstr_no_reverse_mcarm = avgstr) %>% 
  bind_cols(data)

### SCC - Longstring - No Reverse
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>%
  select(starts_with('scc')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse_scc = longstr, 
         avgstr_no_reverse_scc = avgstr) %>% 
  bind_cols(data)


### Average Longstring: Without Reverse Scoring
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%      # The MIOS and M2C-Q have valid reasons for straightlining 0. Remove them from the survey-wide longstring calculations. 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse = longstr, 
         avgstr_no_reverse = avgstr) %>% 
  bind_cols(data)


return(data)
}
