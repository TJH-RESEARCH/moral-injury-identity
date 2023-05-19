

# Create visualizations ---------------------------------------------------

## Load packages 
library(patchwork)

data_original <- exclusion_report$data_original


# Visualize ---------------------------------------------------------------

## Psychometric Synonyms/Antonyms
psych_scatter <-
  data %>% 
  ggplot2::ggplot(aes(x = psychant, 
                      y = psychsyn)) +
  geom_text(aes(label = id)) +
  labs(title = 'Cleaned: Psychological Synonym and Antonym Correlations') +
  lims(x = c(-1, 0), y = c(0, 1))

psychsyn_box <-
  data %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_boxplot() +
  labs(title = 'Cleaned: Psychological Synonym Correlation') +
  lims(x = c(-0.5, 1))

psychsyn_hist <-
  data %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_histogram() +
  lims(x = c(-.5, 1))

psychant_box <-
  data %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_boxplot() +
  labs(title = 'Cleaned: Psychological Antonym Correlation') +
  lims(x = c(-1, 0.5))

psychant_hist <-
  data %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_histogram() +
  lims(x = c(-1, 0.5))

## Duration

duration_box <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_boxplot() +
  lims(x = c(0, 50)) +
  labs(title = 'Cleaned: Duration')

duration_hist <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_histogram() +
  lims(x = c(0, 50))


## Even-Odd Consistency

evenodd_box <-
  data %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_boxplot() +
  labs(title = 'Cleaned: Even-Odd Consistency') +
  lims(x = c(-1, 0))

evenodd_hist <-
  data %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_histogram() +
  labs(title = '') +
  lims(x = c(-1, 0))


# Visualize for screened responses ----------------------------------------


## Psychometric Synonyms/Antonyms
psych_scatter_original <-
  data_original %>% 
  ggplot2::ggplot(aes(x = psychant, 
                      y = psychsyn)) +
  geom_text(aes(label = id)) +
  labs(title = 'Original: Psychological Synonym and Antonym Correlations') +
  lims(x = c(-1, 0), y = c(0, 1))

psychsyn_box_original <-
  data_original %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_boxplot() +
  labs(title = 'Original: Psychological Synonym Correlation') +
  lims(x = c(-0.5, 1))

psychsyn_hist_original <-
  data_original %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_histogram() +
  lims(x = c(-0.5, 1))

psychant_box_original <-
  data_original %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_boxplot() +
  labs(title = 'Original: Psychological Antonym Correlation') +
  lims(x = c(-1, 0.5))

psychant_hist_original <-
  data_original %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_histogram() +
  lims(x = c(-1, 0.5))

## Duration

duration_box_original <-
  data_original %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_boxplot() +
  labs(title = 'Original: Duration') +
  lims(x = c(0, 50))

duration_hist_original <-
  data_original %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_histogram() +
  lims(x = c(0, 50))


## Even-Odd Consistency

evenodd_box_original <-
  data_original %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_boxplot() +
  labs(title = 'Original: Even-Odd Consistency') +
  lims(x = c(-1, 0))

evenodd_hist_original <-
  data_original %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_histogram() +
  labs(title = '') +
  lims(x = c(-1, 0))


# Plot -------------------------------------------------------------------------


(psychsyn_box + psychsyn_hist) / (psychsyn_box_original + psychsyn_hist_original) / 
(psychant_box + psychant_hist) / (psychant_box_original + psychant_hist_original)

psych_scatter / psych_scatter_original

(duration_box + duration_hist) / (duration_box_original + duration_hist_original)

(evenodd_box + evenodd_hist) / (evenodd_box_original + evenodd_hist_original)


rm(psychsyn_box, psychsyn_hist, psychant_box, psychant_hist, 
   psych_scatter, duration_box, duration_hist, evenodd_box, 
   evenodd_hist, psychsyn_box_original, psych_scatter_original,
   psychsyn_hist_original, psychant_box_original, psychant_hist_original,
   duration_box_original, duration_hist_original, evenodd_box_original,
   evenodd_hist_original)

# Validate ----------------------------------------------------------------


## Confront the data
quality_check <- validate::confront(data, validity_rules)

## Visualize the validity criteria 
validation_summary <- validate::summary(quality_check)
validation_plot <- validate::plot(quality_check, xlab = "")

validation_summary
validation_plot

## Check individual records
validate::aggregate(quality_check, by="record")


## Save the new validity score
### Note, some records may fail checks they previously passed.
### These checks are based on mean and standard deviation which
### will change (and by definition, become more restrictive)
### as data is screened out. 
### As you repeat the screening algorithm, the dataset shrinks.

data <- 
  validate::aggregate(quality_check, by="record") %>%
    tibble() %>% 
    bind_cols(data) %>% 
    rename(validity_npass_2 = npass,
           validity_nfail_2 = nfail,
           validity_nNA_2 = nNA,
           validity_rel_pass_2 = rel.pass,
           validity_rel_fail_2 = rel.fail,
           validity_rel_NA_2 = rel.NA
           ) %>% 
    select(id, everything())




