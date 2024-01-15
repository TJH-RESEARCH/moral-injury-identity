

## Save copies of the original data and the data scrubbed by Qualtrics 
data_original <- 
  data %>% 
  mutate(air_force_warrant_officer = NA, warrant_officer_years = NA)


data_scrubbed_qualtrics <- 
  data %>% 
  filter(Progress == 100, term == 'Scrubbed' | term == 'Scrubbed Out' | term == 'scrubbed')

data <- 
  anti_join(data, data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId')) 


# Label Exclusion Reasons -------------------------------------------------
data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) 

data_scrubbed_researcher <-
  data_scrubbed_researcher %>% 
  mutate(exclusion_reason = 'Removed by Survey Host')


