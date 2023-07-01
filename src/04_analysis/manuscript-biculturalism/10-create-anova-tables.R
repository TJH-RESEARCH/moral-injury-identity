# Regression Tables

### Military-Civilian Biculturalism?: 
### Bicultural Identity and the Adjustment of Separated Service Members




# Blendedness -----------------------------------------------------------------

## Add a value to the bootstrapped p values
results_boot_blendedness$`p-values`[4] <- NA

output_results_anova_blended <-
  
## Tidy the anova results
  results_aov_blended %>% 
  broom::tidy() %>% 
  
## Calculate and add effect size - partial \eta^2
  full_join(
    results_aov_blended %>% 
      effectsize::eta_squared(
        partial = TRUE,
        generalized = FALSE,
        ci = 0.95,
        alternative = "two.sided",
      ) %>% 
      tibble(),
    by = c('term' = 'Parameter')
  ) %>% 
  
## Rename variables for printing
  rename(F = statistic,
         p = p.value
  ) %>% 
  
## Rearrange for conventional APA table
  select(term, sumsq, meansq, F, p, everything()) %>% 

## Round digits
  mutate(across(!c(term, p), ~round(.x, digits = 2))) %>% 
  mutate(p = round(p, digits = 3),
         
## Add bootstrapped p value
         p_boot = results_boot_blendedness$`p-values`)


## Print:
output_results_anova_blended

## Save:
output_results_anova_blended %>% write_csv('output/results/anova-blended.csv')
rm(output_results_anova_blended)



# Harmony -----------------------------------------------------------------
  
## Add a value to the bootstrapped p values
results_boot_harmony$`p-values`[4] <- NA

output_results_anova_harmony <-

  
## Tidy the anova results
  results_aov_harmony %>% 
  broom::tidy() %>% 
  
## Calculate and add effect size - partial \eta^2
  full_join(
    results_aov_blended %>% 
      effectsize::eta_squared(
        partial = TRUE,
        generalized = FALSE,
        ci = 0.95,
        alternative = "two.sided",
      ) %>% 
      tibble(),
    by = c('term' = 'Parameter')
  ) %>% 
  
## Rename variables for printing
  rename(F = statistic,
         p = p.value
  ) %>% 
  
## Rearrange for conventional APA table
  select(term, sumsq, meansq, `F`, p, everything()) %>% 
  
## Round most to 2 digits, p-value to 3 digits
  mutate(across(!c(term, p), ~round(.x, digits = 2))) %>% 
  mutate(p = round(p, digits = 3),
         
## add the bootstrapped p value
         p_boot = results_boot_harmony$`p-values`)


## Print:
output_results_anova_harmony

## Save:
output_results_anova_harmony %>% write_csv('output/results/anova-harmony.csv')
rm(output_results_anova_harmony)
