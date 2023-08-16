



# DATA PREPARATION --------------------------------------------------------
source(here::here('src/02_dataprep/0-process-survey.R'))


# ANALYSIS ----------------------------------------------------------------

## Create Demographic Table
source(here::here('src/03_analysis/1-create-demographic-table.R'))

## Internal Consistency
source(here::here('src/03_analysis/2-internal-consistency.R'))

## Descriptive Statistics
source(here::here('src/03_analysis/3-discriptive-statistics.R'))

## Test Hypothesis 1
source(here::here('src/03_analysis/4-hypothesis-1.R'))

## Test Hypothesis 2
source(here::here('src/03_analysis/5-hypothesis-2.R'))

## Run Regression Diagnostics
source(here::here('src/03_analysis/6-hypothesis-2.R'))

# APPENDIX ------------------------------------------------------------

## Create Population Demographic Table
source(here::here('src/04_appendix/population-demographics.R'))
