
# ---------------------------------------------------------------------------- #
# Load Packages --------------------------------------------------------------
library(tidyverse)

# Import Data ----------------------------------------------------------------
data <- 
  readr::read_csv(
    here::here('data/raw/Dissertation_May 17, 2023_19.04.csv'), na = 'NA')

# Save the Labels ------------------------------------------------------------
labels <- tibble::tibble(variable = names(data), label = as.character(data[1,]))

# Remove meta-data rows ------------------------------------------------------
data <- data[3:nrow(data),]

# Data Types -----------------------------------------------------------------
## Write a temporary CSV and read the data back in with the correct types.
data %>% readr::write_csv(file = 'temp.csv')
data <- readr::read_csv(here::here('temp.csv'))
file.remove(here::here('temp.csv'))

# Re-label the data ----------------------------------------------------------
labelled::var_label(data) <- as.character(labels$label)
#rm(labels)

# Write a copy of the test data
currentDate <- Sys.Date()
data %>% 
  filter(DistributionChannel == 'test') %>% 
  readr::write_csv(file = here::here(paste('data/synthetic/synthetic-data_', currentDate, '.csv')))

# Write a copy of the full data set with labels
data %>% 
  readr::write_csv(file = here::here(paste('data/raw/full_data_', currentDate, '.csv')))
rm(currentDate)

# Retain Completed Surveys and Remove Tests ----------------------------------
data <-
  data %>% 
    filter(term == 'scrubbed') %>% 
    bind_rows(data %>% filter(`Response Type` == "Completed Survey"))

# ---------------------------------------------------------------------------- #