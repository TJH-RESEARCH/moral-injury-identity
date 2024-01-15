

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
    

    # Branch -------------------------------------------------------------------
    branch_sample = data %>% group_by(branch) %>% count_perc(T),
    
    # Disability ---------------------------------------------------------------
    disability = data %>% group_by(disability) %>% count_perc(T),
    
    # Discharge Reason ---------------------------------------------------------
    discharge_reason = data %>% group_by(discharge_reason) %>% count_perc(T),
    
    # Education ----------------------------------------------------------------
    education_sample = 
      data %>% 
      group_by(education) %>% 
      count(sort = F) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n)) %>% 
      rename(category = 1),
    

    # Employment Status --------------------------------------------------------
    employment_status = 
      data %>% 
      group_by(employment) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n)) %>% 
      rename(category = 1),

    # Marital Status -----------------------------------------------------------
    marital_status = 
      data %>% 
      group_by(marital) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n)) %>% 
      rename(category = 1),
    
    # Military Experiences -----------------------------------------------------
    military_experiences =
      data %>% select(starts_with('military_exp') & !ends_with('total')) %>% 
      create_percentage_table(),
    
    # Military Family ----------------------------------------------------------
    military_family = 
      data %>% select(starts_with('military_family') & !ends_with('total')) %>% 
      create_percentage_table(),
    
    # Race ---------------------------------------------------------------------
    race = data %>% group_by(race) %>% count_perc(T),
    
    # Rank ---------------------------------------------------------------------
    rank = 
      data %>% 
      select(starts_with('rank')) %>% 
      create_percentage_table(),
    
    
    # Service Era --------------------------------------------------------------
    
    service_era = 
      data %>% 
      select(starts_with('service_era_')) %>% 
      create_percentage_table(),
    
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
    

    # Years of Service ---------------------------------------------------------
    years_service =
      data %>% 
        select(years_service) %>% 
        mutate(group = 
                 cut(data$years_service, 
                     breaks = c(0, 4.9, 9.9, 14.9, 19.9, 30))) %>% 
        count(group) %>% 
        ungroup() %>% 
        mutate(perc = n / sum(n) * 100,
               category = as.character(group)) %>% 
      select(category, !group),
    
    # Years Since Separation ---------------------------------------------------
    years_seperation =
      data %>% 
      select(years_separation) %>% 
      mutate(group = 
               cut(data$years_separation, 
                   breaks = c(-1, 9.9, 19.9, 29.9, 39.9, 49.9, 100))) %>% 
      count(group) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n) * 100,
             category = as.character(group)) %>% 
      select(category, !group)
        
      
  ) %>% 
  mutate(perc = paste(round(perc, 1), "%"))


demographic_table[1,1] <- "18 to 34 years old"
demographic_table[2,1] <- "35 to 44 years old"
demographic_table[3,1] <- "45 to 54 years old"
demographic_table[4,1] <- "55 to 64 years old"
demographic_table[5,1] <- "65 to 74 years old"
demographic_table[6,1] <- "75 years and older"
demographic_table[13,1] <- "Does not recieve VA Disability"
demographic_table[14,1] <- "Recieves VA Disability"

demographic_table[65,1] <- "Other sexuality"

demographic_table[66,1] <- "0 to 4 years of service"
demographic_table[67,1] <- "5 to 9 years of service"
demographic_table[68,1] <- "10 to 15 years of service"
demographic_table[69,1] <- "15 to 20 years of service"
demographic_table[70,1] <- "20+ years of service"

demographic_table[71,1] <- "0 to 9  years since separation"
demographic_table[72,1] <- "10 to 19  years since separation"
demographic_table[73,1] <- "20 to 29  years since separation"
demographic_table[74,1] <- "30 to 39  years since separation"
demographic_table[75,1] <- "40 to 49 years since separation"
demographic_table[76,1] <- "50+ years since separation"


# Print -------------------------------------------------------------------
demographic_table %>% print()
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
