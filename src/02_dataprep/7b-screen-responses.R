
# ----------------------------------------------------------------------------#

# SCREEN RESPONSES


# Save copies of the original data and the data scrubbed by Qualtrics --------
data_original <- data
data_scrubbed_qualtrics <- data %>% filter(term == 'scrubbed')

# Filter Screeners: Bots ------------------------------------------
data <-
  data %>% 
    mutate(exclusion_reason = 
             case_when(
               
                 honeypot1 == 1 | 
                 honeypot2 == 1 | 
                 honeypot3 == 1 | 
                 Q_RecaptchaScore < .5 | 
                 Q_RelevantIDFraudScore > 30 ~ 'Failed bot check',
               .default = 'Other'
             )) %>% 
  
    filter(
      
      honeypot1 == 0,                   # Answered honey pots
      honeypot2 == 0,
      honeypot3 == 0,
      Q_RecaptchaScore >= .5,           # "A score of Less than 0.5 means the respondent is likely a bot." https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID
      Q_RelevantIDFraudScore < 30.      # "A score greater than or equal to 30 means the response is likely fraudulent and a bot."
    ) %>%
  
      mutate(exclusion_reason = 
               case_when(
          Q_RelevantIDDuplicateScore > 75 ~ 'Failed duplicate check',
          Q_RelevantIDDuplicateScore < 75,  # A score of greater than or equal to 75 means the response is likely a duplicate. https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID
          .default = exclusion_reason
                   )) %>% 
      
  
      branch_none == 0,                 # Branch: Did not serve
      validity_check_1 == 1,            # Failed Validity checks
      air_force_warrant_officer == 0,   # No warrant officers in the Air Force
      
      attention_check_biis == 1,        # Failed attention checks (i.e., instructed items)
      attention_check_wis == 1,
      
      `Duration (in seconds)` > 300,

      #psychsyn > 0,
      #psychant < 0,
      evenodd < 0,
      
      d_sq_flagged == FALSE,
    
# Longstring by scale --------------------------------------------------------

      longstr_reverse_biis < 17,         # BIIS = 17 items total
      longstr_no_reverse_biis < 17,
      longstr_reverse_mcarm < 21,        # MCARM = 21 items
      longstr_no_reverse_mcarm < 21,
      longstr_reverse_scc < 12,          # SCC = 12 items
      longstr_no_reverse_scc < 12)
  
## Filter out remaining screeners ----------------------------------------------------
### Three standard deviations from the mean of the data 
### In a particular order: duration, longstring, psychant/syn, and even odd


data <-
  data %>% 
  filter(
    
    longstr_reverse < mean(data$longstr_reverse) + (3 * sd(data$longstr_reverse)),          # Longsting outliers
    longstr_no_reverse < mean(data$longstr_no_reverse) + (3 * sd(data$longstr_no_reverse)), 
    
    avgstr_no_reverse < mean(data$avgstr_no_reverse) + (3 * sd(data$avgstr_no_reverse)), 
    avgstr_reverse < mean(data$avgstr_reverse) + (3 * sd(data$avgstr_reverse)), 
    
    `Duration (in seconds)` > mean(data$`Duration (in seconds)`) - (3 * sd(data$`Duration (in seconds)`)))
    


data_original <-
  data_original %>% 
  mutate(exclusion_reason = 
           case_when(
             
               honeypot1 == 1 | 
               honeypot2 == 1 | 
               honeypot3 == 1 | 
               Q_RecaptchaScore < .5 | 
               Q_RelevantIDFraudScore > 30 ~ 'Failed bot check',
               
             
             Q_RelevantIDDuplicateScore > 75 ~ 'Failed duplicate check',
             
             branch_none == 1 | validity_check_1 == 0 | air_force_warrant_officer == 1 ~ "Failed validity check",
             
             attention_check_biis == 0 | attention_check_wis == 0 ~ "Failed instructed items",
             `Duration (in seconds)` <= 300 ~ 'Response time',
             
             evenodd >= 0 ~ 'Even odd inconsistency',
             d_sq_flagged == TRUE ~ 'Multivariate outlier',
             
             longstr_reverse_biis == 17 | longstr_no_reverse_biis == 17 | 
               longstr_reverse_mcarm == 21 | longstr_no_reverse_mcarm == 21 | 
               longstr_reverse_scc == 12 | longstr_no_reverse_scc == 12 ~ 'Straightlining',
             
             longstr_reverse >= mean(data_original$longstr_reverse) + (3 * sd(data_original$longstr_reverse)) | 
               longstr_no_reverse >= mean(data_original$longstr_no_reverse) + (3 * sd(data_original$longstr_no_reverse)) |
               avgstr_no_reverse >= mean(data_original$avgstr_no_reverse) + (3 * sd(data_original$avgstr_no_reverse)) |
               avgstr_reverse >= mean(data_original$avgstr_reverse) + (3 * sd(data_original$avgstr_reverse)) ~ 'Straightlining',
             
             `Duration (in seconds)` <= mean(data_original$`Duration (in seconds)`) - 
               (3 * sd(data_original$`Duration (in seconds)`)) ~ "Response time",
             
             .default = "Not excluded"))

# Recalculate the indices with the partially cleaned data -----------------
## Psychometric Synonyms/Antonyms and Maha D are both relevative to the sample
## So having cleaned the sample using criteria that I am fairly certian about,
## now it makes sense to recalculate the sample-relative metrics and

data_scales <- 
  data %>% 
  select_scales()

data_scales_no_reverse_codes <- 
  data_scales %>% 
  undo_reverse_codes()


