

# ------------------------------------------------------------ #
# Process the Survey data.


# Load Packages -----------------------------------------------------------
library(tidyverse)

data_path <- here::here('data/raw/data-raw.csv')


# DATA IMPORT -------------------------------------------------------------

# 1. Import Survey
## Import data, label the columns, and set data types
source(here::here('src/02_dataprep/1-import-survey.R'))

# 2. Rename Variables 
## Some column names are misspelled or misnamed, and dummy variables have generic names.
source(here::here('src/02_dataprep/2-rename-variables.R'))

# 3. Fix NAs
## Some NA values are coded as a number.
source(here::here('src/02_dataprep/3-fix-NAs.R'))

# 4. Reverse Code
## Reverse code the survey items.
source(here::here('src/02_dataprep/4-reverse-code.R'))

# 5. Calculate Variables
## Calculate new variables based on existing ones. Make variables factors.
source(here::here('src/02_dataprep/5-calculate-variables.R'))

# 6. Score Scales
## Calculate the sum score of scales and subscales
source(here::here('src/02_dataprep/6-score-scales.R'))

# DATA SCREENING -------------------------------------------------------- --
# Once the data is cleaned, invalid and innattentive responses should be screened. This is an iterative process. 

# 7. Screen Data
## Calculate indices of invalidity and inattentive or careless responding, then remove cases.
source(here::here('src/02_dataprep/7-screen-data.R'))

## View Exclusion Reasons
exclusions <-
  data_scrubbed_researcher %>% 
  group_by(exclusion_reason) %>% 
  count() %>% 
  arrange(desc(n))
exclusions
# Save a copy that includes the results scrubbed by Qualtrics
data <- anti_join(data, data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId'))

# Update Codebook
## Add labels to the R variables to update the codebook.
source(here::here('src/02_dataprep/0-update-codebook.R'))

# Reorder the data for further analysis
source(here::here('src/02_dataprep/reorder-data.R'))

rm(data_original, 
   data_scrubbed_both_research_qualtrics, 
   data_scrubbed_qualtrics,
   data_scrubbed_qualtrics_not_researcher,
   data_scrubbed_researcher,
   data_scrubbed_researcher_not_qualtrics,
   labels,
   labels_new,
   cut,
   longstring_cut)
