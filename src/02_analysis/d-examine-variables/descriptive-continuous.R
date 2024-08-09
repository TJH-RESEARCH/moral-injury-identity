# DESCRIPTIVE STATISTICS

## This script creates correlation tables, runs descriptives, 
## binds the results together, formats the table, then prints
## and saves a copy to a file. 



# Create Correlation Table ------------------------------------------

continuous_table <-
  data %>% 
  select(mios_total, 
         biis_harmony,
         wis_interdependent_total,
         wis_public_regard_total) %>% 

  corrr::correlate() %>% 
  
  bind_cols(
    data %>% 
  select(mios_total, 
         biis_harmony,
         wis_interdependent_total,
         wis_public_regard_total) %>% 
      psych::describe() %>% 
      tibble() %>% 
      select(mean, sd, min, max) 
  ) %>%
  mutate(across(where(is.numeric), \(x) round(x, 2))) %>% 
  select(term, mean, sd, min, max, everything()) %>% 
  rename(M = mean, 
         SD = sd,
         Min = min,
         Max = max,
         # Replace column names with numbers
         `1` = mios_total, 
         `2` = biis_harmony,
         `3` = wis_interdependent_total,
         `4` = wis_public_regard_total
  ) %>% 
  mutate(
    term = str_replace(term, 'mios_total', 'Moral Injury Symptoms'),
    term = str_replace(term, 'biis_harmony', 'Identity Dissonance'),
    term = str_replace(term, 'wis_interdependent_total', 'Military Attachment'),
    term = str_replace(term, 'wis_public_regard_total', 'Percieved Public Regard')
  ) %>% 
  select(-`4`)


# Print:
continuous_table %>% print()

continuous_table %>% 
  kableExtra::kbl(
    caption = "Descriptive Statistics for Continuous Variables",
    format = "html",
    col.names = c("Variable","M","SD", "Min", "Max", '1', '2', '3'),
    align = "c") %>%
  kableExtra::kable_classic(full_width = F, html_font = "times")



continuous_table %>% kableExtra::kbl(format = 'latex') %>% 
  write_file(here::here('output/tables/continuous-table-latex.txt'))


continuous_table %>% kableExtra::kbl(format = 'latex') %>%
  append_results_tables()

# Write file --------------------------------------------------------------
continuous_table %>% write_csv(here::here('output/tables/continuous-table.csv'))

# Message
message('Descriptive table of continuous variables saved to `output/tables/continuous-table.csv`')