## Mohad --------------------------------------------------------------------
data <-
  data_scales %>% 
  select(!starts_with('scc')) %>% # Including the SCC produces an era for singularity 
  transmute(careless::mahad(x = ., 
                            plot = FALSE, 
                            flag = TRUE, 
                            confidence = 0.999, 
                            na.rm = TRUE)) %>% 
  rename(d_sq_flagged = flagged) %>% 
  bind_cols(data %>% select(!c(d_sq_flagged, d_sq)))


## Psychometric Synonyms ----------------------------------------------------
data <-
  data_scales %>%
  transmute(psychsyn = careless::psychsyn(., critval = 0.6)) %>% 
  bind_cols(data %>% select(!psychsyn))


## Psychometric Antonyms ----------------------------------------------------
data <-
  data_scales_no_reverse_codes %>%   # Before recoding, higher correlation indicates less attention/carefullness
  transmute(psychant = careless::psychant(., critval = -0.5, diag = FALSE)) %>% 
  bind_cols(data %>% select(!psychant))



# Filter based on new data ------------------------------------------------

data <-
  data %>% 
  filter(
    
    psychsyn > 0,
    psychant < 0,
    
    d_sq_flagged == FALSE
  )

# Remove Impossible/Highly Improbable -------------------------------------

# Semantic synonym inconsistency on Civilian Commitment Scale. Most responses across these 4 questions are VERY consistent. 

data <-
  data %>% 
    filter(
      abs(civilian_commit_1 - civilian_commit_2) < 3 &
      abs(civilian_commit_1 - civilian_commit_3) < 3 &
      abs(civilian_commit_1 - civilian_commit_4) < 3 &
      abs(civilian_commit_2 - civilian_commit_3) < 3 &
      abs(civilian_commit_2 - civilian_commit_4) < 3 &
      abs(civilian_commit_3 - civilian_commit_4) < 3
    )


# Straightline the MIOS with score higher more than 0 --------------------------------------------------------
data <-
  data %>% 
  filter(longstr_mios == 14, mios_total == 0) %>% 
  bind_rows(data %>% filter(longstr_mios != 14))

# Straightline the M2CQ with a score more than 0 --------------------------------------------------------
data <-
  data %>% 
  filter(longstr_m2cq == 16, m2cq_mean == 0) %>% 
  bind_rows(data %>% filter(longstr_m2cq != 16))

# PhD Under 28 --------------------------------------------------------
data <-
  data %>% 
  filter(education == 'Doctorate', years_of_age > 28) %>% 
  bind_rows(data %>% filter(education != 'Doctorate'))

# Reached E-7 to E-9 in under 7 years --------------------------------------------------------
data <-
  data %>% 
  filter(highest_rank == 'E-7 to E-9', years_service > 6) %>% 
  bind_rows(data %>% filter(highest_rank != 'E-7 to E-9'))

# Invalid years of service  --------------------------------------------------------
data <-
  data %>% 
  filter(years_service < 50, 
         years_separation < 130,
         years_of_age < 130,
         validity_years > -5,
         age_enlisted < 60
         )

# Invalid Free Respone ----------------------------------------------------

data <-
  data %>% 
  filter(  
    ResponseId != 'R_DIuctUzEpM5pXQR'   # R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
  )



# Save Data ---------------------------------------------------------------
# Save a copy of the screened responses
data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId'))



# Label reason for exclusion ----------------------------------------------
data_scrubbed_researcher <-  
  data_scrubbed_researcher %>% 
  mutate(exclusion_reason = 
           case_when(
             
             d_sq_flagged == TRUE ~ 'Multivariate outlier',
             abs(civilian_commit_1 - civilian_commit_2) == 3 | 
               abs(civilian_commit_1 - civilian_commit_3) == 3 |
               abs(civilian_commit_1 - civilian_commit_4) == 3 |
               abs(civilian_commit_2 - civilian_commit_3) == 3 |
               abs(civilian_commit_2 - civilian_commit_4) == 3 |
               abs(civilian_commit_3 - civilian_commit_4) == 3 ~ 'Semantic Inconsistency',
             psychant >= 0 |
               psychsyn <= 0 ~ 'Psychometric synonym/antonym inconsistency',
             
             .default = exclusion_reason)) 





# Write Data --------------------------------------------------------------


# Get a copy of the one's qualtrics removed that I didnt:
data_scrubbed_researcher_not_qualtrics <-
  anti_join(data_scrubbed_researcher, data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId'))

data_scrubbed_qualtrics_not_researcher <-
  anti_join(data_scrubbed_qualtrics, data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId'))

# get the date
currentDate <- Sys.Date()

data %>% 
  write_csv(file = here::here(paste('data/processed/data_clean_', currentDate, '.csv')))

data_original %>% 
  write_csv(file = here::here(paste('data/processed/data_unclean_', currentDate, '.csv')))

data_scrubbed_researcher_not_qualtrics %>% 
  select(ResponseId, exclusion_reason) %>% 
  write_csv(file = here::here(paste('data/processed/IDs_to_have_Qualtrics_scrub_', currentDate, '.csv')))

data_scrubbed_researcher_not_qualtrics %>% 
  write_csv(file = here::here(paste('data/processed/scrubbed_researcher_not_qualtrics_', currentDate, '.csv')))

data_scrubbed_qualtrics_not_researcher %>% 
  write_csv(file = here::here(paste('data/processed/scrubbed_qualtrics_not_researcher_', currentDate, '.csv')))

#rm(currentDate,
#   data_scrubbed_qualtrics, 
#   data_scrubbed_researcher, 
#   data_scrubbed_qualtrics_not_researcher, 
#   data_scrubbed_researcher_not_qualtrics)
