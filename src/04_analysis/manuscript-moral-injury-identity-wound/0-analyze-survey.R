
# ANALYZE SURVEY


# Hypotheses --------------------------------------------------------------


# Make some simple tables and graphs


# Determine what variable to include in the model --------------------
## Draw DAGs
source(here::here('src/04_analysis/manuscript-1/draw-dags.R'))

## Create Correlation Tables
source(here::here('src/04_analysis/manuscript-1/create-correlation-tables.R'))

# Check assumptions and transform data as needed ----------------------
## Create Demographic Tables
source(here::here('src/04_analysis/manuscript-1/create-demographic-table.R'))

## Check Assumptions
source(here::here('src/04_analysis/manuscript-1/check-assumptions.R'))

## Transform Variables
source(here::here('src/04_analysis/manuscript-1/transform-variables.R'))

## Remove Outliers
source(here::here('src/04_analysis/manuscript-1/remove-outliers.R'))


# Analyze -----------------------------------------------------------------

## Run Regressions
source(here::here('src/04_analysis/manuscript-1/run-regressions.R'))

## Check regression diagnostics
source(here::here('src/04_analysis/manuscript-1/regression-diagnostics.R'))

## Create Regression Tables
source(here::here('src/04_analysis/manuscript-1/create-correlation-tables.R'))

## Permutation Testing
source(here::here('src/04_analysis/manuscript-1/check-permutation.R'))

# Replicate ---------------------------------------------------------------

## Replicate with Bayesian regression
source(here::here('src/04_analysis/manuscript-1/replicate-bayes.R'))


