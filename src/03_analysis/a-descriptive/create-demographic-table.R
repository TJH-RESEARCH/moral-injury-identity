

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

demographic_table[39,1] <- "Prior combat deployment"
demographic_table[40,1] <- "Prior non-combat deployment"
demographic_table[42,1] <- "Prior peacekeeping deployment"
demographic_table[43,1] <- "Supported combat operations"

demographic_table[44,1] <- "Has a close family member who served"
demographic_table[45,1] <- "Has a child who serves or served"
demographic_table[46,1] <- "Does not have a close family member who served"
demographic_table[47,1] <- "Has an other close family member who served"
demographic_table[48,1] <- "Has a parent who served"
demographic_table[49,1] <- "Has a sibling who serves or served"
demographic_table[50,1] <- "Has a spouse who serves or served"

demographic_table[58,1] <- "E-1 to E-3"
demographic_table[59,1] <- "E-4 to E-6"
demographic_table[60,1] <- "E-7 to E-9"
demographic_table[61,1] <- "O-1 to O-3"
demographic_table[62,1] <- "O-4 to O-6"
demographic_table[63,1] <- "W-1 to CW-5"

demographic_table[64,1] <- "Cold War"
demographic_table[65,1] <- "Korea"
demographic_table[66,1] <- "Multiple eras"
demographic_table[67,1] <- "Persian Gulf (pre-9/11)"
demographic_table[68,1] <- "Persian Gulf (post-9/11)"
demographic_table[69,1] <- "Post-WWII"
demographic_table[70,1] <- "Vietnam"

demographic_table[76,1] <- "Other sexuality"

demographic_table[77,1] <- "0 to 4 years of service"
demographic_table[78,1] <- "5 to 9 years of service"
demographic_table[79,1] <- "10 to 15 years of service"
demographic_table[80,1] <- "15 to 20 years of service"
demographic_table[81,1] <- "20+ years of service"

demographic_table[82,1] <- "0 to 9  years since separation"
demographic_table[83,1] <- "10 to 19  years since separation"
demographic_table[84,1] <- "20 to 29  years since separation"
demographic_table[85,1] <- "30 to 39  years since separation"
demographic_table[86,1] <- "40 to 49 years since separation"
demographic_table[87,1] <- "50+ years since separation"


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
