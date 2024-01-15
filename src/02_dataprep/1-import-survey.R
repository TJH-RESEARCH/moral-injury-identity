
# ---------------------------------------------------------------------------- #
# Load Packages --------------------------------------------------------------
library(tidyverse)

# Import Data ----------------------------------------------------------------

data <- 
  readr::read_csv(here::here('data/raw/data-raw.csv'), na = 'NA')

# Save the Labels ------------------------------------------------------------
labels <- tibble::tibble(variable = names(data), label = as.character(data[1,]))

# Remove meta-data rows ------------------------------------------------------
data <- data[3:nrow(data),]

# Data Types -----------------------------------------------------------------
## Write a temporary CSV and read the data back in with the correct types.
data %>% readr::write_csv(file = here::here('data/temp.csv'))
data <- readr::read_csv(here::here('data/temp.csv'))
file.remove(here::here('data/temp.csv'))

# Re-label the data ----------------------------------------------------------
labelled::var_label(data) <- as.character(labels$label)

# Remove test responses ----------------------------------
data <- 
  data %>% 
  filter(DistributionChannel != 'test')

# -------------------------------------------------------------------------

data %>% 
  filter(Progress == 100) %>% 
  group_by(term) %>% 
  count()

# Incomplete responses.
data %>% filter(Progress < 100) %>% print()

# Survey ended early
screened_out_reasons <-
  data %>% 
  filter(Progress == 100,
           term == 'air force warrant ' |
           term == 'attention check' |
           term == 'consent' |
           term == 'high rank' |
           term == 'never in military' |
           term == 'not separated' |
           term == 'under 18' |
           term == 'validity check'
           ) %>% 
  group_by(term) %>% 
  count() %>% 
  arrange(desc(n))

screened_out_reasons %>% print()
screened_out_reasons %>% write_csv('output/screened_out_reasons.csv')


# Save a copy of retained results, including those labeled for removal during the first and second stage of data collection 
data <-
  data %>% 
  filter(Progress == 100,
         is.na(term) |
         term == 'Average String' |
         term == 'Even odd inconsistency' |
         term == 'Failed bot check' |
         term == 'Failed validity check' |
         term == 'Multivariate Outlier' |
         term == 'Other inconsistency or improbability' |
         term == 'Psychometric synonym/antonym inconsistency' |
         term == 'Straightlining' |
         term == 'Scrubbed' |
         term == 'Scrubbed Out' |
         term == 'scrubbed'
  )

# Save a copy of the Retained Results
#data <-
  data %>% 
  filter(Progress == 100,
         is.na(term)
  )

if(exists('data')) message('Survey data imported')
  
  
rm(screened_out_reasons)

# ---------------------------------------------------------------------------- #
