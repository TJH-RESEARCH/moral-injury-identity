



# These display the non-robust error bars
model_wis_4b1_controls %>% 
  GGally::ggcoef_model(intercept = F)

model_biis_4b1_controls %>% 
  GGally::ggcoef_model(intercept = F, show_p_values = F, signif_stars = F)




# Trying to wrangle the robust errors
coeftest_wis_4b1_controls %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  filter(term != '(Intercept)') %>% 
  ggplot(aes(x = estimate, y = term, xmin = (estimate - 2 * std.error),
             xmax = (estimate + 2 * std.error))) +
  geom_pointrange() +
  geom_vline(aes(xintercept = 0), linetype = 2) +
  theme_classic()

coeftest_biis_4b1_controls %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  filter(term != '(Intercept)') %>% 
  ggplot(aes(x = estimate, y = term, xmin = (estimate - 2 * std.error),
             xmax = (estimate + 2 * std.error))) +
  geom_pointrange() +
  geom_vline(aes(xintercept = 0))
