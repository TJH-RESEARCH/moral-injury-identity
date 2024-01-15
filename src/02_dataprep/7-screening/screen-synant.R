data_start <- data


## Psychometric Synonyms/Antonyms ------------------------------------------------
## Use the maximum/minimum critical value possible with data removal

data <-
  data %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychsyn = careless::psychsyn(., critval = 0.76)) %>% 
  bind_cols(data)

data %>% ggplot(aes(psychsyn)) + geom_histogram()

data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% # Before recoding, higher correlation indicates less attention/carefullness
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychant = careless::psychant(., critval = -0.62, diag = FALSE)) %>% 
  bind_cols(data)

data %>% ggplot(aes(psychant)) + geom_histogram()
## Antonyms are really inconclusive! Not going to filter there
## Synonyms will do conservative. Anything 0 or less




# Filter by Psychometric Synonym/Antonym
data <-
  data %>% 
  filter(
    psychsyn > 0
  )






# Label Exclusion Reasons -------------------------------------------------

data_new_exclusions <- 
  anti_join(data_start, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 'Pyschometrics Synonyms/Antonym Inconsistency')

data_scrubbed_researcher <-
  data_scrubbed_researcher %>% 
  bind_rows(data_new_exclusions)

rm(data_new_exclusions, data_start)
