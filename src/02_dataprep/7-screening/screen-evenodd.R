
data_start <- data

# Screen:Even-Odd Consistency ------------------------------------------------

suppressWarnings({
  
  data <-
    data %>% 
    select_scales() %>% 
    reorder_data_scales() %>% 
    transmute(evenodd = 
                careless::evenodd(x =., 
                                  # nItems in each subscale in order:
                                  factors = c(
                                    10, # BIIS Harmony
                                    7,  # BIIS Blended
                                    4,  # Civilian Commitment
                                    16, # M2C-Q
                                    6,  # MCARM Purpose 
                                    4,  # MCARM Help
                                    3,  # MCARM Civilians
                                    3,  # MCARM Resentment
                                    5,  # MCARM Regimentation
                                    7,  # MIOS Shame
                                    7,  # MIOS Trust
                                    12, # SCC 
                                    7,  # WIS Private Regard
                                    7,  # WIS Interdependent
                                    3,  # WIS Connection
                                    3,  # WIS Family
                                    4,  # WIS Centrality
                                    4,  # WIS Public Regard
                                    3)  # WIS Skills
                )) %>% bind_cols(data) # Add the results back to the original data. 
}) # End warning suppression. ℹ In argument: `evenodd = careless::evenodd(...)`.Caused by warning in `careless::evenodd()`: ! Computation of even-odd has changed for consistency of interpretation with other indices. This change occurred in version 1.2.0. A higher score now indicates a greater likelihood of careless responding. If you have previously written code to cut score based on the output of


# The most conservative even-odd cut, to make the "low bar approach" is anything
# above 0. This indicates going in the opposite direction of everyone else
data %>% ggplot(aes(evenodd)) + geom_histogram()
data <- data %>% filter(evenodd < 0)





# Label Exclusion Reasons -------------------------------------------------

data_new_exclusions <- 
  anti_join(data_start, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 'Even-Odd Inconsistency')

data_scrubbed_researcher <-
  data_scrubbed_researcher %>% 
  bind_rows(data_new_exclusions)

rm(data_new_exclusions, data_start)
