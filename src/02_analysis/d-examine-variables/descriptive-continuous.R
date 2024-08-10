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

# Write file --------------------------------------------------------------
continuous_table %>% 
  kbl(caption = "Descriptive Statistics of Continuous Variables",
      format = "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align = "l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()

continuous_table %>% write_csv(here::here('output/tables/continuous-table.csv'))

# Message
message('Descriptive table of continuous variables saved to `output/tables/continuous-table.csv`')


