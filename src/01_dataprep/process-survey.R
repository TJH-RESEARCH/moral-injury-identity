

# ------------------------------------------------------------ #

# Process the Survey data.

# Load Packages -----------------------------------------------------------
library(tidyverse)



# 1. Import Survey
## Import Data, Label the Columns, and Set Data Types
source(here::here('src/01_dataprep/import-survey.R'))


# 2a. Rename Variables 
## Some column names are misspelled or misnamed
source(here::here('src/01_dataprep/rename-variables.R'))

# 2b. Fix Codes
## Some variables are not coded as expected
source(here::here('src/01_dataprep/fix-codes.R'))

# 2c. Reverse Code
## Reverse code the survey items
source(here::here('src/01_dataprep/reverse-code.R'))

# 2d. Fix NAs
## Some NA values are coded as a number
source(here::here('src/01_dataprep/fix-NAs.R'))

# 3. Calculate Variables
## Calculate new variables
source(here::here('src/01_dataprep/calculate-variables.R'))

# 4. Score Scales
## Calculate the sum score of scales and subscales
source(here::here('src/01_dataprep/score-scales.R'))

# 5. Create Factors
source(here::here('src/01_dataprep/create-factors.R'))

# Assess inattention and validity
## run the statistical screeners

# 6a. Assess inattention. 
## Calculate indices of inattentive or careless responding. 
## Calcuate validity and inattention variables.
source(here::here('src/01_dataprep/assess-inattention.R'))

# 6c. Screen Responses
## Based on inclusion/exclusion, validity criteria
source(here::here('src/01_dataprep/screen-responses.R'))


# 7. Check Representation 
## Check that sample is roughly representative of population demographics 
source(here::here('src/01_dataprep/check-representation.R'))

# Update Codebook
## Add labels to the R variables to update the codebook.
source(here::here('src/01_dataprep/update-codebook.R'))

### Codebook
print(tibble::enframe(sjlabelled::get_label(data)), n = 500)



# Inspect -----------------------------------------------------------------
glimpse(data)

## Skim
data %>% skimr::skim() 



demographic_representation














