
# Split the sample between those who report a PMIE and those who do not
mi_event_1 <- data %>% filter(mios_screener == 1)
mi_event_0 <- data %>% filter(mios_screener == 0)


# Run a paired t-test
model_ttest <- 
  t.test(mi_event_1$mios_total, 
         mi_event_0$mios_total,
         alternative = 'greater')


# Create a table that reports the results of the t-test
results_ttest <- 
  tibble(
  result = c('t', 
             'degrees freedom', 
             'p', 
             'method', 
             'null value', 
             'Mean moral injury symptoms (experienced MI event)',
             'Mean moral injury symptoms (no prior MI event)',
             'Standard deviation (experienced MI event)',
             'Standard deviation (no prior MI event)'
  ),
  value = c(
    
    # T-test information
    round(as.numeric(model_ttest$statistic), 3),
    round(as.numeric(model_ttest$parameter), 3),
    model_ttest$p.value,
    model_ttest$method,
    round(as.numeric(model_ttest$null.value), 3),
    
    # Mean MIOS
    round(as.numeric(model_ttest$estimate)[1], 3),
    round(as.numeric(model_ttest$estimate)[2], 3),
    
    # calculate the standard deviation of MIOS for those with and without a PMIE
    round(as.numeric(sd(mi_event_1$mios_total)), 3),
    round(as.numeric(sd(mi_event_0$mios_total)), 3)
  )
)
results_ttest %>% print()

results_ttest %>% write_csv(here::here('output/t-test.csv'))






