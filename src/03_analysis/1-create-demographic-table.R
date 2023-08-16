

# Helper Functions --------------------------------------------------------
source(here::here('src/01_config/functions/function-percentage-tables.R'))
source(here::here('src/01_config/functions/function-count-percentage.R'))

# Create Demographic Table ------------------------------------------------


demographic_table <-
  bind_rows( 
  
    # Age ---------------------------------------------------------------------
    age = 
      data %>% 
      select(years_of_age) %>% 
      mutate(category = 
               cut(data$years_of_age, 
                   breaks = c(18, 34.5, 54.5, 64.5, 74.5, 100))) %>% 
      count(category) %>% 
      mutate(perc = n / sum(n) * 100, category = as.character(category)),
    

    # Branch ------------------------------------------------------------------
    branch_sample = data %>% group_by(branch) %>% count_perc(T),
    
    # Disability -------------------------------------------------------------------------
    disability = data %>% group_by(disability) %>% count_perc(T),
    
    # Discharge Reason --------------------------------------------------------
    discharge_reason = data %>% group_by(discharge_reason) %>% count_perc(T),
    
    # Education ----------------------------------------------------------------
    education_sample = data %>% group_by(education) %>% count_perc(F),
    
    # Military Experiences ----------------------------------------------------
    military_experiences =
      data %>% select(starts_with('military_exp') & !ends_with('total')) %>% 
      create_percentage_table(),
    
    # Military Family ---------------------------------------------------------
    military_family = 
      data %>% select(starts_with('military_family') & !ends_with('total')) %>% 
      create_percentage_table(),
    
    # Race ----------------------------------------------------------------------
    race = data %>% group_by(race) %>% count_perc(T),
    
    # Rank --------------------------------------------------------------------
    rank = 
      data %>% 
      select(starts_with('rank')) %>% 
      create_percentage_table(),
    
    
    # Service Era -------------------------------------------------------------
    
    service_era = 
      data %>% 
      select(starts_with('service_era_')) %>% 
      create_percentage_table(),
    
    # Sex ----------------------------------------------------------------------
    sex = 
      data %>% 
      group_by(sex) %>% 
      count_perc(sort = T),
    
    
    # Sexual Orientation --------------------------------------------------------
    sexual_orientation_sample =
      data %>% 
      group_by(sexual_orientation) %>% 
      count_perc(sort = T),
    
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
    
    years_seperation =
      data %>% 
      select(years_separation) %>% 
      mutate(group = 
               cut(data$years_separation, 
                   breaks = c(0, 9.9, 19.9, 29.9, 39.9, 49.9, 100))) %>% 
      count(group) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n) * 100,
             category = as.character(group)) %>% 
      select(category, !group)
        
      
  ) %>% 
  mutate(perc = paste(round(perc, 1), "%"))



# Print -------------------------------------------------------------------
demographic_table %>% print(n = 100)

# Save --------------------------------------------------------------------
demographic_table %>% readr::write_csv(here::here('output/tables/demographic-table.csv'))

# Message -----------------------------------------------------------------
message('Demographic table saved to `output/tables/demographic-table.csv`')
