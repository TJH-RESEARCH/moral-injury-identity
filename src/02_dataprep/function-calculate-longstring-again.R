
calculate_longstring_again <- function(data) {
## Average Longstring: With Reverse Scoring
data <-
  data %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%        # The MIOS and M2C-Q have valid reasons for straightlining 0. Remove them from the survey-wide longstring calculations. 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse = longstr, 
         avgstr_reverse = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_reverse, avgstr_reverse)))


## Average Longstring: Without Reverse Scoring
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%      # The MIOS and M2C-Q have valid reasons for straightlining 0. Remove them from the survey-wide longstring calculations. 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse = longstr, 
         avgstr_no_reverse = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_no_reverse, avgstr_no_reverse)))


## Longstring BIIS
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('biis')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse_biis = longstr, 
         avgstr_reverse_biis = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_reverse_biis, avgstr_reverse_biis)))


## Longstring - No Reverse: BIIS
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% 
  select(starts_with('biis')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse_biis = longstr, 
         avgstr_no_reverse_biis = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_no_reverse_biis, avgstr_no_reverse_biis)))


## Longstring M2CQ
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('m2cq')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_m2cq = longstr, 
         avgstr_m2cq = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_m2cq, avgstr_m2cq)))


## Longstring MCARM
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('mcarm')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse_mcarm = longstr, 
         avgstr_reverse_mcarm = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_reverse_mcarm, avgstr_reverse_mcarm)))


## Longstring - No Reverse: MCARM
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% 
  select(starts_with('mcarm')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse_mcarm = longstr, 
         avgstr_no_reverse_mcarm = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_no_reverse_mcarm, avgstr_no_reverse_mcarm)))


## Longstring MIOS
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('mios')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_mios = longstr, 
         avgstr_mios = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_mios, avgstr_mios)))


## Longstring SCC
data <-
  data %>% 
  select_scales() %>% 
  select(starts_with('scc')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse_scc = longstr, 
         avgstr_reverse_scc = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_reverse_scc, avgstr_reverse_scc)))


## Longstring - No Reverse: SCC
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% 
  select(starts_with('scc')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse_scc = longstr, 
         avgstr_no_reverse_scc = avgstr) %>% 
  bind_cols(data %>% select(!c(longstr_no_reverse_scc, avgstr_no_reverse_scc)))


}
