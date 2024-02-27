
# Create table of survey exclusion reasons

# Main -------------------------------------------------------------------------

exclusions <-
  exclusion_reasons %>% 
    filter(excluded_from == 'Main') %>% 
    count(excluded_from, exclusion_reason) %>% 
  bind_rows(
    data %>% 
      filter(dataset_main == 1) %>% 
      mutate(exclusion_reason = 'Not Excluded',
             excluded_from = 'Main') %>% 
      count(excluded_from, exclusion_reason) 
) %>% arrange(-n) %>% 
  bind_rows(



# Strict  -------------------------------------------------------------------------

  exclusion_reasons %>% 
  filter(excluded_from == 'Strict') %>% 
  count(excluded_from, exclusion_reason) %>% 
  bind_rows(
    data %>% 
      filter(dataset_strict == 1) %>% 
      mutate(exclusion_reason = 'Not Excluded',
             excluded_from = 'Strict') %>% 
      count(excluded_from, exclusion_reason) 
  ) %>% arrange(-n)) %>% 
  bind_rows(



# Lenient -------------------------------------------------------------------------


  exclusion_reasons %>% 
  filter(excluded_from == 'Lenient') %>% 
  count(excluded_from, exclusion_reason) %>% 
  bind_rows(
    data %>% 
      filter(dataset_lenient == 1) %>% 
      mutate(exclusion_reason = 'Not Excluded',
             excluded_from = 'Lenient') %>% 
      count(excluded_from, exclusion_reason) 
  ) %>% arrange(-n)) %>% 
  bind_rows(


# Simple -------------------------------------------------------------------------

exclusions_simple <-
  exclusion_reasons %>% 
  filter(excluded_from == 'Simple') %>% 
  count(excluded_from, exclusion_reason) %>% 
  bind_rows(
    data %>% 
      filter(dataset_simple == 1) %>% 
      mutate(exclusion_reason = 'Not Excluded',
             excluded_from = 'Simple') %>% 
      count(excluded_from, exclusion_reason) 
  ) %>% arrange(-n))




# -------------------------------------------------------------------------

## Number of completed surveys
message(paste('There were', sum(exclusions$n), 'surveys completed. Of those,', nrow(data), 'were retained and', sum(exclusions$n) - nrow(data), 'were excluded.'))

## Print: 
exclusions %>% print(n = 100)

## Save
exclusions %>% 
  write_csv(here::here('output/tables/c1-exclusion-reasons.csv'))

## Message:
if(exists('exclusions')) message('Exclusion reasons saved to `output/tables/c1-exclusion-reasons.csv`')

## Clean up
rm(exclusions)
