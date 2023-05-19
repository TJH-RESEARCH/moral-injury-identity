

# ------------------------------------------------------------ #
# Process the Survey data.


# Load Packages -----------------------------------------------------------
library(tidyverse)


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


# DATA SCREENING ----------------------------------------------------------
# Once the data is clearned, invalid and innattentive responses should be screened. This is an iterative process. 

# 7a. Calculate Validity
## Calculate indices of invalidity and inattentive or careless responding. 
source(here::here('src/02_dataprep/7a-calculate-validity.R'))

# 7b. Assess Validity
## Visualize and inspect inattention and invalidity
source(here::here('src/02_dataprep/7b-assess-validity.R'))

# 7c. Screen Responses
## Screen responses based on inclusion/exclusion and validity criteria
source(here::here('src/02_dataprep/7c-screen-responses.R'))

# 7d. Reassess Validity
## Visualize and inspect inattention and invalidity
source(here::here('src/02_dataprep/7d-reassess-validity.R'))




# INSPECT -----------------------------------------------------------------

glimpse(data)

## Skim
data %>% skimr::skim() 

# Update Codebook
## Add labels to the R variables to update the codebook.
source(here::here('src/02_dataprep/0-update-codebook.R'))

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



