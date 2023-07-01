
# ANALYZE SURVEY

## Identity Wound


# Process Survey ----------------------------------------------------------
rm(list = ls())
source(here::here('src/02_dataprep/0-process-survey.R'))


# Determine what variable to include in the model --------------------
## 1. Draw DAGs
source(here::here('src/04_analysis/manuscript-identity-wound/1-draw-dags.R'))


# Display simple info on hypothesized relationships ---------------------------
## 2. Create Simple Table
source(here::here('src/04_analysis/manuscript-identity-wound/2-create-simple-table.R'))

## 3. Create Correlation Tables
source(here::here('src/04_analysis/manuscript-identity-wound/3-create-correlation-tables.R'))


# Check assumptions and transform data as needed ------------------------------

## 4. Check Assumptions
source(here::here('src/04_analysis/manuscript-identity-wound/4-check-assumptions.R'))

## 5. Remove Outliers
source(here::here('src/04_analysis/manuscript-identity-wound/5-remove-outliers.R'))

# Analyze -----------------------------------------------------------------

## 6. Run Regressions
source(here::here('src/04_analysis/manuscript-identity-wound/6-run-regressions.R'))

## 7. Check regression diagnostics
source(here::here('src/04_analysis/manuscript-identity-wound/7-regression-diagnostics.R'))

## 8. Permutation Testing
source(here::here('src/04_analysis/manuscript-identity-wound/8-permutation.R'))

## 9. Create Regression Tables
source(here::here('src/04_analysis/manuscript-identity-wound/9-create-regression-tables.R'))

## 10. Create Model Fit Tables
source(here::here('src/04_analysis/manuscript-identity-wound/10-create-model-fit-table.R'))


# Replicate ---------------------------------------------------------------

## 11. Replicate with Bayesian regression
source(here::here('src/04_analysis/manuscript-identity-wound/11-replicate-bayes.R'))


