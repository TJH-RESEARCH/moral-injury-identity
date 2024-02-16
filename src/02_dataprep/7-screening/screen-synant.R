
# psychsyn critval 0.76; psychant critval = -0.62; filter(psychsyn > 0)


data_start_main <- data_main
data_start_strict <- data_strict
data_start_lenient <- data_lenient



## Psychometric Synonyms/Antonyms ------------------------------------------------
## Use the maximum/minimum critical value possible with data removal

data_main <-
  data_main %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychsyn = careless::psychsyn(., critval = 0.76)) %>% 
  bind_cols(data_main)

data_main %>% ggplot(aes(psychsyn)) + geom_histogram()

data_main <-
  data_main %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% # Before recoding, higher correlation indicates less attention/carefullness
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychant = careless::psychant(., critval = -0.62, diag = FALSE)) %>% 
  bind_cols(data_main)

data_main %>% ggplot(aes(psychant)) + geom_histogram()
## Antonyms are really inconclusive! Not going to filter there
## Synonyms will do conservative. Anything 0 or less

# Filter by Psychometric Synonym/Antonym
data_main <-
  data_main %>% 
  filter(
    psychsyn > 0
  )




# Strict -------------------------------------------------------------------------

data_strict <-
  data_strict %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychsyn = careless::psychsyn(., critval = 0.76)) %>% 
  bind_cols(data_strict)

data_strict %>% ggplot(aes(psychsyn)) + geom_histogram()

data_strict <-
  data_strict %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% # Before recoding, higher correlation indicates less attention/carefullness
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychant = careless::psychant(., critval = -0.62, diag = FALSE)) %>% 
  bind_cols(data_strict)

data_strict %>% ggplot(aes(psychant)) + geom_histogram()
## Antonyms are really inconclusive! Not going to filter there
## Synonyms will do conservative. Anything 0 or less

# Filter by Psychometric Synonym/Antonym
data_strict <-
  data_strict %>% 
  filter(
    psychsyn > 0.25
  )


# Lenient -------------------------------------------------------------------------

data_lenient <-
  data_lenient %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychsyn = careless::psychsyn(., critval = 0.76)) %>% 
  bind_cols(data_lenient)

data_lenient %>% ggplot(aes(psychsyn)) + geom_histogram()

data_lenient <-
  data_lenient %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% # Before recoding, higher correlation indicates less attention/carefullness
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychant = careless::psychant(., critval = -0.62, diag = FALSE)) %>% 
  bind_cols(data_lenient)

data_lenient %>% ggplot(aes(psychant)) + geom_histogram()
## Antonyms are really inconclusive! Not going to filter there
## Synonyms will do conservative. Anything 0 or less

# Filter by Psychometric Synonym/Antonym
data_lenient <-
  data_lenient %>% 
  filter(
    psychsyn > -0.25
  )




# Label Exclusion Reasons -------------------------------------------------

data_exclusions_main <-
  update_exclusions(data_start = data_start_main,
                    data = data_main,
                    data_exclusions = data_exclusions,
                    exclusion_reason_string = 'Inconsistency (Psychometric Synonym)')

data_exclusions_strict <-
  update_exclusions(data_start = data_start_strict,
                    data = data_strict,
                    data_exclusions = data_exclusions,
                    exclusion_reason_string = 'Inconsistency (Psychometric Synonym)')

data_exclusions_lenient <-
  update_exclusions(data_start = data_start_lenient,
                    data = data_lenient,
                    data_exclusions = data_exclusions,
                    exclusion_reason_string = 'Inconsistency (Psychometric Synonym)')



rm(data_start_main, data_start_strict, data_start_lenient)