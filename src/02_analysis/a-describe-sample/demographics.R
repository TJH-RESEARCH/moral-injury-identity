

# Helper Functions -------------------------------------------------------------
source(here::here('src/01_config/functions/function-percentage-tables.R'))
source(here::here('src/01_config/functions/function-count-percentage.R'))

# Create Demographic Table -----------------------------------------------------


demographic_table <-
  bind_rows( 
    
    # Age ----------------------------------------------------------------------
    age = 
      data %>% 
      select(years_of_age) %>% 
      mutate(category = 
               cut(data$years_of_age, 
                   breaks = c(18, 34.5, 44.5, 54.5, 64.5, 74.5, 100))) %>% 
      count(category) %>% 
      mutate(perc = n / sum(n) * 100, category = as.character(category)) %>% 
      mutate(category = 
               c("18 to 34 years old",
                 "35 to 44 years old",
                 "45 to 54 years old",
                 "55 to 64 years old",
                 "65 to 74 years old",
                 "75 years and older"
                 )
      ),
    
    # Sex ----------------------------------------------------------------------
    sex = 
      data %>% 
      group_by(sex) %>% 
      count_perc(sort = T) %>% 
      mutate(category = c('Male', 'Female')),
    
    # Sexual Orientation -------------------------------------------------------
    sexual_orientation_sample =
      data %>% 
      mutate(sexual_orientation = fct_lump_prop(sexual_orientation, prop = .1)) %>% 
      group_by(sexual_orientation) %>% 
      count_perc(sort = T) %>% 
      mutate(category = c('Straight/Heterosexual', 'Other sexuality')),
    
    # Education ----------------------------------------------------------------
    education_sample = 
      data %>% 
      mutate(employment = fct_lump(employment, prop = .05)) %>% 
      group_by(education) %>% 
      count(sort = F) %>% 
      mutate(education = 
               factor(education, 
                      levels = c('High school diploma or equivalent',
                                 'Some college',
                                 'Associates degree',
                                 'Bachelors degree',
                                 'Masters degree',
                                 'Applied or professional doctorate',
                                 'Doctorate'),
                      ordered = TRUE)
             ) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n) * 100) %>% 
      rename(category = 1) %>% 
      arrange(category),
    
    # Race ---------------------------------------------------------------------
    race = data %>% group_by(race) %>% count_perc(T),
    
    # Employment Status --------------------------------------------------------
    employment_status = 
      data %>% 
      mutate(employment = fct_lump_prop(employment, prop = .05)) %>% 
      group_by(employment) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n) * 100) %>% 
      rename(category = 1),
    
    # Marital Status -----------------------------------------------------------
    marital_status = 
      data %>% 
      group_by(marital) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n) * 100) %>% 
      rename(category = 1)
    
  ) %>% 
  mutate(perc = paste(round(perc, 1), "%"))




# Print -------------------------------------------------------------------
demographic_table %>% print(n = 100)


# Save --------------------------------------------------------------------
demographic_table %>% 
  kableExtra::kbl(
    caption = "Sample Demographics",
    format = "latex",
    col.names = c("Category","n","%"),
    align = "l") %>% 
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()

demographic_table %>% readr::write_csv(here::here('output/tables/demographics.csv'))


# Message -----------------------------------------------------------------
message('Demographic table saved to `output/tables/sample-demographics.csv`')
