

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
      group_by(sexual_orientation) %>% 
      count_perc(sort = T),
    
    # Education ----------------------------------------------------------------
    education_sample = 
      data %>% 
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
      rename(category = 1),
    
    # Military Family ----------------------------------------------------------
    military_family = 
      data %>% select(starts_with('military_family') & !ends_with('total')) %>% 
      create_percentage_table()
    
  ) %>% 
  mutate(perc = paste(round(perc, 1), "%"))


demographic_table[1,1] <- "18 to 34 years old"
demographic_table[2,1] <- "35 to 44 years old"
demographic_table[3,1] <- "45 to 54 years old"
demographic_table[4,1] <- "55 to 64 years old"
demographic_table[5,1] <- "65 to 74 years old"
demographic_table[6,1] <- "75 years and older"

demographic_table[12,1] <- "Other sexuality"


demographic_table[38,1] <- "Has a close family member who served"
demographic_table[39,1] <- "Has a child who serves or served"
demographic_table[40,1] <- "Does not have a close family member who served"
demographic_table[41,1] <- "Has an other close family member who served"
demographic_table[42,1] <- "Has a parent who served"
demographic_table[43,1] <- "Has a sibling who serves or served"
demographic_table[44,1] <- "Has a spouse who serves or served"


# Print -------------------------------------------------------------------
demographic_table %>% print(n = 100)

demographic_table %>% 
  kableExtra::kbl(
    caption = "Table 1: Sample Demographics",
    format = "html",
    col.names = c("Category","n","%"),
    align = "l") %>%
  kableExtra::kable_classic(full_width = F, html_font = "times")

# Save --------------------------------------------------------------------
demographic_table %>% readr::write_csv(here::here('output/tables/sample-demographics.csv'))

# Message -----------------------------------------------------------------
message('Demographic table saved to `output/tables/sample-demographics.csv`')

# Clean -------------------------------------------------------------------
rm(count_perc, create_percentage_table, demographic_table)





# Graphs ------------------------------------------------------------------
data %>% ggplot(aes(years_of_age)) + geom_density()
data %>% ggplot(aes(branch)) + geom_bar()
data %>% ggplot(aes(service_era)) + geom_bar()
ggplot(data, aes(x = '', y = 'identity', fill = branch)) + geom_col() + coord_polar(theta = "y")
data %>% ggplot(aes(highest_rank)) + geom_bar()
ggplot(data, aes(x = '', y = 'identity', fill = highest_rank)) + geom_col() + coord_polar(theta = "y")
