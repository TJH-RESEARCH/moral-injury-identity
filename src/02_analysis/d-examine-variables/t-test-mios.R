

mi_event_1 <- data %>% filter(mios_screener == 1)
mi_event_0 <- data %>% filter(mios_screener == 0)

model_ttest <- 
  t.test(mi_event_1$mios_total, 
         mi_event_0$mios_total,
         alternative = 'greater')

results_ttest <- tibble(
  result = c('t', 'degrees freedom', 'p', 'method', 'null value', 
             'Mean moral injury symptoms (experienced MI event)',
             'Mean moral injury symptoms (no prior MI event)'
  ),
  value = c(
    round(as.numeric(model_ttest$statistic), 3),
    round(as.numeric(model_ttest$parameter), 3),
    model_ttest$p.value,
    model_ttest$method,
    round(as.numeric(model_ttest$null.value), 3),
    round(as.numeric(model_ttest$estimate)[1], 3),
    round(as.numeric(model_ttest$estimate)[2], 3)
  )
)
results_ttest %>% print()

results_ttest %>% write_csv(here::here('output/t-test.csv'))






