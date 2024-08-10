
n <- data %>% nrow()
n %>% print()
n %>% write_lines('output/sample-size.txt')
rm(n)
