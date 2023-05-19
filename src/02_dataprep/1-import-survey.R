
# ------------------------------------------------------------ #
library(tidyverse)


# Import Data --------------------------------------------------
data <- 
  readr::read_csv(
    here::here('data/raw/Dissertation_May 17, 2023_19.04.csv'), na = 'NA'
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

exclusion_report <- list()

exclusion_report$tests <-
  data %>% 
  group_by(DistributionChannel) %>% 
  count()
             
exclusion_report$screened <-
  data %>% 
  filter(DistributionChannel != 'test') %>% 
  group_by(term) %>% 
  rename(`Exclusion Reason` = term) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100)

exclusion_report$finished <-
  data %>% 
  filter(DistributionChannel != 'test', is.na(term)) %>% 
  group_by(Finished) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100)


# Filter Data -------------------------------------------------------------

exclusion_report$data_synthetic <- 
  data %>% 
  filter(DistributionChannel == 'test')

#data_synthetic %>% readr::write_csv(file = here::here('data/synthetic/synthetic-data.csv'))
#rm(data_synthetic)

exclusion_report$data_screened_out <- 
  data %>% 
  filter(DistributionChannel != 'test') %>% 
  filter(`Response Type` == "Screened Out" & term != 'scrubbed')

exclusion_report$data_scrubbed_qualtrics <- 
  data %>% 
  filter(DistributionChannel != 'test') %>% 
  filter(term == 'scrubbed')


exclusion_report$data_no_consent <- 
  data %>% 
  filter(DistributionChannel != 'test') %>% 
  filter(`Response Type` == "Did not consent")


# -------------------------------------------------------------------------
data <- 
  data %>% 
  filter(DistributionChannel != 'test', 
         is.na(term), 
         `Response Type` == 'Completed Survey') %>% 
  bind_rows(exclusion_report$data_scrubbed_qualtrics)


# Assign a simple ID to each respondent -----------------------------------
data <- 
  data %>% 
  mutate(id = row_number())



#data_mis <- anti_join(data_scrubbed, data, by = c("ResponseId" = 
#                                                  "ResponseId"))



