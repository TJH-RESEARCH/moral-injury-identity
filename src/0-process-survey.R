
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
source(here::here('src/01_config/functions/function-calculate-longstring.R'))

### b. Apply Screeners -------------------------------------------------------

# Set cut offs

# Survey host flagged for removal
source(here::here('src/02_dataprep/7-screening/screen-survey-host.R'))

# Honeypot quesitons; Qualtrics bot metrics
source(here::here('src/02_dataprep/7-screening/screen-bots-dups.R'))

# Attention checks: 2 items
source(here::here('src/02_dataprep/7-screening/screen-attention-checks.R'))

# 1 validity check item; Inconsistencies across demographic items; Free response screening
source(here::here('src/02_dataprep/7-screening/screen-validity-checks.R'))

# Longstring by scale
## Straightlined the MIOS with score higher more than 0
## Straightlined the M2CQ with a score more than 0
# BIIS = 17 items total
# MCARM = 21 items - <19
# SCC = 12 items - <10
source(here::here('src/02_dataprep/7-screening/screen-longstring.R'))

# filter(evenodd < 0)
source(here::here('src/02_dataprep/7-screening/screen-evenodd.R'))

# psychsyn critval 0.76; psychant critval = -0.62; filter(psychsyn > 0)
source(here::here('src/02_dataprep/7-screening/screen-synant.R'))

## Set the cutoff - Three and a half standard deviations from the mean of the data:
source(here::here('src/02_dataprep/7-screening/screen-avgstring.R'))



### c. Save a table of survey exclusions and response time
source(here::here('src/04_appendix/survey-exclusions.R'))
source(here::here('src/04_appendix/response-time.R'))

### d. Remove functions
rm(calculate_longstring, select_scales, data_scales_reordered, reorder_data_scales, undo_reverse_codes)
   
## Finalize preparation: codebook, variable order -----------------------------
source(here::here('src/02_dataprep/update-codebook.R'))
source(here::here('src/02_dataprep/reorder-data.R'))

message("Survey processing complete.")


source(here::here('src/03_analysis/a-descriptive/sample-size.R'))


# ASSESS PSYCHOMETRICS ----------------------------------------------------
source(here::here('src/03_analysis/a-inferential/create-demographic-table.R'))


# DESCRIPTIVE ANALYSIS --------------------------------------------------------
source(here::here('src/03_analysis/a-descriptive/create-demographic-table.R'))

# INFERENTIAL ANALYSIS ----------------------------------------------------



