
# ANALYZE REGRESSION DIAGNOSTICS

## Extract models for original data set
boot_model_extracts_apparent <-
  boot_model_extracts %>% 
  filter(id == 'Apparent')


## Check residuals of individual regressions.
library(ggfortify) ### "ggfortify lets ggplot2 know how to interpret lm objects." https://cran.r-project.org/web/packages/ggfortify/vignettes/plot_lm.html

### Interdependence as the outcome
autoplot(
  boot_model_extracts_apparent$extracts[[1]],
  which = c(1:6),
  label.size = 3) + 
theme_bw()


### Interdependence as a predictor, Moral Injury symptoms as the outcome
autoplot(
  boot_model_extracts_apparent$extracts[[2]],
  which = c(1:6),
  label.size = 3) + 
  theme_bw()


### Regard as the outcome
autoplot(
  boot_model_extracts_apparent$extracts[[3]],
  which = c(1:6),
  label.size = 3) + 
  theme_bw()


### Regard as a predictor, Moral Injury symptoms as the outcome
autoplot(
  boot_model_extracts_apparent$extracts[[4]],
  which = c(1:6),
  label.size = 3) + 
  theme_bw()
