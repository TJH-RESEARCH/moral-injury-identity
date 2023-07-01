# Regression Tables

### Military-Civilian Biculturalism?: 
### Bicultural Identity and the Adjustment of Separated Service Members




# Blendedness -----------------------------------------------------------------
output_results_anova_blended <-
  results_aov_blended %>% 
  broom::tidy() %>% 
  slice_head(n = nrow(results_aov_harmony %>% broom::tidy()) - 1) %>% 
  bind_rows(
    results_aov_harmony %>% broom::tidy() %>%  slice_tail(n = 1)
  ) %>%
  full_join(
    results_aov_blended %>% 
      effectsize::eta_squared() %>% 
      tibble(),
    by = c('term' = 'Parameter')
  ) %>% 
  rename(F = statistic,
         p = p.value
  ) %>% 
  select(term, sumsq, meansq, F, p, everything()) %>% 
  mutate(across(!c(term, p), ~round(.x, digits = 2))) %>% 
  mutate(p = round(p, digits = 3))

## Print:
output_results_anova_blended

## Save:
output_results_anova_blended %>% write_csv('output/results/results-anova-blended.csv')
rm(output_results_aov_blended)



# Harmony -----------------------------------------------------------------
  
output_results_anova_harmony <-
  results_aov_harmony %>% 
  broom::tidy() %>% 
  slice_head(n = nrow(results_aov_harmony %>% broom::tidy()) - 1) %>% 
  bind_rows(
    results_aov_harmony %>% broom::tidy() %>%  slice_tail(n = 1)
  ) %>%
  full_join(
    results_aov_blended %>% 
      effectsize::eta_squared() %>% 
      tibble(),
    by = c('term' = 'Parameter')
  ) %>% 
  rename(F = statistic,
         p = p.value
  ) %>% 
  select(term, sumsq, meansq, `F`, p, everything()) %>% 
  mutate(across(!c(term, p), ~round(.x, digits = 2))) %>% 
  mutate(p = round(p, digits = 3))

## Print:
output_results_anova_harmony

## Save:
output_results_aov_harmony %>% write_csv('output/results/results-anova-harmony.csv')
rm(output_results_anova_harmony)
