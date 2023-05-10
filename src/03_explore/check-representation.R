

# How representative is my data? ------------------------------------------

demographic_representation <- 
  list(
  

# Age ---------------------------------------------------------------------
    age = 
      data %>% 
      #select(years_of_age) %>% 
      #ntile(n = 5)
      group_by(years_of_age) %>% 
      count() %>% 
      ungroup() %>% 
      mutate(percent = n / sum(n) * 100), 
    

# Branch ------------------------------------------------------------------
    branch = 
      data %>%
      group_by(branch) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(percent = n / sum(n) * 100), 
    
# Education ----------------------------------------------------------------
    education = 
      data %>% 
      group_by(education) %>% 
      count() %>% 
      ungroup() %>% 
      mutate(percent = n / sum(n) * 100),

# Race ----------------------------------------------------------------------
    race =
      data %>% 
        group_by(race) %>% 
        count(sort = T) %>% 
        ungroup() %>% 
        mutate(percent = n / sum(n) * 100),
    

# Rank ----------------------------------------------------------------------
    rank = 
      data %>% 
        group_by(highest_rank) %>% 
        count() %>% 
        ungroup() %>% 
        mutate(percent = n / sum(n) * 100),


# Sex ----------------------------------------------------------------------
    sex = 
      data %>% 
      group_by(sex) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(percent = n / sum(n) * 100),
  

# Sexual Orientation --------------------------------------------------------
    sexual_orientation =
      data %>% 
      mutate(sexual_orientation = factor(sexual_orientation,
                                         levels = c(1:4),
                                         labels = c('Straight',
                                                    'Gay',
                                                    'Bisexual',
                                                    "Other"))) %>% 
      group_by(sexual_orientation) %>% 
      count(sort = T) %>% 
      ungroup() %>% 
      mutate(percent = n / sum(n) * 100)

)

demographic_representation

