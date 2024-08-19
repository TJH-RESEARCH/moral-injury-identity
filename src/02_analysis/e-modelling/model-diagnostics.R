# ANALYZE REGRESSION DIAGNOSTICS -----------------------------------------------

### Extract lm objects from parsnip objects ------------------------------------
boot_fits_aparent <-
  boot_output %>% 
  filter(id == 'Apparent')

boot_fits_aparent$fits <-
  boot_fits_aparent$fits[1:nrow(boot_fits_aparent)] %>% 
  map(~ extract_fit_engine(.x))


## Check residuals of individual regressions -----------------------------------
library(ggfortify) ### "ggfortify lets ggplot2 know how to interpret lm objects." https://cran.r-project.org/web/packages/ggfortify/vignettes/plot_lm.html

### Interdependence as the outcome ---------------------------------------------
autoplot(
  boot_fits_aparent$fits[[1]],
  which = c(1:6),
  label.size = 3) + 
theme_bw()

## Save
ggsave(filename = 'diagnostics-interdependence.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)


### Interdependence as a predictor, Moral Injury symptoms as the outcome -------
autoplot(
  boot_fits_aparent$fits[[2]],
  which = c(1:6),
  label.size = 3) + 
  theme_bw()

## Save
ggsave(filename = 'diagnostics-moral-injury-interdependence.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)


### Regard as the outcome ------------------------------------------------------
autoplot(
  boot_fits_aparent$fits[[3]],
  which = c(1:6),
  label.size = 3) + 
  theme_bw()

## Save
ggsave(filename = 'diagnostics-regard.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)


### Regard as a predictor, Moral Injury symptoms as the outcome ----------------
autoplot(
  boot_fits_aparent$fits[[4]],
  which = c(1:6),
  label.size = 3) + 
  theme_bw()

## Save
ggsave(filename = 'diagnostics-moral-injury-regard.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)
