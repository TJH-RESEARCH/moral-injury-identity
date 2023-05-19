
# -------------------------------------------------------------------------
# Screen Responses



# Save those screened out by additional criteria ----------------------------------------------------
## This should be the opposite of the next script

# Save a copy pre-screened
data_original <- data
exclusion_report$data_original <- data_original

exclusion_report$cuts$longstring_reverse_cut <- 
  round(mean(data_original$longstr_reverse) + (2 * sd(data_original$longstr_reverse)))

exclusion_report$cuts$longstring_no_reverse_cut <-
  round(mean(data_original$longstr_no_reverse) + (2 * sd(data_original$longstr_no_reverse))) # Longstring outliers

exclusion_report$cuts$avgstr_reverse_cut <- 
  mean(data_original$avgstr_reverse) + (2 * sd(data_original$avgstr_reverse))             # Longsting outliers

exclusion_report$cuts$avgstr_no_reverse_cut <- 
  mean(data_original$avgstr_no_reverse) + (2 * sd(data_original$avgstr_no_reverse))    # Longstring outliers

exclusion_report$cuts$psychant_cut <- 
  mean(data_original$psychant) + (2 * sd(data_original$psychant))

exclusion_report$cuts$psychsyn_cut <- 
  mean(data_original$psychsyn) - (2 * sd(data_original$psychsyn))

exclusion_report$cuts$evenodd <- 
  mean(data_original$evenodd) + (2 * sd(data_original$evenodd))


# Filter Screeners: Clear cuts ------------------------------------------------------

data <-
  data %>% 
    filter(
      
      honeypot1 == 0, # Answered honey pots
      honeypot2 == 0,
      honeypot3 == 0,
      
      Q_RelevantIDDuplicateScore < 75, # A score of greater than or equal to 75 means the response is likely a duplicate.
      Q_RelevantIDFraudScore < 30, # A score greater than or equal to 30 means the response is likely fraudulent and a bot. https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID
      Q_RecaptchaScore >= .5, # A score of Less than 0.5 means the respondent is likely a bot.
      
      branch_none == 0, # Branch: Did not serve
      validity_check_1 == 1, # Failed Validity checks
      air_force_warrant_officer == 0, # No warrant officers in the Air Force
      
      attention_check_biis == 1, # Failed attention checks (i.e., instructed items)
      attention_check_wis == 1,
      
      `Duration (in seconds)` > 300,
      
      psychsyn > 0.05,
      psychant < -0.05,
      
      d_sq_flagged == FALSE
) %>% 
  filter(
      #is.na(term),  
      #longstr_mios,
      longstr_reverse_scc < 12,
      longstr_no_reverse_scc < 12,
      longstr_reverse_biis < 17,
      longstr_no_reverse_biis < 17,
      longstr_reverse_mcarm < 21,
      longstr_no_reverse_mcarm < 21,
      
  )


# Longstring by scale
## BIIS = 17 items
## M2CQ = 16 items
## MCARM = 21 items
## MIOS = 14 items
## SCC = 12 items



## Filter out screeners ----------------------------------------------------
### Three standard deviations from the mean of the original data 
### (i.e., before my screening and Qualtrics scrubbing).
### In a particular order: diration, longstring, psychant/syn, and even odd

data <-
  data %>% 
  filter(
    
    longstr_reverse < mean(data_original$longstr_reverse) + (3 * sd(data_original$longstr_reverse)),          # Longsting outliers
    longstr_no_reverse < mean(data_original$longstr_no_reverse) + (3 * sd(data_original$longstr_no_reverse)), # Longstring outliers
    
    avgstr_reverse < mean(data_original$avgstr_reverse) + (3 * sd(data_original$avgstr_reverse)),             # Longsting outliers
    avgstr_no_reverse < mean(data_original$avgstr_no_reverse) + (3 * sd(data_original$avgstr_no_reverse)),    # Longstring outliers
    
    psychant < mean(data_original$psychant) + (3 * sd(data_original$psychant)),
    psychsyn > mean(data_original$psychsyn) - (3 * sd(data_original$psychsyn)),
    
    evenodd < mean(data_original$evenodd) + (3 * sd(data_original$evenodd)),
    
  )

# Save a copy of the screened responses
exclusion_report$data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId'))
rm(data_original)

# Get a copy of the one's qualtrics removed that I didnt:
exclusion_report$data_I_scrubbed_that_qualtrics_didnt <-
  anti_join(exclusion_report$data_scrubbed_researcher, exclusion_report$data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId'))

exclusion_report$data_qualtrics_scrubbed_but_I_didnt <-
  anti_join(exclusion_report$data_scrubbed_qualtrics, exclusion_report$data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId'))

