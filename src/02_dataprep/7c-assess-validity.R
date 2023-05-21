
# ASSESS VALIDITY 

# Load packages ---------------------------------------------------------------
library(patchwork)    # `patchwork` combines ggplot graphs
library(validate)     # The `validate` package confronts the data with a set of validation rules.

# Validate Data ---------------------------------------------------------------#

## Declare Validity Rules ------------------------------------------------------
validity_rules <- 
  validate::validator(
    Air_Force_Warrant_Officer        = if(highest_rank == 'W-1 to CW-5') branch_air_force != 1,
    Branch_None                      = branch_none == 0,
    Honeypot_1                       = honeypot1 == 0,
    Honeypot_2                       = honeypot2 == 0,
    Honeypot_3                       = honeypot3 == 0,
    Improbable_Rank_Years            = if(highest_rank == 'E-7 to E-9') years_service > 7,
    Improbable_Age_Child             = if(years_of_age < 40) military_family_child == 0,
    Improbable_Age_Education         = if(education == 'Doctorate') years_of_age > 30,
    Inconsistent_Child               = if(military_family_child == 1) !is.na(bipf_children),
    Inconsistent_Religion_Worship    = if(religious == 0) worship < 4,
    Inconsistent_Retirement          = if(is.na(bipf_work)) employment_retired == 1 | employment_unemployed == 1,
    Inconsistent_Student             = if(is.na(bipf_education)) employment_student == 0, 
    Space_Force_1                    = if(branch_space_force == 1) years_service > 3,
    Space_Force_2                    = if(branch_space_force == 1) years_separation > 3,
    validity_check_1                 = validity_check_1 == 1,
    attention_check_1                = attention_check_biis == 1,
    attention_check_2                = attention_check_wis == 1,
    Psychometric_Synonyms            = psychsyn > 0.05,
    Psychometric_Antonyms            = psychant < -0.05,
    Average_String_Length_Reverse    = avgstr_reverse < mean(data$avgstr_reverse) + (2 * sd(data$avgstr_reverse)),
    Average_String_Length_No_Reverse = avgstr_no_reverse < mean(data$avgstr_no_reverse) + (2 * sd(data$avgstr_no_reverse)),
    
    Longstring_Length_Reverse        = longstr_reverse < mean(data$longstr_reverse) + (2 * sd(data$longstr_reverse)),
    Longstring_Length_No_Reverse     = longstr_no_reverse < mean(data$longstr_no_reverse) + (2 * sd(data$longstr_no_reverse)),
    
    Even_Odd_Consistency             = evenodd > mean(data$evenodd) - (2 * sd(data$evenodd)),
    Duration                         = `Duration (in minutes)` > mean(data$`Duration (in minutes)`) - (2 * sd(data$`Duration (in minutes)`)),
    Validity_Years_Less_0            = validity_years > -1, 
    Validity_Years_Less_negative_5   = validity_years > -5, 
    Validity_Years_Low_Outlier       = validity_years > mean(data$validity_years) - (2 * sd(data$validity_years)), 
    Validity_Years_High_Outlier      = validity_years < mean(data$validity_years) + (2 * sd(data$validity_years)),
    
    mohalanobis_d_flag               = d_sq_flagged == FALSE
  )

## Confront the data
quality_check <- validate::confront(data, validity_rules) 

## Summarize the validity criteria ------------------------------------------
validate::summary(quality_check)[,1:6] %>% tibble() %>% arrange(desc(fails)) %>% print(n = 50)

## Visualize the validity criteria ------------------------------------------
validate::plot(quality_check, xlab = "")

## Check individual records -------------------------------------------------
validate::aggregate(quality_check, by="record")

## Join validity records with response data  -------------------------------
data <- 
  validate::aggregate(quality_check, by="record") %>% 
  tibble() %>%
  select(rel.pass, rel.NA) %>% 
  bind_cols(data) %>% 
  rename(validity_rel_pass = rel.pass,
         validity_rel_NA = rel.NA,
  ) %>% 
  select(ResponseId, everything())


# Compare cleaned to original data ----------------------------------------

validate::compare(validity_rules, 
                  raw = data_original, 
                  cleaned = data, 
                  how = 'sequential')


rm(quality_check, validity_rules)


# Visualize ---------------------------------------------------------------

## Psychometric Synonyms/Antonyms
psych_scatter <-
  data %>% 
  ggplot2::ggplot(aes(x = psychant, 
                      y = psychsyn)) +
  geom_point() + 
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
  geom_point() +
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

psych_scatter + psych_scatter_original

(duration_box + duration_hist) / (duration_box_original + duration_hist_original)

(evenodd_box + evenodd_hist) / (evenodd_box_original + evenodd_hist_original)


rm(psychsyn_box, psychsyn_hist, psychant_box, psychant_hist, 
   psych_scatter, duration_box, duration_hist, evenodd_box, 
   evenodd_hist, psychsyn_box_original, psych_scatter_original,
   psychsyn_hist_original, psychant_box_original, psychant_hist_original,
   duration_box_original, duration_hist_original, evenodd_box_original,
   evenodd_hist_original)



# print MOS to check manually -----------------------------------------------
?evenodd
data %>% 
  select(ResponseId, mos, branch, years_service, years_separation) %>% 
  print(n = nrow(data))

## Flag MOS:
# R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
# 141 Commissioned Officer, Navy, 27 years service, 39 years separated
# 171 do not recall, Army, 6, 47
# 177 Atomic Demolition, Army, 3, 58 (not invalid, but interesting)


# Inspect improbable answers -------------------------------------------------

# Improbably fast rank achievement
data %>% 
  filter(highest_rank == 'E-7 to E-9') %>% 
  select(ResponseId, years_service) %>% 
  arrange(years_service) %>% 
  print(n = nrow(data))
## flag: R_333yrSOKhrqsI5N, 4 years service


# Improbable_Age_Child: if(years_of_age < 40) military_family_child == 0,
data %>% 
  filter(military_family_child == 1) %>% 
  select(ResponseId, years_of_age, military_family_child) %>%
  arrange(years_of_age) %>% 
  print(n = nrow(data))
## Flag: 


# Improbable_Age_Education: if(education == 'doctorate') years_of_age > 30,
data %>% 
  filter(education == 'Doctorate' | education == 'Applied or professional doctorate') %>% 
  select(ResponseId, years_of_age, education) %>%
  arrange(years_of_age) %>% 
  print(n = nrow(data))
## Flag: R_rcI2ky4GMLfDtKh, 23 year old doctorate


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




