

# Create visualizations ---------------------------------------------------

## Load packages 
library(patchwork)


# Visualize ---------------------------------------------------------------

## Psychometric Synonyms/Antonyms
psych_scatter <-
  data %>% 
  ggplot2::ggplot(aes(x = psychant, 
                      y = psychsyn)) +
  geom_text(aes(label = id)) +
  labs(title = 'Psychological Synonym and Antonym Correlations') +
  lims(x = c(-1, 0), y = c(0, 1))

psychsyn_box <-
  data %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_boxplot() +
  labs(title = 'Psychological Synonym Correlation') +
  lims(x = c(0, 1))

psychsyn_hist <-
  data %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_histogram() +
  lims(x = c(0, 1))

psychant_box <-
  data %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_boxplot() +
  labs(title = 'Psychological Antonym Correlation') +
  lims(x = c(-1, 0))

psychant_hist <-
  data %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_histogram() +
  lims(x = c(-1, 0))

## Duration

duration_box <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_boxplot() +
  lims(x = c(0, 100))
  labs(title = 'Duration')

duration_hist <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_histogram() +
  lims(x = c(0, 100))


## Even-Odd Consistency

evenodd_box <-
  data %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_boxplot() +
  labs(title = 'Even-Odd Consistency')

evenodd_hist <-
  data %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_histogram() +
  labs(title = '')

## Difference between M2C-Q and M-CARM scores  

diff_hist <-
  data %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_histogram() +
  labs(title = '')

diff_box <-
  data %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_boxplot() +
  labs(title = 'Difference between M2C-Q and M-CARM (0-4 range)')


# Visualize for screened responses ----------------------------------------


## Psychometric Synonyms/Antonyms
psych_scatter_screening <-
  data_extra_screening %>% 
  ggplot2::ggplot(aes(x = psychant, 
                      y = psychsyn)) +
  geom_text(aes(label = id)) +
  labs(title = 'Screened Out: Psychological Synonym and Antonym Correlations') +
  lims(x = c(-1, 0), y = c(0, 1))

psychsyn_box_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_boxplot() +
  labs(title = 'Screened Out: Psychological Synonym Correlation') +
  lims(x = c(0, 1))

psychsyn_hist_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_histogram() +
  lims(x = c(0, 1))

psychant_box_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_boxplot() +
  labs(title = 'Screened Out: Psychological Antonym Correlation') +
  lims(x = c(-1, 0))

psychant_hist_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_histogram() +
  lims(x = c(-1, 0))

## Duration

duration_box_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_boxplot() +
  lims(x = c(0, 100))
labs(title = 'Screened Out: Duration')

duration_hist_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_histogram() +
  lims(x = c(0, 100))


## Even-Odd Consistency

evenodd_box_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_boxplot() +
  labs(title = 'Even-Odd Consistency')

evenodd_hist_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_histogram() +
  labs(title = '')

## Difference between M2C-Q and M-CARM scores  

diff_hist_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_histogram() +
  labs(title = '')

diff_box_screening <-
  data_extra_screening %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_boxplot() +
  labs(title = 'Difference between M2C-Q and M-CARM (0-4 range)')


# Plot -------------------------------------------------------------------------


(psychsyn_box + psychsyn_hist_screening) / (psychsyn_box_screened + psychsyn_hist)
psychant_box / psychant_hist
psych_scatter
duration_box / duration_hist
evenodd_box / evenodd_hist
diff_box / diff_hist

rm(psychsyn_box, psychsyn_hist, psychant_box, psychant_hist, 
   psych_scatter, duration_box, duration_hist, evenodd_box, 
   evenodd_hist, diff_box, diff_hist)

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

data %>% 
  filter(validity_nfail_2 > 0) #%>% 
#  View()

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
  select(ResponseId, years_of_age) %>%
  arrange(years_of_age) %>% 
  print(n = nrow(data))

## Flag: R_rcI2ky4GMLfDtKh, 23 year old doctorate

data %>% 
  filter(education == 'Applied or professional doctorate') %>% 
  select(ResponseId, years_of_age) %>%
  arrange(years_of_age) %>% 
  print(n = nrow(data))

# Inconsistent_Child               = if(military_family_child == 1) !is.na(bipf_children),
data %>% 
  filter(military_family_child == 1) %>% 
  select(ResponseId, military_family_child, bipf_children) %>%
  arrange(bipf_children) %>% 
  print(n = nrow(data))

## Flag: 


# Inconsistent_Religion_Worship    = if(religious == 0) worship < 4,
data %>% 
  filter(religious == 0 & worship > 4) %>% 
  select(ResponseId, religious, worship, validity_nfail) %>%
  arrange(worship) %>% 
  print(n = nrow(data))
## Flag: R_3kh9MlL3qrxkLrb, not religious at all but a weekly church goer...not impossible


# Inconsistent_Retirement          = if(is.na(bipf_work)) employment_retired == 1 | employment_unemployed == 1,
data %>% 
  filter((employment_retired == 1 | employment_unemployed == 1) & bipf_work == 1) %>% 
  select(ResponseId, employment_unemployed, employment_retired, bipf_work, validity_nfail) %>%
  arrange(bipf_work) %>% 
  print(n = nrow(data))

## the item is supposed to assess how much this has made it hard to work.
## If they report being retired, that is not necessarily inconsistent
## Flag: 

# Inconsistent_Student             = if(is.na(bipf_education)) employment_student == 0, 
data %>% 
  filter(employment_student == 0 & bipf_education == 1) %>% 
  select(ResponseId, employment_student, bipf_education, validity_nfail) %>%
  arrange(bipf_education) %>% 
  print(n = nrow(data))

## Again, not sure the b-IPF is a good judge of consistency
## Flag: 


# validity years
data %>% 
  select(ResponseId, 
         validity_years, 
         year_entered_military, 
         year_left_military, 
         age_enlisted,
         age_separated) %>%
  arrange(validity_years) %>% 
  print(n = nrow(data))


## Flag: R_12rO13rLswQQlH3, enlisted when he was 62.



# Screen Out Inconsistent/Improbable -----------------------------------------------------------------

# not yet screened: R_3kh9MlL3qrxkLrb, not religious at all but a weekly church goer...not impossible


data_original <- data
data <-
  data %>% 
    filter(ResponseId != 'R_333yrSOKhrqsI5N' &   # R_333yrSOKhrqsI5N, E-7 to E-9 and only 4 years service
           ResponseId != 'R_rcI2ky4GMLfDtKh' &   # R_rcI2ky4GMLfDtKh, 23 year-old phd
           ResponseId != 'R_DIuctUzEpM5pXQR' &   # R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
           ResponseId != 'R_12rO13rLswQQlH3')    # R_12rO13rLswQQlH3, enlisted when he was 62.

data_extra_screening <- bind_rows(anti_join(data_original, data, by = c('id' = 'id')), data_extra_screening)
rm(data_original)

# Test Difference between scrubbed at not ---------------------------------



# Is scrubbed data that much different from the sample? -------------------

t.test(data$mios_total, data_extra_screening$mios_total)
t.test(data$mcarm_total, data_extra_screening$mcarm_total)
t.test(data$biis_total, data_extra_screening$biis_total)
t.test(data$longstr_no_reverse, data_extra_screening$longstr_no_reverse)
t.test(data$longstr_reverse, data_extra_screening$longstr_reverse)
t.test(data$psychant, data_extra_screening$psychant)
t.test(data$psychsyn, data_extra_screening$psychsyn)
t.test(data$evenodd, data_extra_screening$evenodd)




