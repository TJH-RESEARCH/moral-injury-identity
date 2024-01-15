
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
source(here::here('src/02_dataprep/7-screening/screen-survey-host.R'))
source(here::here('src/02_dataprep/7-screening/screen-bots-dups.R'))
source(here::here('src/02_dataprep/7-screening/screen-attention-checks.R'))
source(here::here('src/02_dataprep/7-screening/screen-validity-checks.R'))
source(here::here('src/02_dataprep/7-screening/screen-longstring.R'))
source(here::here('src/02_dataprep/7-screening/screen-evenodd.R'))
source(here::here('src/02_dataprep/7-screening/screen-synant.R'))
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


# DESCRIPTIVE ANALYSIS --------------------------------------------------------
source(here::here('src/03_analysis/a-descriptive/sample-size.R'))
source(here::here('src/03_analysis/a-descriptive/create-demographic-table.R'))

