
table_mi_events <- 
  data %>% count(mios_screener) %>% mutate(perc = n / sum(n))
table_mi_events %>% print()
table_mi_events %>% write_csv(here::here('output/tables/table-mi-events.csv'))
rm(table_mi_events)


# MI EVENT AND PTSD EVENT -------------------------------------------------
data %>% 
  group_by(trauma_type) %>% 
  summarize(n = n(), 
            mean_mios_total = mean(mios_total),
            mean_m2cq = mean(m2cq_mean),
            mean_biis = mean(biis_harmony)) %>% 
  ungroup() %>% 
  mutate(perc = n / sum(n) * 100) %>% 
  select(trauma_type, n, perc, everything())


# MI EVENT BY TYPE  -------------------------------------------------------------

data %>% 
  group_by(mios_event_type) %>% 
  summarize(n = n(), 
            mean_mios_total = mean(mios_total),
            mean_m2cq = mean(m2cq_mean),
            mean_biis = mean(biis_harmony)) %>% 
  ungroup() %>% 
  mutate(perc = n / sum(n) * 100) %>% 
  arrange(desc(n))


# Combat Experience, PTSD Event, PTSD -------------------------------------
data %>% 
  group_by(military_exp_combat,mios_criterion_a, ptsd_positive_screen) %>% 
  summarize(n = n(), 
            mean_mios = mean(mios_total), 
            mean_m2cq = mean(m2cq_mean)) %>% 
  mutate(perc = n / sum(n) * 100)


# Moral Injury Self -------------------------------------------------------
data %>% 
  filter(mios_event_type_multiple == 1) %>% 
  group_by(mios_event_type_self) %>% 
  summarize(n = n(), 
            mean_mios_total = mean(mios_total),
            mean_m2cq = mean(m2cq_mean),
            mean_biis = mean(biis_harmony)) %>% 
  ungroup() %>% 
  mutate(perc = n / sum(n) * 100) %>% 
  arrange(desc(n))




# PTSD Screener -----------------------------------------------------------
data %>% count(ptsd_positive_screen)
data %>% count(mios_criterion_a, ptsd_positive_screen)


data %>% 
  group_by(mios_criterion_a, ptsd_positive_screen) %>% 
  summarize(n = n(), 
            mean_mios = mean(mios_total), 
            mean_m2cq = mean(m2cq_mean)) %>% 
  mutate(perc = n / sum(n) * 100)


# -------------------------------------------------------------------------
data %>% 
  filter(military_exp_combat == 1) %>% 
  group_by(mios_criterion_a) %>% 
  summarize(n = n(), 
            mean_mios = mean(mios_total), 
            mean_m2cq = mean(m2cq_mean)) %>% 
  mutate(perc = n / sum(n) * 100)


events_table <-
  data %>% 
  group_by(mios_criterion_a, ptsd_positive_screen) %>% 
  summarize(
            mean_mios = mean(mios_total), 
            mean_m2cq = mean(m2cq_mean),
            mean_biis = mean(biis_harmony),
            n = n()
          ) %>% 
  ungroup() %>% 
  mutate(perc = n / sum(n) * 100)

events_table %>% print()

events_table %>% write_csv(here::here('output/tables/events-table.csv'))
rm(events_table)






  data %>% 
  group_by(military_exp_any, 
           military_exp_combat, 
           mios_screener, 
           mios_criterion_a,
           ptsd_positive_screen) %>% 
  summarize(
    mean_mios = mean(mios_total), 
    mean_m2cq = mean(m2cq_mean),
    mean_biis = mean(biis_harmony),
    n = n()
  ) %>% 
  ungroup() %>% 
  mutate(perc = n / sum(n) * 100)

data %>% 
  count(
    military_exp_any, 
    military_exp_combat) %>% 
  mutate(perc = n / sum(n) * 100)


data %>% 
  count(
    mios_criterion_a) %>% 
  mutate(perc = n / sum(n) * 100)


data %>% 
  count(
    mios_screener) %>% 
  mutate(perc = n / sum(n) * 100)

