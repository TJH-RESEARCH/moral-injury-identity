
# ----------------------------------------------------------------------------#

# SCREEN RESPONSES


# Save copies of the original data and the data scrubbed by Qualtrics --------
data_original <- data
data_scrubbed_qualtrics <- data %>% filter(term == 'scrubbed')

# Filter Screeners: Bots ------------------------------------------
data <-
  data %>% 
    filter(
      honeypot1 == 0,                   # Answered honey pots
      honeypot2 == 0,
      honeypot3 == 0,
      Q_RecaptchaScore >= .5,            # "A score of Less than 0.5 means the respondent is likely a bot." https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID
      Q_RelevantIDFraudScore < 30,      # "A score greater than or equal to 30 means the response is likely fraudulent and a bot."
      
# Filter Screeners: Duplicate -------------------------------------------------
      Q_RelevantIDDuplicateScore < 75,   # A score of greater than or equal to 75 means the response is likely a duplicate. https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID

# Filter Screeners: Exlcusion Criteria  -----------------------------------------------
      branch_none == 0,                     # Branch: Did not serve
      validity_check_1 == 1,                # Failed Validity checks
      air_force_warrant_officer == 0,       # No warrant officers in the Air Force

# Filter Screeners: Instructed Items -------------------------------------------------------------------------
      attention_check_biis == 1,        # Failed attention checks (i.e., instructed items)
      attention_check_wis == 1,

# Filter Screeners: Duration ----------------------------------------------
      `Duration (in seconds)` > 300,
      
# Filter Screeners: Even-Odd Consistency ----------------------------------
      evenodd <= -.3,

# Filter Screeners: Moha D ------------------------------------------------
     # d_sq_flagged == FALSE,
    
# Longstring by scale --------------------------------------------------------
        longstr_reverse_biis < 16,         # BIIS = 17 items total
        longstr_no_reverse_biis < 16,
        longstr_reverse_mcarm < 20,        # MCARM = 21 items
        longstr_no_reverse_mcarm < 20,
        longstr_reverse_scc < 11,          # SCC = 12 items
        longstr_no_reverse_scc < 11
)

data_scrubbed_researcher1 <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 
           case_when(
             
             honeypot1 == 1 | 
               honeypot2 == 1 | 
               honeypot3 == 1 | 
               Q_RecaptchaScore < .5 | 
               Q_RelevantIDFraudScore >= 30 ~ 'Failed bot check',
             
             Q_RelevantIDDuplicateScore >= 75 ~ 'Failed duplicate check',
             
             branch_none == 1 | validity_check_1 == 0 | air_force_warrant_officer == 1 ~ "Failed validity check",
             
             attention_check_biis == 0 | attention_check_wis == 0 ~ "Failed instructed items",
             `Duration (in seconds)` <= 300 ~ 'Response time',
             
             evenodd > -0.30 ~ 'Even odd inconsistency',
             
             longstr_reverse_biis >= 16 | longstr_no_reverse_biis >= 16 | 
               longstr_reverse_mcarm >= 20 | longstr_no_reverse_mcarm >= 20 | 
               longstr_reverse_scc >= 11 | longstr_no_reverse_scc >= 11 ~ 'Straightlining',
             
             .default = "Not excluded"))



  

## Filter out remaining screeners ----------------------------------------------------
### Three standard deviations from the mean of the data: longstring, duration

