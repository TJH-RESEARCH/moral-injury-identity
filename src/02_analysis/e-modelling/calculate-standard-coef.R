


table_standard_coef <-

bind_rows(
  model_wis_interdependent_2 %>% 
    lm.beta::lm.beta() %>% broom::tidy() %>% slice(2) %>% 
    mutate(outcome = 'Attachment'),
  model_wis_private_regard_2 %>% 
    lm.beta::lm.beta() %>% broom::tidy() %>% slice(2) %>% 
    mutate(outcome = 'Pride'),
  model_biis_2 %>% 
    lm.beta::lm.beta() %>% broom::tidy() %>% slice(2) %>% 
    mutate(outcome = 'Dissonance'),
  model_biis_interact_2 %>% 
    lm.beta::lm.beta() %>% broom::tidy() %>% slice(c(2,15,16)) %>% 
    mutate(outcome = 'Dissonance (Interaction)')


)


table_standard_coef %>% print()


# Print Latex

table_standard_coef %>%  kableExtra::kbl(
  caption = "Coefficients",
  format = "latex",
  align = "l") %>% 
  write_file(here::here('output/tables/standardized-coefficients-table-latex.txt'))



# Write file --------------------------------------------------------------
table_standard_coef %>%
  mutate(across(where(is.numeric), \(x) round(x, 3))) %>% 
  write_csv(here::here('output/tables/standardized-coefficients-table.csv'))


# Message
message('Standardized Coefficients Table saved to `output/tables/standardized-coefficients-table.csv`')

# Remove variable from environmeznt
rm(table_standard_coef)


