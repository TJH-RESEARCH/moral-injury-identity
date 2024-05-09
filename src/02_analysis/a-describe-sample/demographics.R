

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
      mutate(perc = n / sum(n) * 100, category = as.character(category)),
    
    # Sex ----------------------------------------------------------------------
    sex = 
      data %>% 
      group_by(sex) %>% 
      count_perc(sort = T),
    
    # Sexual Orientation -------------------------------------------------------
    sexual_orientation_sample =
      data %>% 
      mutate(sexual_orientation = fct_lump_prop(sexual_orientation, prop = .1)) %>% 
      group_by(sexual_orientation) %>% 
      count_perc(sort = T),
    
    # Education ----------------------------------------------------------------
    education_sample = 
      data %>% 
      mutate(employment = fct_lump(employment, prop = .05)) %>% 
      group_by(education) %>% 
      count(sort = F) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n) * 100) %>% 
      rename(category = 1),
    
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


demographic_table[1,1] <- "18 to 34 years old"
demographic_table[2,1] <- "35 to 44 years old"
demographic_table[3,1] <- "45 to 54 years old"
demographic_table[4,1] <- "55 to 64 years old"
demographic_table[5,1] <- "65 to 74 years old"
demographic_table[6,1] <- "75 years and older"

demographic_table[12,1] <- "Other sexuality"



# Print -------------------------------------------------------------------
demographic_table %>% print(n = 100)

demographic_table %>% 
  kableExtra::kbl(
    caption = "Table 1: Sample Demographics",
    format = "html",
    col.names = c("Category","n","%"),
    align = "l") %>%
  kableExtra::kable_classic(full_width = F, html_font = "times")

demographic_table %>% kableExtra::kbl(format = 'latex') %>% 
  write_lines(here::here('output/tables/demographics-latex.txt'))

demographic_table %>% kableExtra::kbl(format = 'latex') %>%
  write_lines(here::here('output/results/results-tables.txt'))


# Save --------------------------------------------------------------------
demographic_table %>% readr::write_csv(here::here('output/tables/demographics.csv'))

# Message -----------------------------------------------------------------
message('Demographic table saved to `output/tables/sample-demographics.csv`')

# Clean -------------------------------------------------------------------
rm(count_perc, create_percentage_table, demographic_table)




