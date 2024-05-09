
# Alpha -------------------------------------------------------------------

alpha_mios <-
  data %>% 
  select(mios_1, mios_2, mios_3, mios_4,
         mios_5, mios_6, mios_7, mios_8,
         mios_9, mios_10, mios_11, mios_12,
         mios_13, mios_14) %>% 
  psych::alpha()

alpha_mios$total[1] %>% 
  round(2) %>% 
  write_lines(file = here::here('output/stats/alpha-mios.txt'))

