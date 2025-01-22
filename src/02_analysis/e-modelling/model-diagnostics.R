# ANALYZE REGRESSION DIAGNOSTICS -----------------------------------------------

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
diagnostics_interdependence %>% 
  ggplot(aes(residuals)) +
  geom_histogram()

#### Linearity (Residual Dependence Plot)
diagnostics_interdependence %>% 
  ggplot(aes(fits, residuals)) +
  geom_point() +
  geom_smooth(method = 'lm')

#### Homoskedasticity (SL Plot)
diagnostics_interdependence %>% 
  mutate(abs_residuals = abs(residuals)) %>% 
  ggplot(aes(fits, abs_residuals)) +
  geom_point() +
  geom_smooth(method = 'lm')






### Interdependence as a predictor, Moral Injury symptoms as the outcome -------
diagnostics_mios_interdependence <-
  tibble(
    residuals = boot_fits_aparent$fits[[2]]$residuals,
    fits = boot_fits_aparent$fits[[2]]$fitted.values
  )

#### Normality (Histogram of residuals)
diagnostics_mios_interdependence %>% 
  ggplot(aes(residuals)) +
  geom_histogram()

#### Linearity (Residual Dependence Plot)
diagnostics_mios_interdependence %>% 
  ggplot(aes(fits, residuals)) +
  geom_point() +
  geom_smooth(method = 'lm')

#### Homoskedasticity (SL Plot)
diagnostics_mios_interdependence %>% 
  mutate(abs_residuals = abs(residuals)) %>% 
  ggplot(aes(fits, abs_residuals)) +
  geom_point() +
  geom_smooth(method = 'lm')



### Regard as the outcome ------------------------------------------------------
diagnostics_regard <-
  tibble(
    residuals = boot_fits_aparent$fits[[3]]$residuals,
    fits = boot_fits_aparent$fits[[3]]$fitted.values
  )

#### Normality (Histogram of residuals)
diagnostics_regard %>% 
  ggplot(aes(residuals)) +
  geom_histogram()

#### Linearity (Residual Dependence Plot)
diagnostics_regard %>% 
  ggplot(aes(fits, residuals)) +
  geom_point() +
  geom_smooth(method = 'lm')

#### Homoskedasticity (SL Plot)
diagnostics_regard %>% 
  mutate(abs_residuals = abs(residuals)) %>% 
  ggplot(aes(fits, abs_residuals)) +
  geom_point() +
  geom_smooth(method = 'lm')


### Regard as a predictor, Moral Injury symptoms as the outcome ----------------
diagnostics_mios_regard <-
  tibble(
    residuals = boot_fits_aparent$fits[[4]]$residuals,
    fits = boot_fits_aparent$fits[[4]]$fitted.values
  )

#### Normality (Histogram of residuals)
diagnostics_mios_regard %>% 
  ggplot(aes(residuals)) +
  geom_histogram()

#### Linearity (Residual Dependence Plot)
diagnostics_mios_regard %>% 
  ggplot(aes(fits, residuals)) +
  geom_point() +
  geom_smooth(method = 'lm')

#### Homoskedasticity (SL Plot)
diagnostics_mios_regard %>% 
  mutate(abs_residuals = abs(residuals)) %>% 
  ggplot(aes(fits, abs_residuals)) +
  geom_point() +
  geom_smooth(method = 'lm')
