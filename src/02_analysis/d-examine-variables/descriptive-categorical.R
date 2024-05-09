

source(here::here('src/01_config/functions/function-percentage-tables.R'))
source(here::here('src/01_config/functions/function-count-percentage.R'))

# Categorical --------------------------------------------------------------


categorical_table <-
  
  
  data %>% count(mios_screener) %>% mutate(perc = n / sum(n) * 100) %>% 
  mutate(mios_screener = 
           ifelse(mios_screener == 1, 
                  'Endorsed a moral injury event', 
                  'Did not endorse a moral injury event')) %>% rename(variable = 1) %>% 
  
  bind_rows(
    data %>% select(starts_with('mios_event_type_') & !ends_with('multiple')) %>% 
      create_percentage_table() %>% arrange() %>% rename(variable = 1), 
    
    data %>% select(mios_event_type_multiple) %>% 
      create_percentage_table() %>% arrange() %>% rename(variable = 1),
  
    data %>% count(mios_criterion_a) %>% mutate(perc = n / sum(n) * 100) %>% 
      mutate(mios_criterion_a = 
               ifelse(mios_criterion_a == 1, 
                      'Endorsed Criterian A PTSD experience', 
                      'Did not endorse Criterian A experience')) %>% rename(variable = 1),
  
    data %>% count(pc_ptsd_positive_screen) %>% mutate(perc = n / sum(n) * 100) %>% 
      mutate(pc_ptsd_positive_screen = 
                ifelse(pc_ptsd_positive_screen == 1, 
                      'Probable PTSD detected', 
                      'Probable PTSD not detected')) %>% rename(variable = 1)
  ) %>% 
  mutate(perc = round(perc, 2))

  
categorical_table$variable[3] <- 'Moral Injury Event Type: Betrayal'
categorical_table$variable[4] <- 'Moral Injury Event Type: Other Person'
categorical_table$variable[5] <- 'Moral Injury Event Type: Self'
categorical_table$variable[6] <- 'Moral Injury Event Type: Multiple Types'



# Print:
categorical_table %>% print(n = 100)
categorical_table %>%  kableExtra::kbl(
  caption = "Descriptive Statistics for Categorical Variables",
  format = "html",
  col.names = c("Category","n","%"),
  align = "l") %>%
  kableExtra::kable_classic(full_width = F, html_font = "times")


# Print Latex

categorical_table %>%  kableExtra::kbl(
  caption = "Descriptive Statistics for Categorical Variables",
  format = "latex",
  col.names = c("Category","n","%"),
  align = "l") %>% 
  write_file(here::here('output/tables/categorical-table-latex.txt'))

categorical_table %>% kableExtra::kbl(format = 'latex') %>%
  append_results_tables()


# Write file --------------------------------------------------------------
categorical_table %>% write_csv(here::here('output/tables/categorical-table.csv'))

# Message
message('Descriptive Table: Cateogrical variables saved to `output/tables/categorical-table.csv`')

# Remove variable from environment
rm(categorical_table)



