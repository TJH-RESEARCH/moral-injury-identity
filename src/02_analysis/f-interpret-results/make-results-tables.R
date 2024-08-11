
library(kableExtra)

# Coefficients: BIIS -----------------------------------------------------------
coefs %>%
  filter(model == 'biis') %>% 
  select(-model) %>%
  rename(
    Term = term,
    `b` = estimate,
    SE = std.error,
    t = statistic,
    p = p.value, 
    `CI Lower` = conf.low,
    `CI Upper` = conf.high
  ) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 2))) %>% 
  mutate(term = c(
    '(Intercept)',
    'Moral Injury',
    'PTSD',
    'Combat',
    'Era: Post-9/11',
    'Era: Persian Gulf',
    'Gender: Male',
    'Race/Ethnicity: Black',
    'Race/Ethnicity: White'
  )) %>% 
  kbl(caption = "Regression Coefficients: Identity Dissonance",
      format = "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align = "l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()


# Coefficients: WIS ------------------------------------------------------------
coefs %>%
  filter(model == 'wis') %>% 
  select(-model) %>%
  rename(
    `b` = estimate,
    SE = std.error,
    t = statistic,
    p = p.value, 
    `CI Lower` = conf.low,
    `CI Upper` = conf.high
  ) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 2))) %>% 
  mutate(term = c(
    '(Intercept)',
    'Moral Injury',
    'PTSD',
    'Combat',
    'Era: Post-9/11',
    'Era: Persian Gulf',
    'Gender: Male',
    'Race/Ethnicity: Black',
    'Race/Ethnicity: White'
  )) %>% 
  kbl(caption ="Regression Coefficients: Attachment",
      format = "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()


# Coefficients: Interaction Model -----------------------------------------
coefs %>%
  filter(model == 'interact') %>% 
  select(-model) %>%
  rename(
    `b` = estimate,
    SE = std.error,
    t = statistic,
    p = p.value, 
    `CI Lower` = conf.low,
    `CI Upper` = conf.high
  ) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 2))) %>% 
  mutate(term = c(
    '(Intercept)',
    'Moral Injury',
    'Public Regard',
    'PTSD',
    'Combat',
    'Era: Post-9/11',
    'Era: Persian Gulf',
    'Gender: Male',
    'Race/Ethnicity: Black',
    'Race/Ethnicity: White',
    'Moral Injury x Public Regard'
  )) %>% 
  kbl(caption="Regression Coefficients: Identity Dissonance with Interaction",
      format= "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()



# Coefficients: BIIS -----------------------------------------------------------
coefs %>%
  filter(model == 'biis_m2cq') %>% 
  select(-model) %>%
  rename(
    Term = term,
    `b` = estimate,
    SE = std.error,
    t = statistic,
    p = p.value, 
    `CI Lower` = conf.low,
    `CI Upper` = conf.high
  ) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 2))) %>% 
  mutate(term = c(
    '(Intercept)',
    'Identity Dissonance',
    'Moral Injury',
    'PTSD',
    'Combat',
    'Era: Post-9/11',
    'Era: Persian Gulf',
    'Gender: Male',
    'Race/Ethnicity: Black',
    'Race/Ethnicity: White'
  )) %>% 
  kbl(caption = "Regression Coefficients: M2C-Q - Identity Dissonance",
      format = "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align = "l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()


# Coefficients: WIS ------------------------------------------------------------
coefs %>%
  filter(model == 'wis_m2cq') %>% 
  select(-model) %>%
  rename(
    `b` = estimate,
    SE = std.error,
    t = statistic,
    p = p.value, 
    `CI Lower` = conf.low,
    `CI Upper` = conf.high
  ) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 2))) %>% 
  mutate(term = c(
    '(Intercept)',
    'Attachment',
    'Moral Injury',
    'PTSD',
    'Combat',
    'Era: Post-9/11',
    'Era: Persian Gulf',
    'Gender: Male',
    'Race/Ethnicity: Black',
    'Race/Ethnicity: White'
  )) %>% 
  kbl(caption ="Regression Coefficients: M2C-Q - Military Attachment",
      format = "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()




# Model Fits --------------------------------------------------------------
fit %>% 
  select(model, everything()) %>% 
  rename(
    `R^2` = r.squared,
    `Adjusted R^2` = adj.r.squared,
    `F` = statistic,
    p = p.value,
    Model = model,
    n = nobs
  ) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 2))) %>% 
  kbl(caption = "Model Fit",
      format = "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()




# Comparison --------------------------------------------------------------
comparison %>% 
  select(model, everything()) %>% 
  rename(Model = model,
         `SS` = sumsq,
         `DF Residuals` = df.residual,
         `DF` = df,
         `RSS` = rss,
         `F` = statistic,
         p = p.value) %>% 
  mutate(Model = c('No interaction', 'Interaction')) %>% 
  mutate(across(where(is.numeric),  ~ round(.x, 2))) %>% 
  kbl(caption ="Model Comparison",
      format = "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align="l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()





