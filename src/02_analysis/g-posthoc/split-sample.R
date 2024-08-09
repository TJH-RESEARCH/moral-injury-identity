
data %>% count(mios_event_any)

data_moral_injury <-
  data %>% 
  filter(mios_event_any == 1)
