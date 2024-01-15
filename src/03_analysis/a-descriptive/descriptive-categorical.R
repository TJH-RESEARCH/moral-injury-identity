

# Categorical --------------------------------------------------------------


categorical_table <-
  
  
  data %>% count(mios_screener) %>% mutate(perc = n / sum(n) * 100) %>% 
  mutate(mios_screener = 
           ifelse(mios_screener == 1, 
                  'Endorsed a moral injury event', 
                  'Did not endorse a moral injury event')) %>% rename(variable = 1) %>% 
  
  bind_rows(
    data %>% select(starts_with('mios_event_type_') & !ends_with('multiple')) %>% 
      create_percentage_table() %>% arrange() %>% rename(variable = 1)
  ) %>% 
  
  bind_rows(
    data %>% select(mios_event_type_multiple) %>% 
      create_percentage_table() %>% arrange() %>% rename(variable = 1)
  ) %>% 
    
  bind_rows(
  data %>% count(mios_criterion_a) %>% mutate(perc = n / sum(n) * 100) %>% 
      mutate(mios_criterion_a = 
               ifelse(mios_criterion_a == 1, 
                      'Endorsed Criterian A PTSD experience', 
                      'Did not endorse Criterian A experience')) %>% rename(variable = 1)
  ) %>%   
    
  bind_rows(
  data %>% count(pc_ptsd_positive_screen) %>% mutate(perc = n / sum(n) * 100) %>% 
    mutate(pc_ptsd_positive_screen = 
             ifelse(pc_ptsd_positive_screen == 1, 
                    'Probable PTSD detected', 
                    'Probable PTSD not detected')) %>% rename(variable = 1) 
  ) %>% 
 
  bind_rows(
    
    data %>% select(pc_ptsd_symptoms_any, pc_ptsd_symptoms_none) %>% 
      create_percentage_table() %>% arrange() %>% rename(variable = 1)
  ) %>% 
   
  bind_rows(
    
    data %>% select(starts_with('pc_ptsd_symptoms') & !ends_with('total') & !ends_with('any') & !ends_with('none')) %>% 
      create_percentage_table() %>% arrange() %>% rename(variable = 1)
  ) %>% 
  
  bind_rows(
    
    data %>% select(unmet_needs_any, unmet_needs_none) %>% 
      create_percentage_table() %>% arrange() %>% rename(variable = 1)
  ) %>% 
  
  bind_rows(

    data %>% select(starts_with('unmet_need') & !ends_with('total') & !ends_with('any') & !ends_with('none')) %>% 
      create_percentage_table() %>% arrange() %>% rename(variable = 1)
  )
  


# Print:
categorical_table %>% print(n = 100)
categorical_table %>%  kableExtra::kbl(
  caption = "Table 2: Descriptive Statistics for Categorical Variables",
  format = "html",
  col.names = c("Category","n","%"),
  align = "l") %>%
  kableExtra::kable_classic(full_width = F, html_font = "times")

# Write file --------------------------------------------------------------
categorical_table %>% write_csv(here::here('output/tables/c6-categorical-table.csv'))

# Message
message('Descriptive Table: Cateogrical variables (Table C6) saved to `output/tables/c6-categorical-table.csv`')

# Remove variable from environment
rm(categorical_table)



