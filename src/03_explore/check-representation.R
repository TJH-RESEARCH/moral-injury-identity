

# How representative is my data? ------------------------------------------


data_population <- readxl::read_xlsx(here::here('data/processed/acs2021-demographics.xlsx'))

demographic_representation <- 
  list(
  

# Age ---------------------------------------------------------------------
    
    age = 
      data %>% 
      select(years_of_age) %>% 
      mutate(group = 
                  cut(data$years_of_age, 
                      breaks = c(18, 34.5, 54.5, 64.5, 74.5, 100))) %>% 
      count(group) %>% 
      ungroup() %>% 
      mutate(sample_percent = n / sum(n) * 100) %>% 
    bind_cols(
      data_population %>% 
      filter(variable == 'age') %>% 
      mutate(population_percent = population_estimate / sum(population_estimate) * 100) %>% 
      select(!c(margin_error, variable, veteran, source)),
      ) %>% 
    select(category, !c(group, population_estimate)),
      

age_hist =
  data %>% 
    select(ResponseId, years_of_age) %>%
    arrange(years_of_age) %>% 
    ggplot(aes(years_of_age)) + geom_histogram(bins = 10),

age_sex = 
  data %>% 
  ggplot(aes(years_of_age, color = sex)) +
  geom_density(position = 'jitter'),

# Branch ------------------------------------------------------------------
    branch_sample = 
      data %>%
      group_by(branch) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(sample_percent = n / sum(n) * 100), 

    
    branch_hist =
      data %>% 
      ggplot(aes(branch)) +
      geom_bar(),
      
      
    

# Disability -------------------------------------------------------------------------

    disability = 
      data %>%
      group_by(disability) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(sample_percent = n / sum(n) * 100) %>% 
      arrange(desc(sample_percent)) %>% 
      bind_cols( 
        data_population %>% 
        filter(variable == 'disability') %>% 
        mutate(population_percent = population_estimate / sum(population_estimate) * 100) %>% 
        select(!c(margin_error, variable, veteran, source, population_estimate)) %>% 
        arrange(desc(population_percent))
      ) %>% 
      select(category, everything(), !disability),


# Education ----------------------------------------------------------------
    education_sample = 
      data %>% 
      group_by(education) %>% 
      count() %>% 
      ungroup() %>% 
      mutate(sample_percent = n / sum(n) * 100),
    
    education_population =
      data_population %>% 
      filter(variable == 'education') %>% 
      mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
      select(!c(margin_error, variable, veteran, source)),


# Race ----------------------------------------------------------------------
    race =
      data %>% 
        group_by(race) %>% 
        count(sort = T) %>% 
        ungroup() %>% 
        mutate(sample_percent = n / sum(n) * 100) %>% 
        arrange(desc(sample_percent)) %>% 
      bind_cols(
        data_population %>% 
        filter(variable == 'race' & category != 'White alone') %>% 
        mutate(population_percent = population_estimate / sum(population_estimate) * 100) %>% 
        select(!c(margin_error, variable, source)) %>% 
        filter(category != 'Native Hawaiian and Other Pacific Islander alone') %>%
        arrange(desc(population_percent))
      ) %>% select(!c(category, population_estimate, veteran)),

# Sex ----------------------------------------------------------------------
    sex = 
      data %>% 
      group_by(sex) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(sample_percent = n / sum(n) * 100) %>% 
      bind_cols(
        data_population %>% 
        filter(variable == 'sex') %>% 
        mutate(population_percent = population_estimate / sum(population_estimate) * 100) %>% 
        select(!c(margin_error, variable, veteran, source))
        ) %>% select(!c(category, population_estimate)),


# Sexual Orientation --------------------------------------------------------
    sexual_orientation_sample =
      data %>% 
      group_by(sexual_orientation) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(sample_percent = n / sum(n) * 100),
    

# Misc ---------------------------------------------------------------------
    veteran_status_population = 
      data_population %>% 
      filter(variable == 'population') %>% 
      mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
      select(!c(margin_error, variable, source)),
    
    service_period_population = 
      data_population %>% 
      filter(variable == 'period_of_service') %>% 
      mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
      select(!c(margin_error, variable, veteran, source)),

    income_population = 
      data_population %>% 
      filter(variable == 'income') %>% 
      mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
      select(!c(margin_error, variable, veteran, source)),

    poverty_population = 
      data_population %>% 
      filter(variable == 'poverty') %>% 
      mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
      select(!c(margin_error, variable, veteran, source))

)

demographic_representation



# Proportion testing ------------------------------------------------------




# Run the Test: Males
prop.test(x = as.numeric(demographic_representation$sex[1,2]),         # Count of successes
          n = sum(demographic_representation$sex[,2]),                 # Total n
          p = as.numeric(demographic_representation$sex[1,4]/100),     # Hypothesized value
          alternative = "two.sided",                                   # Hypothesis type. 
          correct = TRUE)                                              # Apply Yates continuity correction?
