# DESCRIPTIVE STATISTICS

## This script creates correlation tables, runs descriptives, 
## binds the results together, formats the table, then prints
## and saves a copy to a file. 


# Create Descriptive Table ------------------------------------------

descriptive_table <-
  data %>% 
  select(m2cq_mean,
         mios_total, 
         ptsd_positive_screen,
         biis_harmony) %>% 

  corrr::correlate() %>% 
  
  bind_cols(
    data %>% 
  select(m2cq_mean,
         mios_total, 
         ptsd_positive_screen,
         biis_harmony) %>% 
      psych::describe() %>% 
      tibble() %>% 
      select(mean, sd, skew, kurtosis) 
  ) %>%
  mutate(across(where(is.numeric), round, 2)) %>% 
  select(term, mean, sd, skew, kurtosis, everything()) %>% 
  rename(M = mean, 
         SD = sd, 
         Skew = skew, 
         Kurtosis = kurtosis,
         # Replace column names with numbers
         `1` = 6, `2` = 7, `3` = 8
  ) %>% 
  mutate(term = str_replace(term, 'm2cq_mean', 'Reintegration'),
         term = str_replace(term, 'ptsd_positive_screen', 'PTSD'),
         term = str_replace(term, 'mios_total', 'Moral Injury Symptoms'),
         term = str_replace(term, 'biis_harmony', 'Identity Dissonance')
  )
# Print:
descriptive_table

# Write file --------------------------------------------------------------
descriptive_table %>% write_csv(here::here('output/tables/descriptive-statistics.csv'))

# Remove variable from environment
rm(descriptive_table)





# Covariates --------------------------------------------------------------
data %>% 
  select(military_exp_combat,
         officer, 
         sex_male,
         military_family_none,
         race_white,
         discharge_reason,
         disability
  )

data %>% count(military_exp_combat) %>% mutate(perc = n / sum(n) * 100)
data %>% count(officer) %>% mutate(perc = n / sum(n) * 100)
data %>% count(sex_male) %>% mutate(perc = n / sum(n) * 100)
data %>% count(military_family_none) %>% mutate(perc = n / sum(n) * 100)
data %>% count(race_white) %>% mutate(perc = n / sum(n) * 100)
data %>% count(discharge_reason) %>% mutate(perc = n / sum(n) * 100)
data %>% count(disability) %>% mutate(perc = n / sum(n) * 100)