data <-
  data %>%
  filter(
    
    longstr_reverse < mean(data$longstr_reverse) + (3 * sd(data$longstr_reverse)),          # Longsting outliers
    longstr_no_reverse < mean(data$longstr_no_reverse) + (3 * sd(data$longstr_no_reverse)), 
    
    avgstr_no_reverse < mean(data$avgstr_no_reverse) + (3 * sd(data$avgstr_no_reverse)), 
    avgstr_reverse < mean(data$avgstr_reverse) + (3 * sd(data$avgstr_reverse)),
    
    avgstr_reverse_biis < mean(data$longstr_reverse_biis) + (3 * sd(data$longstr_reverse_biis)),          # Longsting outliers
    avgstr_no_reverse_biis < mean(data$longstr_no_reverse_biis) + (3 * sd(data$longstr_no_reverse_biis)), 
    
    avgstr_reverse_mcarm < mean(data$longstr_reverse_mcarm) + (3 * sd(data$longstr_reverse_mcarm)),          # Longsting outliers
    avgstr_no_reverse_mcarm < mean(data$longstr_no_reverse_mcarm) + (3 * sd(data$longstr_no_reverse_mcarm)), 
    
    avgstr_no_reverse_scc < mean(data$avgstr_no_reverse_scc) + (3 * sd(data$avgstr_no_reverse_scc)),          # Longsting outliers
    avgstr_reverse_scc < mean(data$avgstr_reverse_scc) + (3 * sd(data$avgstr_reverse_scc)),          # Longsting outliers
    
    `Duration (in seconds)` > mean(data$`Duration (in seconds)`) - (2.5 * sd(data$`Duration (in seconds)`))
)


data_scrubbed_researcher2 <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>% 
  anti_join(data_scrubbed_researcher1, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 
           case_when(
            
             `Duration (in seconds)` <= mean(data$`Duration (in seconds)`) - 
               (3 * sd(data$`Duration (in seconds)`)) ~ "Response time",
           
             .default = 'Average String')) %>% 
  bind_rows(data_scrubbed_researcher1)


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
## If the data is not multivariate normal, then excluding outliers is not good
data <-
  data_scales %>% 
  select(!starts_with('scc')) %>% # Including the SCC produces an era for singularity 
  transmute(careless::mahad(x = ., 
                            plot = TRUE, 
                            flag = TRUE, 
                            confidence = 0.999, 
                            na.rm = TRUE)) %>% 
  rename(d_sq_flagged = flagged, d_sq = d_sq) %>%
  bind_cols(data %>% select(!c(d_sq_flagged, d_sq)))

data %>% 
  ggplot(aes(d_sq)) + geom_histogram()



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
    psychsyn > 0.15,
    psychant < -0.15
    )


data_scrubbed_researcher3 <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>%
  anti_join(data_scrubbed_researcher2, by = c('ResponseId' = 'ResponseId')) %>%
  mutate(exclusion_reason = 'Psychometric synonym/antonym inconsistency') %>% 
  bind_rows(data_scrubbed_researcher2)

  

# Filter: Multivariate Outliers -------------------------------------------
data <- data %>% 
  filter(d_sq_flagged == FALSE)

data_scrubbed_researcher4 <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>%
  anti_join(data_scrubbed_researcher3, by = c('ResponseId' = 'ResponseId')) %>%
  mutate(exclusion_reason = 'Multivariate Outlier') %>%
bind_rows(data_scrubbed_researcher3)


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
         years_of_age < 100,
         validity_years > -5,
         age_enlisted < 60
         )

# Invalid Free Respone ----------------------------------------------------
data <-
  data %>% 
  filter(  
    ResponseId != 'R_DIuctUzEpM5pXQR',   # R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
    ResponseId != 'R_3qwzDFSzxJtD1S8'   # R_3qwzDFSzxJtD1S8 Years active 1990
  )


data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>% 
  anti_join(data_scrubbed_researcher4, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 
           case_when(
             
             abs(civilian_commit_1 - civilian_commit_2) == 3 | 
               abs(civilian_commit_1 - civilian_commit_3) == 3 |
               abs(civilian_commit_1 - civilian_commit_4) == 3 |
               abs(civilian_commit_2 - civilian_commit_3) == 3 |
               abs(civilian_commit_2 - civilian_commit_4) == 3 |
               abs(civilian_commit_3 - civilian_commit_4) == 3 ~ 'Semantic Inconsistency',
             
             longstr_mios == 14 & mios_total > 0 ~ 'Straightlining',
             
             .default = "Other inconsistency or improbability")) %>% 
  bind_rows(data_scrubbed_researcher4)

#rm(data_scrubbed_researcher1, 
#   data_scrubbed_researcher2,
#   data_scrubbed_researcher3,
#   data_scrubbed_researcher4)






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
