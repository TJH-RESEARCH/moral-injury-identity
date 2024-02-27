

n <- tibble(
  `Data Set` = c('Original', 'Simple', 'Lenient', 'Main', 'Strict'),
  `Sample size` = 
    c(
      nrow(data_original), 
      nrow(data_original %>% filter(dataset_simple == 1)),
      nrow(data_original %>% filter(dataset_lenient == 1)),
      nrow(data_original %>% filter(dataset_main == 1)),
      nrow(data_original %>% filter(dataset_strict == 1))
  )
)
  

print(n)
n %>% kableExtra::kbl()

n %>% write_csv(here::here('output/stats/sample-size.csv'))
rm(n)