# print MOS to check manually ---------------------------------------------

data %>% 
  select(ResponseId, mos, branch, years_service, years_separation) %>% 
  print(n = nrow(data))


## Flag:
# R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
# 141 Commissioned Officer, Navy, 27 years service, 39 years separated
# 171 do not recall, Army, 6, 47
# 177 Atomic Demolition, Army, 3, 58
# 



# Inspect the improbable answers ------------------------------------------


# Improbably fast rank achievement
data %>% 
  filter(highest_rank == 'E-7 to E-9') %>% 
  select(ResponseId, years_service) %>% 
  arrange(years_service) %>% 
  print(n = nrow(data))
## flag: R_333yrSOKhrqsI5N, 4 years service


# Improbable_Age_Child = if(years_of_age < 40) military_family_child == 0,
data %>% 
  filter(military_family_child == 1) %>% 
  select(ResponseId, years_of_age) %>%
  arrange(years_of_age) %>% 
  print(n = nrow(data))
## Flag: 


# Improbable_Age_Education         = if(education == 'doctorate') years_of_age > 30,
data %>% 
  filter(education == 'Doctorate') %>% 
  select(ResponseId, years_of_age, education) %>%
  arrange(years_of_age) %>% 
  print(n = nrow(data))
## Flag: R_rcI2ky4GMLfDtKh, 23 year old doctorate


data %>% 
  filter(education == 'Applied or professional doctorate') %>% 
  select(ResponseId, years_of_age, education) %>%
  arrange(years_of_age) %>% 
  print(n = nrow(data))
## Flag: 


# validity years
data %>% 
  select(ResponseId, 
         validity_years, 
         year_entered_military, 
         year_left_military, 
         age_enlisted,
         age_separated,
         years_service,
         years_separation) %>%
  arrange(validity_years) %>% 
  print(n = nrow(data))


## Flag: R_12rO13rLswQQlH3, enlisted at age 62.



# Screen Out Inconsistent/Improbable -----------------------------------------------------------------


data_original <- data
data <-
  data %>% 
    filter(ResponseId != 'R_333yrSOKhrqsI5N' &   # R_333yrSOKhrqsI5N E-7 to E-9 and only 4 years service
           ResponseId != 'R_rcI2ky4GMLfDtKh' &   # R_rcI2ky4GMLfDtKh 23 year-old phd
           ResponseId != 'R_DIuctUzEpM5pXQR' &   # R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
           ResponseId != 'R_12rO13rLswQQlH3' &   # R_12rO13rLswQQlH3 enlisted when he was 62.
           ResponseId != 'R_3qwzDFSzxJtD1S8' &   # R_3qwzDFSzxJtD1S8 1990 years of service
           ResponseId != 'R_2pLztPsOtJp3tqx' &   # R_2pLztPsOtJp3tqx -8 validity years 
           ResponseId != 'R_2dF3KxaBBb1DC7J')    # R_2dF3KxaBBb1DC7J -8 validity years

exclusion_report$data_scrubbed_researcher <- bind_rows(anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')),  exclusion_report$data_scrubbed_researcher)
rm(data_original)

# Test Difference between scrubbed at not ---------------------------------


exclusion_report$scrubbed_researcher_not_qualtrics <- anti_join(exclusion_report$data_scrubbed_researcher, exclusion_report$data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId'))
exclusion_report$scrubbed_qualtrics_not_researcher <- anti_join(exclusion_report$data_scrubbed_qualtrics, exclusion_report$data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId'))

nrow(exclusion_report$data_scrubbed_researcher)
nrow(exclusion_report$data_scrubbed_qualtrics)
nrow(exclusion_report$scrubbed_researcher_not_qualtrics)
nrow(exclusion_report$scrubbed_qualtrics_not_researcher)


#exclusion_report$scrubbed_researcher_not_qualtrics %>% 
  #select(ResponseId) %>% 
  #write_csv(file = here::here('data/processed/to_scrub_May 18, 2023.csv'))


# Is scrubbed data that much different from the sample? -------------------

t.test(data$mios_total, exclusion_report$data_scrubbed_researcher$mios_total)
t.test(data$mcarm_total, exclusion_report$data_scrubbed_researcher$mcarm_total)
t.test(data$biis_total, exclusion_report$data_scrubbed_researcher$biis_total)
t.test(data$longstr_no_reverse, exclusion_report$data_scrubbed_researcher$longstr_no_reverse)
t.test(data$longstr_reverse, exclusion_report$data_scrubbed_researcher$longstr_reverse)
t.test(data$psychant, exclusion_report$data_scrubbed_researcher$psychant)
t.test(data$psychsyn, exclusion_report$data_scrubbed_researcher$psychsyn)
t.test(data$evenodd, exclusion_report$data_scrubbed_researcher$evenodd)


