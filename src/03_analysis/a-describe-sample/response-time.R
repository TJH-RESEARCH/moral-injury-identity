


response_time <- tibble(
  `Data Set` = c('Original', 'Simple', 'Lenient', 'Main', 'Strict'),
  `Median Survey Response Time (Minutes)` = 
    c(
      data_original %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    median(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
          filter(dataset_simple == 1) %>% 
          summarize(`Median Survey Response Time (Minutes)` = 
                      median(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>%
          filter(dataset_lenient == 1) %>% 
          summarize(`Median Survey Response Time (Minutes)` = 
                      median(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
          filter(dataset_main == 1) %>% 
          summarize(`Median Survey Response Time (Minutes)` = 
                      median(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
          filter(dataset_strict == 1) %>% 
          summarize(`Median Survey Response Time (Minutes)` = 
                      median(`Duration (in minutes)`)) %>% 
        as.numeric()
    ),
  `Mean Survey Response Time (Minutes)` = 
    c(
      data_original %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_simple == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>%
        filter(dataset_lenient == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_main == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_strict == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric()
    ),
  `Trimmed mean Survey Response Time (Minutes)` = 
    c(
      data_original %>% 
        filter(`Duration (in minutes)` < 250) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(`Duration (in minutes)` < 250) %>% 
        filter(dataset_simple == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>%
        filter(`Duration (in minutes)` < 250) %>% 
        filter(dataset_lenient == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(`Duration (in minutes)` < 250) %>% 
        filter(dataset_main == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(`Duration (in minutes)` < 250) %>% 
        filter(dataset_strict == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    mean(`Duration (in minutes)`)) %>% 
        as.numeric()
    ),
  `Maximum Survey Response Time (Minutes)` = 
    c(
      data_original %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    max(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_simple == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    max(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>%
        filter(dataset_lenient == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    max(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_main == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    max(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_strict == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    max(`Duration (in minutes)`)) %>% 
        as.numeric()
    ),
  `Minimum Survey Response Time (Minutes)` = 
    c(
      data_original %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    min(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_simple == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    min(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>%
        filter(dataset_lenient == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    min(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_main == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    min(`Duration (in minutes)`)) %>% 
        as.numeric(),
      data_original %>% 
        filter(dataset_strict == 1) %>% 
        summarize(`Median Survey Response Time (Minutes)` = 
                    min(`Duration (in minutes)`)) %>% 
        as.numeric()
    ),
  )


response_time
  



# Plot the survey time
data %>% ggplot(aes(`Duration (in minutes)`)) + geom_histogram()

response_time %>% print()

response_time %>% write_csv(here::here('output/stats/median-response-time.csv'))

rm(response_time, data_trimmed)


