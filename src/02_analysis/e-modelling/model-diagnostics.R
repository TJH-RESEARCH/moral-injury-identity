# ANALYZE REGRESSION DIAGNOSTICS -----------------------------------------------

library(patchwork)


## Extract lm objects from parsnip objects ------------------------------------
boot_fits_aparent <-
  boot_output %>% 
  filter(id == 'Apparent')

boot_fits_aparent$fits <-
  boot_fits_aparent$fits[1:nrow(boot_fits_aparent)] %>% 
  map(~ extract_fit_engine(.x))


## Check residuals of individual regressions -----------------------------------
### Interdependence as the outcome ---------------------------------------------
diagnostics_interdependence <-
  tibble(
    residuals = boot_fits_aparent$fits[[1]]$residuals,
    fits = boot_fits_aparent$fits[[1]]$fitted.values
  )

#### Normality (Histogram of residuals)
hist_diagnostics_interdependence <-
diagnostics_interdependence %>% 
  ggplot(aes(residuals)) +
  geom_histogram() +
  labs(x = 'Residuals', y = 'Count')

#### Linearity (Residual Dependence Plot)
linearity_diagnostics_interdependence <-
diagnostics_interdependence %>% 
  ggplot(aes(fits, residuals)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(x = 'Fitted Values', y = 'Residuals')

#### Homoskedasticity (SL Plot)
homosked_diagnostics_interdependence <-
diagnostics_interdependence %>% 
  mutate(abs_residuals = abs(residuals)) %>% 
  ggplot(aes(fits, abs_residuals)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(x = 'Fitted Values', y = 'Absolute Residuals')


#### All plots combined
(
plot_diagnostics_interdependence <-
  hist_diagnostics_interdependence +
  (linearity_diagnostics_interdependence /
  homosked_diagnostics_interdependence) +
    patchwork::plot_annotation(
      title = 'Model Diagnostics: Interdependence')
)

#### Save
ggsave(plot = plot_diagnostics_interdependence,
       filename = 'diagnostics-interdpendence.jpg', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)



### Interdependence as a predictor, Moral Injury symptoms as the outcome -------
diagnostics_mios_interdependence <-
  tibble(
    residuals = boot_fits_aparent$fits[[2]]$residuals,
    fits = boot_fits_aparent$fits[[2]]$fitted.values
  )

#### Normality (Histogram of residuals)
hist_diagnostics_mios_interdependence <-
diagnostics_mios_interdependence %>% 
  ggplot(aes(residuals)) +
  geom_histogram() +
  labs(x = 'Residuals', y = 'Count')

#### Linearity (Residual Dependence Plot)
linearity_diagnostics_mios_interdependence <-
diagnostics_mios_interdependence %>% 
  ggplot(aes(fits, residuals)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(x = 'Fitted Values', y = 'Residuals')

#### Homoskedasticity (SL Plot)
homosked_diagnostics_mios_interdependence <-
diagnostics_mios_interdependence%>% 
  mutate(abs_residuals = abs(residuals)) %>% 
  ggplot(aes(fits, abs_residuals)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(x = 'Fitted Values', y = 'Absolute Residuals')

#### All plots combined
(
plot_diagnostics_mios_interdependence <-
  hist_diagnostics_mios_interdependence +
  (linearity_diagnostics_mios_interdependence /
     homosked_diagnostics_mios_interdependence) +
    patchwork::plot_annotation(
      title = 'Model Diagnostics: Interdpendence on MIOS')
)

#### Save
ggsave(plot = plot_diagnostics_mios_interdependence,
       filename = 'diagnostics-mios-interdependence.jpg', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)



### Regard as the outcome ------------------------------------------------------
diagnostics_regard <-
  tibble(
    residuals = boot_fits_aparent$fits[[3]]$residuals,
    fits = boot_fits_aparent$fits[[3]]$fitted.values
  )

#### Normality (Histogram of residuals)
hist_diagnostics_regard <-
diagnostics_regard %>% 
  ggplot(aes(residuals)) +
  geom_histogram() +
  labs(x = 'Residuals', y = 'Count')

#### Linearity (Residual Dependence Plot)
linearity_diagnostics_regard <-
diagnostics_regard %>% 
  ggplot(aes(fits, residuals)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(x = 'Fitted Values', y = 'Residuals')

#### Homoskedasticity (SL Plot)
homosked_diagnostics_regard <-
diagnostics_regard %>% 
  mutate(abs_residuals = abs(residuals)) %>% 
  ggplot(aes(fits, abs_residuals)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(x = 'Fitted Values', y = 'Absolute Residuals')

#### All plots combined
(
plot_diagnostics_regard <-
  hist_diagnostics_regard +
  (linearity_diagnostics_regard /
     homosked_diagnostics_regard) +
    patchwork::plot_annotation(
      title = 'Model Diagnostics: Regard')
)

#### Save
ggsave(plot = plot_diagnostics_regard,
       filename = 'diagnostics-regard.jpg', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)



### Regard as a predictor, Moral Injury symptoms as the outcome ----------------
diagnostics_mios_regard <-
  tibble(
    residuals = boot_fits_aparent$fits[[4]]$residuals,
    fits = boot_fits_aparent$fits[[4]]$fitted.values
  )

#### Normality (Histogram of residuals)
hist_diagnostics_mios_regard <-
diagnostics_mios_regard %>% 
  ggplot(aes(residuals)) +
  geom_histogram() +
  labs(x = 'Residuals', y = 'Count')

#### Linearity (Residual Dependence Plot)
linearity_diagnostics_mios_regard <-
diagnostics_mios_regard %>% 
  ggplot(aes(fits, residuals)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(x = 'Fitted Values', y = 'Residuals')

#### Homoskedasticity (SL Plot)
homosked_diagnostics_mios_regard <-
diagnostics_mios_regard %>% 
  mutate(abs_residuals = abs(residuals)) %>% 
  ggplot(aes(fits, abs_residuals)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(x = 'Fitted Values', y = 'Absolute Residuals')

#### All plots combined
(
plot_diagnostics_mios_regard <-
  hist_diagnostics_mios_regard +
  (linearity_diagnostics_mios_regard /
     homosked_diagnostics_mios_regard) +
    patchwork::plot_annotation(
      title = 'Model Diagnostics: Regard on MIOS')
)

#### Save
ggsave(plot = plot_diagnostics_mios_regard,
       filename = 'diagnostics-mios-regard.jpg', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)
