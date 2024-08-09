

# Helper Functions -------------------------------------------------------------
source(here::here('src/01_config/functions/function-percentage-tables.R'))
source(here::here('src/01_config/functions/function-count-percentage.R'))

# Create Demographic Table -----------------------------------------------------


military_demographic_table <-
  bind_rows( 
    
    # Branch -------------------------------------------------------------------
    branch_sample = data %>% group_by(branch) %>% count_perc(T),

    # Rank ---------------------------------------------------------------------
    rank = 
      data %>% 
      select(starts_with('rank')) %>% 
      create_percentage_table() %>% 
      slice(c(1,2,3,6,4,5)),
    
    
    # Service Era --------------------------------------------------------------
    
    service_era = 
      data %>% 
      count(service_era_init) %>% 
      mutate(perc = n / n()) %>% 
      rename(category = service_era_init),
    
    # Discharge Reason ---------------------------------------------------------
    discharge_reason = data %>% group_by(discharge_reason) %>% count_perc(T),
   
    # Military Experiences -----------------------------------------------------
    military_experiences =
      data %>% select(starts_with('military_exp') & !ends_with('total')) %>% 
      create_percentage_table() %>% 
      slice(-c(1, 4)),
    
    # Disability ---------------------------------------------------------------
    disability = data %>% group_by(disability) %>% count_perc(T),
    
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

military_demographic_table[7,1] <- "E-1 to E-3"
military_demographic_table[8,1] <- "E-4 to E-6"
military_demographic_table[9,1] <- "E-7 to E-9"
military_demographic_table[10,1] <- "W-1 to CW-5"
military_demographic_table[11,1] <- "O-1 to O-3"
military_demographic_table[12,1] <- "O-4 to O-6"





military_demographic_table[24,1] <- "Prior combat deployment"
military_demographic_table[25,1] <- "Prior non-combat deployment"
military_demographic_table[25,1] <- "Prior peacekeeping deployment"
military_demographic_table[27,1] <- "Supported combat operations"

military_demographic_table[28,1] <- "Does not recieve VA Disability"
military_demographic_table[29,1] <- "Recieves VA Disability"

military_demographic_table[30,1] <- "0 to 4 years of service"
military_demographic_table[31,1] <- "5 to 9 years of service"
military_demographic_table[32,1] <- "10 to 15 years of service"
military_demographic_table[33,1] <- "15 to 20 years of service"
military_demographic_table[34,1] <- "20+ years of service"

military_demographic_table[35,1] <- "0 to 9  years since separation"
military_demographic_table[36,1] <- "10 to 19  years since separation"
military_demographic_table[37,1] <- "20 to 29  years since separation"
military_demographic_table[38,1] <- "30 to 39  years since separation"
military_demographic_table[39,1] <- "40 to 49 years since separation"
military_demographic_table[40,1] <- "50+ years since separation"



# Print -------------------------------------------------------------------
military_demographic_table %>% print(n = 100)

military_demographic_table %>% 
  kableExtra::kbl(
    caption = "Table 1: Sample Demographics",
    format = "html",
    col.names = c("Category","n","%"),
    align = "l") %>%
  kableExtra::kable_classic(full_width = F, html_font = "times")

military_demographic_table %>% kableExtra::kbl(format = 'latex') %>% 
  write_lines(here::here('output/tables/military-demographics-latex.txt'))

military_demographic_table %>% kableExtra::kbl(format = 'latex') %>%
  write_lines(here::here('output/results/results-tables.txt'))

# Save --------------------------------------------------------------------
military_demographic_table %>% readr::write_csv(here::here('output/tables/military-demographics.csv'))

# Message -----------------------------------------------------------------
message('Demographic table saved to `output/tables/military-demographics.csv`')

# Clean -------------------------------------------------------------------
rm(count_perc, create_percentage_table, military_demographic_table)




