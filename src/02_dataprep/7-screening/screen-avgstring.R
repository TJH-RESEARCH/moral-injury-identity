
data_start <- data

## Set the cutoff - Three and a half standard deviations from the mean of the data:
cut <- 3.5

## Filter
data <-
  data %>%
  filter(
    
    longstr_reverse < mean(data$longstr_reverse) + (cut * sd(data$longstr_reverse)),
    longstr_no_reverse < mean(data$longstr_no_reverse) + (cut * sd(data$longstr_no_reverse)), 
    
    avgstr_no_reverse < mean(data$avgstr_no_reverse) + (cut * sd(data$avgstr_no_reverse)), 
    avgstr_reverse < mean(data$avgstr_reverse) + (cut * sd(data$avgstr_reverse)),
    
    avgstr_reverse_biis < mean(data$avgstr_reverse_biis) + (cut * sd(data$avgstr_reverse_biis)),         
    avgstr_no_reverse_biis < mean(data$avgstr_no_reverse_biis) + (cut * sd(data$avgstr_no_reverse_biis)), 
    
    avgstr_reverse_mcarm < mean(data$avgstr_reverse_mcarm) + (cut * sd(data$avgstr_reverse_mcarm)),         
    avgstr_no_reverse_mcarm < mean(data$avgstr_no_reverse_mcarm) + (cut * sd(data$avgstr_no_reverse_mcarm)), 
    
    avgstr_no_reverse_scc < mean(data$avgstr_no_reverse_scc) + (cut * sd(data$avgstr_no_reverse_scc)),          
    avgstr_reverse_scc < mean(data$avgstr_reverse_scc) + (cut * sd(data$avgstr_reverse_scc)), 
  )




# Label Exclusion Reasons -------------------------------------------------

data_new_exclusions <- 
  anti_join(data_start, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 'Longstring')

data_scrubbed_researcher <-
  data_scrubbed_researcher %>% 
  bind_rows(data_new_exclusions)

rm(data_new_exclusions, data_start, cut)
