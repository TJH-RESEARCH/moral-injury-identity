
# Load Packages -----------------------------------------------------------
library(tidyverse)

# SET UP FOLDER --------------------------------------------------------
source(here::here('src/01_config/folder-structure.R'))

# DATA PREPARATION --------------------------------------------------------
#source(here::here('src/02_dataprep/0-process-survey.R'))
data <- readr::read_rds(here::here('data/processed/data-replication.rds'))

# DESCIPRTIVE  ----------------------------------------------------------------

## Sample Size
source(here::here('src/03_analysis/a-descriptive/sample-size.R'))

## Create Demographic Table
source(here::here('src/03_analysis/a-descriptive/c3-c4-create-demographic-table.R'))

## Internal Consistency
source(here::here('src/03_analysis/a-descriptive/internal-consistency.R'))

## Descriptive Statistics: Continuous
source(here::here('src/03_analysis/a-descriptive/c5-descriptive-continuous.R'))

## Descriptive Statistics: Categorical
source(here::here('src/03_analysis/a-descriptive/c6-descriptive-categorical.R'))

## Trauma Events
source(here::here('src/03_analysis/a-descriptive/trauma-events.R'))

## T-Test of Trauma Events
source(here::here('src/03_analysis/a-descriptive/t-test-mi-event.R'))


# VISUAL ANALYSIS -----------------------------------------------------------
source(here::here('src/03_analysis/b-visual/plot-reintegration.R'))
source(here::here('src/03_analysis/b-visual/plot-moral-injury.R'))
source(here::here('src/03_analysis/b-visual/plot-regression.R'))

# INFERENTIAL ANALYSIS ------------------------------------------------------

## Test Hypothesis 1: 
## Hierarchical Regression -------------------------------
source(here::here('src/03_analysis/c-inferential/c7-hypothesis-1.R'))

## Compare Models -------------------------------
source(here::here('src/03_analysis/c-inferential/c8-compare-models.R'))

## Calculate Effect -------------------------------
source(here::here('src/03_analysis/c-inferential/calculate-effect-f2.R'))

## Make Predictions -------------------------------
source(here::here('src/03_analysis/c-inferential/make-predictions.R'))

## Post-Hoc Regression by Sub Group: PTSD
source(here::here('src/03_analysis/c-inferential/group-balance-ptsd.R'))

## Test Hypothesis 2: 
## Mediation -------------------------------
source(here::here('src/03_analysis/c-inferential/c9-hypothesis-2.R'))

## Run Regression Diagnostics
source(here::here('src/03_analysis/c-inferential/regression-diagnostics.R'))

# APPENDIX ------------------------------------------------------------

## Create Population Demographic Table
source(here::here('src/04_appendix/c2-population-demographics.R'))

## Print and save session info
source(here::here('src/04_appendix/session-info.R'))

