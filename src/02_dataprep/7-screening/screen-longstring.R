

data_start <- data


# Screen: Longstring ----------------------------------------------------------------
## Now screen the really obvious and aggregriuos instances of straightlining, 
## which is the main threat on an online survey, along with answering in a random pattern

data <- data %>% calculate_longstring()


## Straightlined the MIOS with score higher more than 0
data <-
  data %>% 
  filter(longstr_mios == 14, mios_total == 0) %>% 
  bind_rows(data %>% filter(longstr_mios != 14))

## Straightlined the M2CQ with a score more than 0
data <-
  data %>% 
  filter(longstr_m2cq == 16, m2cq_mean == 0) %>% 
  bind_rows(data %>% filter(longstr_m2cq != 16))


data <-
  data %>% 
  filter(
    ## Longstring by scale
    longstr_reverse_biis < 17,         # BIIS = 17 items total
    longstr_no_reverse_biis < 17,
    longstr_reverse_mcarm < 19,        # MCARM = 21 items - <19
    longstr_no_reverse_mcarm < 19,
    longstr_reverse_scc < 12,          # SCC = 12 items - <10
    longstr_no_reverse_scc < 12)




# Label Exclusion Reasons -------------------------------------------------

data_new_exclusions <- 
  anti_join(data_start, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 'Longstring')

data_scrubbed_researcher <-
  data_scrubbed_researcher %>% 
  bind_rows(data_new_exclusions)

rm(data_new_exclusions, data_start)
