# Correlation Tables



# Table 1: Correlation Table: Reintegration ---------------------

table_correlation_reintegration <- 
    data %>% 
    select(
      civilian_commit_total,
      wis_total,
      mios_total,
      biis_blendedness,
      biis_harmony,
      mcarm_total
    ) %>% 
    corrr::correlate() %>% 
    bind_cols(
      data %>% 
                 select(
                   civilian_commit_total,
                   wis_total,
                   mios_total,
                   biis_blendedness,
                   biis_harmony,
                   mcarm_total
                 ) %>% 
                 psych::describe() %>% 
                 tibble() %>% 
                 select(mean, sd, skew, kurtosis)
               ) %>% 
  mutate(across(where(is.numeric), round, 2)) %>% 
  select(term, mean, sd, skew, kurtosis, everything()) %>% 
  rename(M = mean, 
         SD = sd, 
         Skew = skew, 
         Kurtosis = kurtosis,
         `1` = 6, `2` = 7, `3` = 8, `4` = 9, `5` = 10, `6` = 11) %>% 
  mutate(term = str_remove(term, '_total'),
         term = str_replace(term, '_', ' '),
         term = str_to_title(term)
         ) 

table_correlation_reintegration

table_correlation_reintegration %>% 
    write_csv(here::here('output/tables/correlation-table-reintegration.csv'))


# Descriptives ------------------------------------------------------------
data %>% 
  select(
    civilian_commit_total,
    wis_total,
    mios_total,
    biis_blendedness,
    biis_harmony,
    mcarm_total
  ) %>% 
  psych::describe()


# Correlation Graphic -------------------------------------------------------------------------

data %>% 
  select(civilian_commit_total,
         wis_total,
         mios_total,
         biis_blendedness,
         biis_harmony,
         mcarm_total) %>%
  rename(`Civilian Identity` = civilian_commit_total,
         `Military Identity` = wis_total,
         `Blendedness` = biis_blendedness,
         `Harmony` = biis_harmony,
         `Moral Injury` = mios_total,
         `Reintegration` = mcarm_total
         ) %>% 
  cor() %>% 
  corrplot::corrplot(type = 'lower',
                     title = 'Correlation: Reintegration',
                     diag = F,
                      )


