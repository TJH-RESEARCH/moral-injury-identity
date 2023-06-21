
# Create Plots of demographics

plot_demographics <- 
  list(
    
    age_sex = 
      data %>% 
      ggplot(aes(years_of_age, color = factor(sex))) +
      geom_density(position = 'jitter'),
    
    branch_hist =
      data %>% 
      ggplot(aes(branch)) +
      geom_bar(),
    
    years_service =
      data %>% 
      ggplot(aes(years_service)) +
      geom_density(position = 'jitter'),
    
    years_service_age =
      data %>% 
      ggplot(aes(years_service, color = factor(sex))) +
      geom_density(position = 'jitter'),
    
    years_service_age =
      data %>% 
      ggplot(aes(years_service, color = factor(branch))) +
      geom_density(position = 'jitter'),
    
    years_seperation =
      data %>% 
      ggplot(aes(years_separation)) +
      geom_density(position = 'jitter')
    
  )

plot_demographics
