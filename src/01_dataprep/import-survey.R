


# ------------------------------------------------------------ #


# Import Data --------------------------------------------------

data <- 
  readr::read_csv(
    here::here('data/raw/Dissertation_May 5, 2023_12.59.csv'), na = 'NA'
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


# Treat the multi-response questions as characters ------------------------
data <-
  data %>% 
    dplyr::mutate(
      branch = as.character(branch),
      employment =  as.character(employment),
      military_family = as.character(military_family),
      military_experiences = as.character(military_experiences),
      mios_event_type = as.character(mios_event_type),
      mios_ptsd_symptoms = as.character(mios_ptsd_symptoms),
      race = as.character(race),
      unmet_needs = as.character(unmet_needs),
    )


# Remove Responses that didn't pass initial screening questions ------------
data_screened_out <- 
  data %>% 
  filter(`Response Type` == "Screened Out")

data_no_consent <- 
  data %>% 
  filter(`Response Type` == "Did not consent")

data <- 
  data %>% 
  filter(`Response Type` == "Completed Survey")

# Assign a simple ID to each respondent -----------------------------------
data <- 
  data %>% 
  mutate(id = row_number())
