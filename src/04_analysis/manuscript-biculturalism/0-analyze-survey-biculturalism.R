
# ANALYZE SURVEY
# Military-Civilian Biculturalism?: 
# Bicultural Identity and the Adjustment of Separated Service Members


## 0. Process Survey ---------------------------------------------------------
source(here::here('src/02_dataprep/0-process-survey.R'))

## 1. Draw DAGs --------------------------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/1-draw-dags'))

## 2. Create Simple Table ----------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/2-create-simple-table.R'))

## 3. Create Correlation Table ----------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/2-create-correlation-table.R'))

## 4. Check Assumptions ------------------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/3-check-assumptions.R'))

## 5. Run Regressions --------------------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/4-run-regressions.R'))

## 6. Check Regression Diagnostics -------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/5-regression-diagnostics.R'))

## 7. Permutation Testing ----------------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/6-check-permutation.R'))

## 8. Create Regression Tables -----------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/7-create-regression-tables.R'))

## 9. Create Model Fit Tables ------------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/8-create-model-fot-table.R'))

## 10. Repeat with Bayesian methods -------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/9-replicate-bayes.R'))


