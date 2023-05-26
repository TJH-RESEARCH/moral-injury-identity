

# ------------------------------------------------------------ #
# Process the Survey data.


# Load Packages -----------------------------------------------------------
library(tidyverse)

data_path <- here::here('data/raw/Dissertation_May 26, 2023_12.11 after Qualtrics scrub 3.csv')


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

# Screen Data
## Calculate indices of invalidity and inattentive or careless responding, then remove cases.
source(here::here('src/02_dataprep/screen-data.R'))

## View Exclusion Reasons
data_scrubbed_researcher %>% group_by(exclusion_reason) %>% count() %>% arrange(desc(n))
cut



# 7a. Calculate Validity
## Calculate indices of invalidity and inattentive or careless responding. 
source(here::here('src/02_dataprep/7a-calculate-validity.R'))

# 7b. Screen Responses
## Screen responses based on inclusion/exclusion and validity criteria
source(here::here('src/02_dataprep/7b-screen-responses.R'))
# 7c. Assess Validity
## Visualize and inspect inattention and invalidity
source(here::here('src/02_dataprep/7c-assess-validity.R'))

# Update Codebook
## Add labels to the R variables to update the codebook.
source(here::here('src/02_dataprep/0-update-codebook.R'))



# INSPECT -----------------------------------------------------------------

glimpse(data)

## Skim
data %>% skimr::skim() 


### Codebook
print(tibble::enframe(sjlabelled::get_label(data)), n = 500)

demographic_representation


# ADDITIONAL --------------------------------------------------------------

# 9. Check Representation 
## Check that sample is roughly representative of population demographics 
source(here::here('src/02_dataprep/check-representation.R'))

# Create Factors
# source(here::here('src/02_dataprep/create-factors.R'))

#exclusion_report$





# I had 159 that i kept
# qualtrics opened up for more. came back with 49 completed responses 
# that they did not scrub -- 208 total
# 210 show NA for term. 
# run that set through the screener, and 189 remain
# so 21 are cleaned, 40% of new scrubbed responses

# there was an error in the code. I wasn't filtering out avgstr correctly.... I am now but minimal difference
# now even more drop


# Starting with the data that includes new, not removed, scrubbed, and removed, 
## 296 cases goes to 197 (cut = 3) - 16 that Qualtrics scrubbed that I did not
## 296 cases goes to 184 (cut = 2.75) - 16 that Qualtrics scrubbed that I did not

# Starting with the responses that were retained and newly added,
## 210 goes to 178 (cut = 3)
## 210 goes to 166 (cut = 2.75)





# Data Removed in the first and second round but not in the third:
data_already_removed <- 
  readr::read_csv(here::here('data/processed/sent-to-qualtrics-2023-05-25.csv')) %>% 
  bind_rows(
    readr::read_csv(here::here('data/processed/sent-to-qualtrics_2023-05-22.csv'))
  ) %>% unique()

new_removals <- anti_join(data_scrubbed_researcher, data_already_removed, by = c('ResponseId' = 'ResponseId'))
not_removed <- anti_join(data_already_removed, data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId'))
 
# Data not yet sent to Qualtrics to remove:

anti_join(new_removals, data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId')) %>%
  select(ResponseId, exclusion_reason) %>%
  write_csv('data/processed/to-send-to-qualtrics-26-May-2023.csv')

