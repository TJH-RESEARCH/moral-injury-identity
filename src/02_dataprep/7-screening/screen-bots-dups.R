
data_start <- data


data <-
  data %>% 
  filter(
    
    ## Bots
    honeypot1 == 0,                   # Answered honey pots
    honeypot2 == 0,
    honeypot3 == 0,
    Q_RecaptchaScore >= .5,            # "A score of Less than 0.5 means the respondent is likely a bot." https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID
    Q_RelevantIDFraudScore < 30,      # "A score greater than or equal to 30 means the response is likely fraudulent and a bot."
    
    ## Duplicates
    Q_RelevantIDDuplicateScore < 75   # A score of greater than or equal to 75 means the response is likely a duplicate. https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID
  )



# Label Exclusion Reasons -------------------------------------------------

data_new_exclusions <- 
  anti_join(data_start, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 'Bots and Duplicates')

data_scrubbed_researcher <-
  data_scrubbed_researcher %>% 
  bind_rows(data_new_exclusions)

rm(data_new_exclusions, data_start)
