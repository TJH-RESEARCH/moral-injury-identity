
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

  data %>% count(unmet_needs_any) %>% mutate(perc = n / sum(n) * 100) %>% 
    mutate(unmet_needs_any = ifelse(unmet_needs_any == 0, 
                               'No unmet needs at transition', 
                               'One or more unmet needs at transition')) %>% rename(variable = 1)
  ) %>% 
  bind_rows(
  data %>% count(discharge_reason) %>% mutate(perc = n / sum(n) * 100) %>% rename(variable = 1) %>% 
    arrange(desc(perc))
  
  )
  


# Print:
categorical_table %>% print(n = 20)

# Write file --------------------------------------------------------------
categorical_table %>% write_csv(here::here('output/tables/c6-categorical-table.csv'))

# Message
message('Descriptive Table: Cateogrical variables (Table C6) saved to `output/tables/c6-categorical-table.csv`')

# Remove variable from environment
rm(categorical_table)



