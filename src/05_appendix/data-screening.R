

# Appendix ------------------------------------------------------------------#

library(tidyverse)
library(kableExtra)

# Import Data ----------------------------------------------------------------
data <- 
  readr::read_csv(
    here::here('data/raw/full_data_ 2023-05-20 .csv'))

# Initial Screening Reason --------------------------------------------------------
data %>% 
  filter(DistributionChannel != 'test') %>%
  group_by(term) %>% 
  rename(`Exclusion Reason` = term) %>% 
  filter(!is.na(`Exclusion Reason`)) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100) %>% 
  arrange(desc(percent))

# Full Report: Initial Screening ------------------------------------------
data %>% 
  group_by(`Response Type`, DistributionChannel, term) %>% count()

# Distribution Channel  ---------------------------------------------------
data %>% 
  group_by(DistributionChannel) %>% 
  count()

# Incomplete Responses ----------------------------------------------------
data %>% 
  filter(DistributionChannel != 'test', is.na(term)) %>% 
  group_by(Finished) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100) %>% 
  arrange(desc(percent))

