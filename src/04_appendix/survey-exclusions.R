
# Create table of survey exclusion reasons

# -------------------------------------------------------------------------


exclusions <-
  data_scrubbed_researcher %>% 
  bind_rows(
  data %>% 
    mutate(exclusion_reason = 'Not Excluded')
  ) %>% 
  group_by(exclusion_reason) %>% 
  count() %>% 
  arrange(desc(n))

## Number of completed surveys
message(paste('There were', sum(exclusions$n), 'surveys completed. Of those,', nrow(data), 'were retained and', sum(exclusions$n) - nrow(data), 'were excluded.'))

## Print: 
exclusions %>% print()

## Save
exclusions %>% 
  write_csv(here::here('output/tables/c1-exclusion-reasons.csv'))

## Message:
if(exists('exclusions')) message('Exclusion reasons saved to `output/tables/c1-exclusion-reasons.csv`')

## Clean up
rm(exclusions)
