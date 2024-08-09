
data_moral_injury %>% count()
data_moral_injury %>% count(mios_event_type) %>% mutate(perc = n / sum(n))
data_moral_injury %>% count(mios_event_type_self)
data_moral_injury %>% count(mios_event_type_other)
data_moral_injury %>% count(mios_event_type_betrayal)