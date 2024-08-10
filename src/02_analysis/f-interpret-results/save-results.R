
# COEFICIENTS ------------------------------------------------------------------
coefs <-
  bind_rows(
    coeftest_biis %>% broom::tidy(conf.int = TRUE, conf.level = .95) %>% mutate(model = 'biis'),
    coeftest_wis %>% broom::tidy(conf.int = TRUE, conf.level = .95) %>% mutate(model = 'wis'),
    coeftest_interact %>% broom::tidy(conf.int = TRUE, conf.level = .95) %>% mutate(model = 'interact')
  )
coefs %>% write_csv(here::here('output/tables/coeficients.csv'))


# FIT METRICS ------------------------------------------------------------------
fit <-
  bind_rows(
    fit_biis %>% broom::glance() %>% mutate(model = 'biis'),
    fit_wis %>% broom::glance() %>% mutate(model = 'wis'),
    fit_interact %>% broom::glance() %>% mutate(model = 'interact'),
  )
fit %>% write_csv(here::here('output/tables/model-fit.csv'))

# COMPARE MODELS ---------------------------------------------------------------
comparison <-
  anova(fit_biis, fit_interact) %>% broom::tidy() %>% 
  mutate(model = c('biis', 'interact')) %>% 
  select(-term)
comparison %>% write_csv(here::here('output/tables/model-comparison.csv'))
