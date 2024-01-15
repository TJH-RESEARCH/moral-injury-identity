
# Plot the survey time
data %>% ggplot(aes(`Duration (in minutes)`)) + geom_histogram()

# Trim the outliers
data_trimmed <- 
  data %>% 
  filter(`Duration (in minutes)` < 250)

# Survey Time
response_time <-
  data %>% 
  summarize(`Median Survey Response Time (Minutes)` = median(`Duration (in minutes)`),
  )

response_time <-
  data_trimmed %>% 
  summarize(
    `Trimmed Mean Survey Response Time (Minutes)` = mean(`Duration (in minutes)`),
    `Trimmed Standard Deviation Survey Response Time (Minutes)` = sd(data$`Duration (in minutes)`)
  ) %>% bind_cols(response_time)


  
response_time %>% print()

response_time %>% write_csv(here::here('output/stats/median-response-time.csv'))

rm(response_time, data_trimmed)


