
n <- data %>% nrow()
n %>% print()
n %>% write_lines('output/stats/sample-size.txt')
rm(n)
