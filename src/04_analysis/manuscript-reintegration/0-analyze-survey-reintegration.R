
# ANALYZE SURVEY


## 0. Process Survey ---------------------------------------------------------
source(here::here('src/02_dataprep/0-process-survey.R'))

## 1. Draw DAGs --------------------------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/1-draw-dags'))

## 2. Create Simple Table ----------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/2-create-simple-table.R'))

## 3. Create Correlation Table ----------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/3-create-correlation-table.R'))

## 4. Check Assumptions ------------------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/4-check-assumptions.R'))

## 5. Remove Outliers
source(here::here('src/04_analysis/manuscript-reintegration/5-remove-outliers.R'))

## 6. Transform Variables
source(here::here('src/04_analysis/manuscript-reintegration/6-transform-variables.R'))

## 7. Run Regressions --------------------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/7-sem'))

## 8. Check Regression Diagnostics -------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/8-regression-diagnostics.R'))

## 9. Permutation Testing ----------------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/9-check-permutation.R'))

## 10. Create Regression Tables -----------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/10-create-regression-tables.R'))

## 11. Create Model Fit Tables ------------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/11-create-model-fot-table.R'))

## 12. Repeat with Bayesian methods -------------------------------------------
source(here::here('src/04_analysis/manuscript-reintegration/12-replicate-bayes.R'))


