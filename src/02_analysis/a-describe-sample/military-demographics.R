

# Helper Functions -------------------------------------------------------------
source(here::here('src/01_config/function-percentage-tables.R'))
source(here::here('src/01_config/function-count-percentage.R'))

# Create Demographic Table -----------------------------------------------------


military_demographic_table <-
  bind_rows( 
    
    # Branch -------------------------------------------------------------------
    branch_sample = 
      data %>% 
      group_by(branch) %>% 
      count_perc(T),

    # Rank ---------------------------------------------------------------------
    rank = 
      data %>% 
      select(starts_with('rank')) %>% 
      create_percentage_table() %>% 
      slice(c(1,2,3,6,4,5)) %>% 
      mutate(
        category =
          c(
            "E-1 to E-3",
            "E-4 to E-6", 
            "E-7 to E-9", 
            "W-1 to CW-5", 
            "O-1 to O-3", 
            "O-4 to O-6"
          )
      ),
    
    # Service Era --------------------------------------------------------------
    service_era = 
      data %>% 
      count(service_era_init) %>% 
      mutate(perc = n / n()) %>% 
      rename(category = service_era_init),
    
    # Discharge Reason ---------------------------------------------------------
    discharge_reason = 
      data %>% 
      group_by(discharge_reason) %>% 
      count_perc(T),
   
    # Military Experiences -----------------------------------------------------
    military_experiences =
      data %>% 
      select(starts_with('military_exp') & !ends_with('total')) %>% 
      create_percentage_table() %>% 
      slice(-c(1, 4)) %>% 
      mutate(
        category =
          c("Prior combat deployment",
            "Prior non-combat deployment",
            "Prior peacekeeping deployment",
            "Supported combat operations"
          )
      ) %>% 
      arrange(desc(n)),
    
    # Disability ---------------------------------------------------------------
    disability = 
      data %>% 
      group_by(disability) %>% 
      count_perc(T) %>% 
      mutate(category = c("Does not receive VA Disability",
                          "Receives VA Disability")
      ),
    
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
      select(category, !group) %>% 
      mutate(category = c(
        "0 to 4 years of service",
        "5 to 9 years of service",
        "10 to 15 years of service",
        "15 to 20 years of service",
        "20+ years of service")
        ),
    
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
      select(category, !group) %>% 
      mutate(category = c(
        "0 to 9  years since separation",
        "10 to 19  years since separation",
        "20 to 29  years since separation",
        "30 to 39  years since separation",
        "40 to 49 years since separation",
        "50+ years since separation"
      ))
  ) %>% 
  mutate(perc = paste(round(perc, 1), "%"))




# Print -------------------------------------------------------------------
military_demographic_table %>% print(n = 100)


# Save --------------------------------------------------------------------
military_demographic_table %>% 
  kableExtra::kbl(
    caption = "Table 1: Sample Demographics",
    format = "latex",
    col.names = c("Category","n","%"),
    align = "l") %>% 
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)

military_demographic_table %>% readr::write_csv(here::here('output/tables/military-demographics.csv'))


# Message -----------------------------------------------------------------
message('Demographic table saved to `output/tables/military-demographics.csv`')