
# ------------------------------------------------------------ #
library(tidyverse)


# Import Data --------------------------------------------------
data <- 
  readr::read_csv(
    here::here('data/raw/Dissertation_May 9, 2023_17.49.csv'), na = 'NA'
  )



# Save the Labels -------------------------------------------------------------------

labels <- 
  tibble(
    variable = names(data), 
    label = as.character(data[1,])
  )

#print(tibble::enframe(sjlabelled::get_label(data)), n = 500)


# Remove meta-data rows --------------------------------------------------
data <- data[3:nrow(data),]


# Data Types -----------------------------------------------------------------

## The meta-data rows mess up the data types. Having removed them above, 
## now I write a temporary CSV and read the data back in with the correct types.

data %>% write_csv(file = 'temp.csv')
data <- readr::read_csv(here::here('temp.csv'))
file.remove(here::here('temp.csv'))


# Re-label the data -------------------------------------------------------
labelled::var_label(data) <- as.character(labels$label)
#rm(labels)


# Remove Responses that didn't pass initial screening questions ------------
data_synthetic <- 
  data %>% 
  filter(`Status` == 2)

data_synthetic %>% readr::write_csv(file = here::here('data/synthetic/synthetic-data.csv'))
rm(data_synthetic)

data_screened_out <- 
  data %>% 
  filter(`Status` == 0) %>% 
  filter(`Response Type` == "Screened Out")

data_no_consent <- 
  data %>% 
  filter(`Status` == 0) %>% 
  filter(`Response Type` == "Did not consent")

data <- 
  data %>% 
  filter(`Status` == 0) %>% 
  filter(`Response Type` == "Completed Survey")

# Assign a simple ID to each respondent -----------------------------------
data <- 
  data %>% 
  mutate(id = row_number())
