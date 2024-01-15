

# Survey Time
response_time <-
  data %>% 
  summarize(`Median Survey Response Time (Minutes)` = median(`Duration (in minutes)`),
            `Mean Survey Response Time (Minutes)` = mean(`Duration (in minutes)`))

  
response_time %>% print()

response_time %>% write_csv(here::here('output/stats/median-response-time.csv'))

rm(response_time)