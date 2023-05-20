
# ----------------------------------------------------------------------------#

# SCREEN RESPONSES


# Save copies of the original data and the data scrubbed by Qualtrics --------
data_original <- data
data_scrubbed_qualtrics <- data %>% filter(term == 'scrubbed')

# Filter Screeners: Obvious Filters ------------------------------------------
data <-
  data %>% 
    filter(
      
      honeypot1 == 0,                   # Answered honey pots
      honeypot2 == 0,
      honeypot3 == 0,
      
      Q_RelevantIDDuplicateScore < 75,  # A score of greater than or equal to 75 means the response is likely a duplicate. https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID
      Q_RelevantIDFraudScore < 30,      # A score greater than or equal to 30 means the response is likely fraudulent and a bot. 
      Q_RecaptchaScore >= .5,           # A score of Less than 0.5 means the respondent is likely a bot.
      
      branch_none == 0,                 # Branch: Did not serve
      validity_check_1 == 1,            # Failed Validity checks
      air_force_warrant_officer == 0,   # No warrant officers in the Air Force
      
      attention_check_biis == 1,        # Failed attention checks (i.e., instructed items)
      attention_check_wis == 1,
      
      `Duration (in seconds)` > 300,
      
      psychsyn > 0.05,
      psychant < -0.05,
      
      d_sq_flagged == FALSE
) %>% 
  
# Longstring by scale --------------------------------------------------------
  filter(
      longstr_reverse_biis < 17,         # BIIS = 17 items total
      longstr_no_reverse_biis < 17,
      longstr_reverse_m2cq < 16,         # M2CQ = 16 items
      longstr_reverse_mcarm < 21,        # MCARM = 21 items
      longstr_no_reverse_mcarm < 21,
      longstr_reverse_scc < 12,          # SCC = 12 items
      longstr_no_reverse_scc < 12,
  )



## Filter out screeners ----------------------------------------------------
### Three standard deviations from the mean of the data 
### In a particular order: diration, longstring, psychant/syn, and even odd

data <-
  data %>% 
  filter(
    
    longstr_reverse < mean(data$longstr_reverse) + (3 * sd(data$longstr_reverse)),          # Longsting outliers
    longstr_no_reverse < mean(data$longstr_no_reverse) + (3 * sd(data$longstr_no_reverse)), 
    
    avgstr_reverse < mean(data$avgstr_reverse) + (3 * sd(data$avgstr_reverse)),             
    avgstr_no_reverse < mean(data$avgstr_no_reverse) + (3 * sd(data$avgstr_no_reverse)),    
    
    psychant < mean(data$psychant) + (3 * sd(data$psychant)),
    psychsyn > mean(data$psychsyn) - (3 * sd(data$psychsyn)),
    
    evenodd < mean(data$evenodd) + (3 * sd(data$evenodd)),
    
  )


# Remove Impossible/Highly Improbable -------------------------------------

data <-
  data %>% 
  filter(ResponseId != 'R_333yrSOKhrqsI5N' &   # R_333yrSOKhrqsI5N E-7 to E-9 and only 4 years service
           ResponseId != 'R_rcI2ky4GMLfDtKh' &   # R_rcI2ky4GMLfDtKh 23 year-old phd
           ResponseId != 'R_DIuctUzEpM5pXQR' &   # R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
           ResponseId != 'R_12rO13rLswQQlH3' &   # R_12rO13rLswQQlH3 enlisted when he was 62.
           ResponseId != 'R_3qwzDFSzxJtD1S8' &   # R_3qwzDFSzxJtD1S8 1990 years of service
           ResponseId != 'R_2pLztPsOtJp3tqx' &   # R_2pLztPsOtJp3tqx -8 validity years 
           ResponseId != 'R_2dF3KxaBBb1DC7J' &   # R_2dF3KxaBBb1DC7J -8 validity years
           ResponseId != 'R_3L5Bhp1U9Q3jIVY' &   # R_3L5Bhp1U9Q3jIVY Straightlined the MIOS but not with 0s, which would be a valid response. Instead, with 2s although did not report an MIOS event. So why the 2s.
           ResponseId != 'R_CgmXA6siHeYfTXj')    # R_CgmXA6siHeYfTXj Semantic synonym inconsistency on Civilian Commitment Scale. Most responses across these 4 questions are VERY consistent. 



# Save a copy of the screened responses
data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId'))

# Get a copy of the one's qualtrics removed that I didnt:
data_scrubbed_researcher_not_qualtrics <-
  anti_join(data_scrubbed_researcher, data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId'))

data_scrubbed_qualtrics_not_researcher <-
  anti_join(data_scrubbed_qualtrics, data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId'))


# Write Data --------------------------------------------------------------

currentDate <- Sys.Date()

data %>% 
  write_csv(file = here::here(paste('data/processed/data_clean_', currentDate, '.csv')))

data_original %>% 
  write_csv(file = here::here(paste('data/processed/data_unclean_', currentDate, '.csv')))

data_scrubbed_researcher_not_qualtrics %>% 
  select(ResponseId) %>% 
  write_csv(file = here::here(paste('data/processed/IDs_to_have_Qualtrics_scrub_', currentDate, '.csv')))

data_scrubbed_researcher_not_qualtrics %>% 
  write_csv(file = here::here(paste('data/processed/scrubbed_researcher_not_qualtrics_', currentDate, '.csv')))

data_scrubbed_qualtrics_not_researcher %>% 
  write_csv(file = here::here(paste('data/processed/scrubbed_qualtrics_not_researcher_', currentDate, '.csv')))

rm(currentDate,
   data_original, 
   data_scrubbed_qualtrics, 
   data_scrubbed_researcher, 
   data_scrubbed_qualtrics_not_researcher, 
   data_scrubbed_researcher_not_qualtrics)
