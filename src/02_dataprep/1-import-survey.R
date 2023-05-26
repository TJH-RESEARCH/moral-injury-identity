
# ---------------------------------------------------------------------------- #
# Load Packages --------------------------------------------------------------
library(tidyverse)

# Import Data ----------------------------------------------------------------

data <- 
  readr::read_csv(data_path, na = 'NA')
rm(data_path)

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
data %>% filter(Progress < 100)

# Survey ended early
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

# Qualtrics Scrubbed
data %>% 
  filter(Progress == 100,
         term == 'Scrubbed' |
         term == 'Scrubbed Out' |
         term == 'scrubbed'
         ) %>% 
  group_by(term) %>% 
  count() %>% 
  arrange(desc(n))


# Previously Removed
data %>% 
  filter(Progress == 100,
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
         ) %>% 
  group_by(term) %>% 
  count() %>% 
  arrange(desc(n))

# Retained Results
data %>% 
  filter(Progress == 100,
         is.na(term)
  ) %>% 
  group_by(term) %>% 
  count()

# Retained and Previously Removed Results
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
  ) %>% 
  group_by(term) %>% 
  count() %>% 
  arrange(desc(n))

# Save a copy of retained and previously removed
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


# ---------------------------------------------------------------------------- #
