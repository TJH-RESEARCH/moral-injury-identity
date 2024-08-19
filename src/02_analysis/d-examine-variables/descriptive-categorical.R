

source(here::here('src/01_config/function-percentage-tables.R'))
source(here::here('src/01_config/function-count-percentage.R'))

# Categorical --------------------------------------------------------------


categorical_table <-
  data %>% 
  count(mios_screener) %>% mutate(perc = n / sum(n) * 100) %>% 
  mutate(mios_screener = 
           ifelse(mios_screener == 1, 
                  'Endorsed a moral injury event', 
                  'Did not endorse a moral injury event')) %>% 
  rename(Category = 1) %>% 
  
  bind_rows(
    data %>% 
      select(starts_with('mios_event_type_') & !ends_with('multiple')) %>% 
      create_percentage_table() %>% 
      select(-perc) %>%
      rename(Category = 1) %>% 
      mutate(
        Category = c('Moral Injury Event Type: Betrayal',
                'Moral Injury Event Type: Other Person',
                'Moral Injury Event Type: Self'),
        perc = (n / 
             # percent of those endorsing an MI event
             data %>% 
             count(mios_screener) %>% 
             filter(mios_screener == 1) %>% 
             select(n) %>% as.numeric()
             ) * 100
        ), 
    
    data %>% 
      count(mios_event_type_multiple) %>% 
      filter(mios_event_type_multiple == 1) %>% 
      mutate(
        perc = (n / 
               # percent of those endorsing an MI event
               data %>% 
               count(mios_screener) %>% 
               filter(mios_screener == 1) %>% 
               select(n) %>% as.numeric()
               ) * 100
        ) %>% 
      rename(Category = 1) %>% 
      mutate(Category = c('Moral Injury Event Type: Multiple Types')),
  
    data %>% 
      count(mios_criterion_a) %>% 
      mutate(perc = n / sum(n) * 100) %>% 
      mutate(mios_criterion_a = 
               ifelse(mios_criterion_a == 1, 
                      'Endorsed Criterion A PTSD experience', 
                      'Did not endorse Criterion A experience')) %>% 
      rename(Category = 1),
  
    data %>% 
      count(pc_ptsd_positive_screen) %>% 
      mutate(perc = n / sum(n) * 100) %>% 
      mutate(pc_ptsd_positive_screen = 
                ifelse(pc_ptsd_positive_screen == 1, 
                      'Probable PTSD detected', 
                      'Probable PTSD not detected')) %>% 
      rename(Category = 1)
    
  ) %>% 
  mutate(perc = round(perc, 1))

  





# Print:
categorical_table %>% print(n = 100)

# Write file --------------------------------------------------------------
categorical_table %>%  
  kableExtra::kbl(
  caption = "Descriptive Statistics for Categorical Categorys",
  format = "latex",
  col.names = c("Category","n","%"),
  align = "l") %>% 
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)

categorical_table %>% write_csv(here::here('output/tables/categorical-table.csv'))


# Message
message('Descriptive Table: Cateogrical Categorys saved to `output/tables/categorical-table.csv`')



