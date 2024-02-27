
# PROCESS SURVEY ----------------------------------------------------------

## Load Packages -----------------------------------------------------------
library(tidyverse)

## Import Data ----------------------------------------------------------
source(here::here('src/02_dataprep/1-import-survey.R'))

## Data Cleaning --------------------------------------------------------
source(here::here('src/02_dataprep/2-rename-variables.R'))
source(here::here('src/02_dataprep/3-fix-NAs.R'))
source(here::here('src/02_dataprep/4-reverse-code.R'))
source(here::here('src/02_dataprep/5-calculate-variables.R'))
source(here::here('src/02_dataprep/6-score-scales.R'))

## Data Screening -------------------------------------------------------------
### a. Load Functions ---------------------------------------------------------
source(here::here('src/01_config/functions/function-select-scales.R'))
source(here::here('src/01_config/functions/function-reorder-data.R'))
source(here::here('src/01_config/functions/function-undo-reverse-codes.R'))
source(here::here('src/01_config/functions/function-screen-longstring.R'))
source(here::here('src/01_config/functions/function-update-exclusions.R'))


### b. Apply Screeners -------------------------------------------------------
source(here::here('src/02_dataprep/7-screening/screen-survey-host.R'))
source(here::here('src/02_dataprep/7-screening/screen-bots-dups.R'))
source(here::here('src/02_dataprep/7-screening/screen-validity-checks.R'))

source(here::here('src/02_dataprep/7-screening/screen-attention-checks.R'))
source(here::here('src/02_dataprep/7-screening/screen-longstring.R'))
source(here::here('src/02_dataprep/7-screening/screen-evenodd.R'))
source(here::here('src/02_dataprep/7-screening/screen-synant.R'))
source(here::here('src/02_dataprep/7-screening/screen-avgstring.R'))

### c. Save the data and exclusion reasons
source(here::here('src/02_dataprep/7-screening/save-datasets.R'))
source(here::here('src/02_dataprep/7-screening/save-exclusion-reasons.R'))
source(here::here('src/04_appendix/survey-exclusions.R'))

### d. Clean functions from environemnt
rm(select_scales, calculate_longstring, reorder_data, undo_reverse_codes, update_exclusions, screen_longstring, calculate_evenodd)
   
## Finalize preparation: codebook, variable order -----------------------------
#source(here::here('src/02_dataprep/update-codebook.R'))
source(here::here('src/02_dataprep/reorder-data.R'))

message("Survey processing complete.")


# MAIN ANALYSIS -----------------------------------------------------------
data_original <- data
data <- data_original %>% filter(dataset_main == 1)
#data <- data_original %>% filter(dataset_lenient == 1)
#data <- data_original %>% filter(dataset_strict == 1)
#data <- data_original %>% filter(dataset_simple == 1)

# DESCRIBE SAMPLE ----------------------------------------------------------
source(here::here('src/03_analysis/a-describe-sample/sample-size.R'))
source(here::here('src/03_analysis/a-describe-sample/response-time.R'))
source(here::here('src/03_analysis/a-describe-sample/demographics.R'))
source(here::here('src/03_analysis/a-describe-sample/military-demographics.R'))


# EXAMINE VARIALES --------------------------------------------------------
## Assess Psychometrics
source(here::here('src/03_analysis/b-examine-variables/assess-psychometrics.R'))

## Descriptive Statistics
source(here::here('src/03_analysis/b-examine-variables/descriptive-categorical.R'))
source(here::here('src/03_analysis/b-examine-variables/descriptive-continuous.R'))

## Univariate Analysis
source(here::here('src/03_analysis/b-examine-variables/plot-identity-dissonance.R'))

## Bivariate Analysis
source(here::here('src/03_analysis/b-examine-variables/visualize-pairs.R'))

## Visualize Hypotheses
source(here::here('src/03_analysis/b-examine-variables/visualize-hypothesis.R'))


# SPECIFY MODELS ----------------------------------------------------
source(here::here('src/03_analysis/c-modelling/dags.Rmd'))
source(here::here('src/03_analysis/c-modelling/fit-models.R'))
source(here::here('src/03_analysis/c-modelling/model-diagnostics.R'))
source(here::here('src/03_analysis/c-modelling/calculate-robust-se.R'))
source(here::here('src/03_analysis/c-modelling/save-model-results.R'))


# INTERPRET MODELS --------------------------------------------------------
source(here::here('src/03_analysis/d-interpret-reults/make-results-tables.R'))
source(here::here('src/03_analysis/d-interpret-reults/visualize-results.R'))


# ROBUSTNESS --------------------------------------------------------------

## Are results robust to subgroup of only those who report a critical incident?
## Are results robust to other forms of military identity?
## Are results robust to other operationalization of identity dissonance?
## Are results robust to different exclusion cut-offs? 
##     i.e., different versions of the data set  



source(here::here('src/03_analysis/e-robustness/multiverse-analysis.R'))



