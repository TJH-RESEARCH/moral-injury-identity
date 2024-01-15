


# Label:
data <- 
  data %>% 
  mutate(air_force_warrant_officer = ifelse(branch == 'Air Force' & warrant_officer == 1, 1, 0)) # Air Force Warrant Officers
data <- 
  data %>% 
  mutate(warrant_officer_years = ifelse(warrant_officer == 1 & years_service < 8, 1, 0)) # Warrant Officer with too few years of service

# Filter:
data <-
  data %>% 
  filter(
    
    ## Exclusion Criteria
    branch_none == 0,                     # Branch: Did not serve
    validity_check_1 == 1,                # Failed Validity checks
    air_force_warrant_officer == 0,       # No warrant officers in the Air Force
    warrant_officer_years == 0,           # Becoming a warrant officer takes longer than 5 years
    
    ## Instructed Items
    attention_check_biis == 1,        # Failed attention checks (i.e., instructed items)
    attention_check_wis == 1,
    
    ## Duration
    `Duration (in seconds)` > 300
  )


## These are again, I think, are fairly uncontroversial removals.
## Respondents were inconsistent between answers in ways that are implausible
## or impossible. 

## PhD Under 28
data <-
  data %>% 
  filter(education == 'Doctorate', years_of_age > 28) %>% 
  bind_rows(data %>% filter(education != 'Doctorate'))

## Reached E-7 to E-9 in under 6 years
data <-
  data %>% 
  filter(highest_rank == 'E-7 to E-9', years_service > 5) %>% 
  bind_rows(data %>% filter(highest_rank != 'E-7 to E-9'))

## Invalid years of service
data <-
  data %>% 
  filter(years_service < 50, years_separation < 130,
         years_of_age < 100, validity_years > -5, age_enlisted < 60
  )

## Invalid MOS Free Response
data <-
  data %>% 
  filter(  
    ResponseId != 'R_DIuctUzEpM5pXQR',   # R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
    ResponseId != 'R_3qwzDFSzxJtD1S8'   # R_3qwzDFSzxJtD1S8 Years active 1990
  )






# Account for Exclusion Reason --------------------------------------------


data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 
           case_when(
             
             honeypot1 == 1 | 
               honeypot2 == 1 | 
               honeypot3 == 1 | 
               Q_RecaptchaScore < .5 | 
               Q_RelevantIDFraudScore >= 30 ~ 'Failed bot check',
             
             Q_RelevantIDDuplicateScore >= 75 ~ 'Failed duplicate check',
             
             branch_none == 1 | validity_check_1 == 0 | air_force_warrant_officer == 1 | warrant_officer_years == 1 ~ "Failed validity check",
             
             attention_check_biis == 0 | attention_check_wis == 0 ~ "Failed instructed items",
             
             `Duration (in seconds)` <= 300 ~ 'Response time',
             
             .default = "Not excluded 1"))


data_scrubbed_researcher %>% count(exclusion_reason)
