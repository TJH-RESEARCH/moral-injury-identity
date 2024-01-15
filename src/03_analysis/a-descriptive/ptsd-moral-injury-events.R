
ptsd_mi_event <-
  data %>% 
  count(
    mios_screener, 
    ptsd_positive_screen) %>% 
  mutate(perc = n / sum(n) * 100) %>% 
  rename('Experience moral injury event' = 1, 
         'PTSD: Positive Detection' = 2,
         '%' =4)

ptsd_mi_event %>% print()

ptsd_mi_event %>% write_csv(here::here('output/results/pstd-moral-injury-events.csv'))
