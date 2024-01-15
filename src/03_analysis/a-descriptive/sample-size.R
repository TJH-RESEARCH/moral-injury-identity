
n <- tibble(
  sample_size = nrow(data)
)
print(n)
n %>% write_csv(here::here('output/stats/sample-size.csv'))
rm(n)