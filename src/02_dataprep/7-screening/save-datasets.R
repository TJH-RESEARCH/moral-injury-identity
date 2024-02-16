
data <-
  data_original %>% 
  mutate(
    dataset_main = 
      as.numeric(data_original$ResponseId %in% data_main$ResponseId),
    dataset_lenient = 
      as.numeric(data_original$ResponseId %in% data_lenient$ResponseId),
    dataset_strict = 
      as.numeric(data_original$ResponseId %in% data_strict$ResponseId),
    dataset_simple = 
      as.numeric(data_original$ResponseId %in% data_simple$ResponseId),
    
    excluded_main = 
      as.numeric(data_original$ResponseId %in% data_exclusions_main$ResponseId),
    excluded_lenient = 
      as.numeric(data_original$ResponseId %in% data_exclusions_lenient$ResponseId),
    excluded_strict = 
      as.numeric(data_original$ResponseId %in% data_exclusions_strict$ResponseId),
    excluded_simple = 
      as.numeric(data_original$ResponseId %in% data_exclusions_simple$ResponseId),
    excluded_qualtrics = 
      as.numeric(data_original$ResponseId %in% data_exclusions_qualtrics$ResponseId)
    
    
    
    )


rm(data_exclusions, data_original, data_start, data_main, data_simple, data_lenient, data_strict)

