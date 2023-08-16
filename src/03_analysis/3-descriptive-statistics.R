# DESCRIPTIVE STATISTICS

## This script creates correlation tables, runs descriptives, 
## binds the results together, formats the table, then prints
## and saves a copy to a file. 


# Create Descriptive Table ------------------------------------------

descriptive_table <-
  data %>% 
  select(m2cq_mean,
         mios_total, 
         biis_harmony) %>% 

  corrr::correlate() %>% 
  
  bind_cols(
    data %>% 
  select(m2cq_mean,
         mios_total,
         biis_harmony) %>% 
      psych::describe() %>% 
      tibble() %>% 
      select(mean, sd, median, min, max, skew, kurtosis) 
  ) %>%
  mutate(across(where(is.numeric), round, 2)) %>% 
  select(term, mean, sd, median, min, max, skew, kurtosis, everything()) %>% 
  rename(M = mean, 
         SD = sd,
         Median = median,
         Min = min,
         Max = max,
         Skew = skew, 
         Kurtosis = kurtosis,
         # Replace column names with numbers
         `1` = m2cq_mean, `2` = mios_total, `3` = biis_harmony
  ) %>% 
  mutate(term = str_replace(term, 'm2cq_mean', 'Reintegration'),
         term = str_replace(term, 'mios_total', 'Moral Injury Symptoms'),
         term = str_replace(term, 'biis_harmony', 'Identity Dissonance')
  ) %>% 
  select(-`3`)

# Print:
descriptive_table %>% print()

# Write file --------------------------------------------------------------
descriptive_table %>% write_csv(here::here('output/tables/descriptive-statistics.csv'))

# Remove variable from environment
rm(descriptive_table)

# Message
message('Descriptive statistics table saved to `output/tables/descriptive-statistics.csv`')



# Categorical --------------------------------------------------------------


categorical_table <-

  data %>% count(sex_male) %>% mutate(perc = n / sum(n) * 100) %>% 
  mutate(sex_male = ifelse(sex_male == 1, 
                             'Male', 
                             'Female')) %>% 
  rename(variable = 1) %>% arrange(desc(perc)) %>% 
  bind_rows(
  
  data %>% count(race_white) %>% mutate(perc = n / sum(n) * 100) %>% 
  mutate(race_white = ifelse(race_white == 1, 
                                       'White', 
                                       'Non-White')) %>% 
  rename(variable = 1) %>% arrange(desc(perc))
  ) %>% 
  bind_rows( 
  data %>% count(officer) %>% mutate(perc = n / sum(n) * 100) %>% 
  mutate(officer = ifelse(officer == 1, 
                           'Officer', 
                           'Enlisted')) %>% 
  rename(variable = 1) %>% arrange(desc(perc)) 
  ) %>% 
  
  bind_rows(


  data %>% count(ptsd_positive_screen) %>% mutate(perc = n / sum(n) * 100) %>% 
    mutate(ptsd_positive_screen = ifelse(ptsd_positive_screen == 1, 
                                       'Positive PTSD screening', 
                                       'Negative screening')) %>% 
  rename(variable = 1) 
  )%>% 
  bind_rows(
  
  data %>% count(military_exp_combat) %>% mutate(perc = n / sum(n) * 100) %>% 
    mutate(military_exp_combat = ifelse(military_exp_combat == 1, 
                                         'Prior combat deployment', 
                                         'No combat deployment')) %>% rename(variable = 1)
  
  ) %>% 
  bind_rows(

  data %>% count(military_family_none) %>% mutate(perc = n / sum(n) * 100) %>% 
    mutate(military_family_none = ifelse(military_family_none == 0, 
                               'Another family member in military', 
                               'Only family member who served')) %>% rename(variable = 1)
  ) %>% 
  bind_rows(
  data %>% count(discharge_reason) %>% mutate(perc = n / sum(n) * 100) %>% rename(variable = 1) %>% 
    arrange(desc(perc))
  
  ) %>% 
  bind_rows(
  data %>% count(disability) %>% mutate(perc = n / sum(n) * 100) %>% 
    mutate(disability = ifelse(disability == 1, 
                               'Recieved VA disability benefits', 
                               'Does not recieve benefits')) %>% rename(variable = 1)
  )


# Print:
categorical_table %>% print(n = 20)

# Write file --------------------------------------------------------------
categorical_table %>% write_csv(here::here('output/tables/categorical-table.csv'))

# Message
message('Cateogrical variable table saved to `output/tables/categorical-table.csv`')

# Remove variable from environment
rm(categorical_table)

