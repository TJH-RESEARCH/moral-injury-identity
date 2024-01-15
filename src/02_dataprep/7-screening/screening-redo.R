

message('Screening invalid responses...')

# Load Functions ----------------------------------------------------------
source(here::here('src/01_config/functions/function-select-scales.R'))
source(here::here('src/01_config/functions/function-reorder-data.R'))
source(here::here('src/01_config/functions/function-undo-reverse-codes.R'))
source(here::here('src/01_config/functions/function-calculate-longstring.R'))
source(here::here('src/01_config/functions/function-calculate-longstring-again.R'))

## Goal: 
## start by filtering the most obviously invalid responses
## then apply the more rigorous methods, but again start with the low bars
## that way the screening methods that are dependent on the data will have better quality data to begin with

# One issue with how I did this on the original dissertaiton is that
# I calculated longstring and even odd before removing the obviously invalid
# Since these methods depend on the data e.g., identifying outliers
# It helps to start with better quality data

# SCREEN RESPONSES




# Screen 1:  --------------
## These were flagged as invalid by the survey host


## Filter
data <- 
  data %>% 
  filter(Progress == 100)

data <-
  data %>% 
  filter(is.na(term) | (term != 'Scrubbed' & term != 'Scrubbed Out' & term != 'scrubbed'))



# Screen 2 ------------------------------------------
## These are obvious criteria that almost everyone would agree to


### Add these tags to filter

#### Air Force Warrant Officer
data <- data %>% mutate(air_force_warrant_officer = ifelse(branch == 'Air Force' & warrant_officer == 1, 1, 0)) # Air Force Warrant Officers

#### Warrant Officer with too few years of service
data <- data %>% mutate(warrant_officer_years = ifelse(warrant_officer == 1 & years_service < 8, 1, 0))

# Filter:
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
    Q_RelevantIDDuplicateScore < 75,   # A score of greater than or equal to 75 means the response is likely a duplicate. https://www.qualtrics.com/support/survey-platform/survey-module/survey-checker/fraud-detection/#RelevantID
    
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



# Screen 3 ------------------------------------------
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






# Screen 3 ----------------------------------------------------------------
## Now screen the really obvious and aggregriuos instances of straightlining, 
## which is the main threat on an online survey, along with answering in a random pattern

data <- data %>% calculate_longstring()


## Straightlined the MIOS with score higher more than 0
data <-
  data %>% 
  filter(longstr_mios == 14, mios_total == 0) %>% 
  bind_rows(data %>% filter(longstr_mios != 14))

## Straightlined the M2CQ with a score more than 0
data <-
  data %>% 
  filter(longstr_m2cq == 16, m2cq_mean == 0) %>% 
  bind_rows(data %>% filter(longstr_m2cq != 16))



data <-
  data %>% 
  filter(
  ## Longstring by scale
    longstr_reverse_biis < 17,         # BIIS = 17 items total
    longstr_no_reverse_biis < 17,
    longstr_reverse_mcarm < 19,        # MCARM = 21 items - <19
    longstr_no_reverse_mcarm < 19,
    longstr_reverse_scc < 12,          # SCC = 12 items - <10
    longstr_no_reverse_scc < 12)





# Calculate Inconsistency Indices ----------------------------------------

## Even-Odd Consistency ------------------------------------------------

suppressWarnings({
  
  data <-
    data %>% 
    select_scales() %>% 
    reorder_data_scales() %>% 
    transmute(evenodd = 
                careless::evenodd(x =., 
                                  # nItems in each subscale in order:
                                  factors = c(
                                    10, # BIIS Harmony
                                    7,  # BIIS Blended
                                    4,  # Civilian Commitment
                                    16, # M2C-Q
                                    6,  # MCARM Purpose 
                                    4,  # MCARM Help
                                    3,  # MCARM Civilians
                                    3,  # MCARM Resentment
                                    5,  # MCARM Regimentation
                                    7,  # MIOS Shame
                                    7,  # MIOS Trust
                                    12, # SCC 
                                    7,  # WIS Private Regard
                                    7,  # WIS Interdependent
                                    3,  # WIS Connection
                                    3,  # WIS Family
                                    4,  # WIS Centrality
                                    4,  # WIS Public Regard
                                    3)  # WIS Skills
                )) %>% bind_cols(data) # Add the results back to the original data. 
}) # End warning suppression. ℹ In argument: `evenodd = careless::evenodd(...)`.Caused by warning in `careless::evenodd()`: ! Computation of even-odd has changed for consistency of interpretation with other indices. This change occurred in version 1.2.0. A higher score now indicates a greater likelihood of careless responding. If you have previously written code to cut score based on the output of


# The most conservative even-odd cut, to make the "low bar approach" is anything
# above 0. This indicates going in the opposite direction of everyone else
data %>% ggplot(aes(evenodd)) + geom_histogram()
data <- data %>% filter(evenodd < 0)




## Psychometric Synonyms/Antonyms ------------------------------------------------
## Use the maximum/minimum critical value possible with data removal

data <-
  data %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychsyn = careless::psychsyn(., critval = 0.76)) %>% 
  bind_cols(data)

data %>% ggplot(aes(psychsyn)) + geom_histogram()

data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% # Before recoding, higher correlation indicates less attention/carefullness
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychant = careless::psychant(., critval = -0.62, diag = FALSE)) %>% 
  bind_cols(data)
  
data %>% ggplot(aes(psychant)) + geom_histogram()
## Antonyms are really inconclusive! Not going to filter there
## Synonyms will do conservative. Anything 0 or less
  

  

# Filter by Psychometric Synonym/Antonym
data <-
  data %>% 
  filter(
    psychsyn > 0
  )



data %>% ggplot(aes(avgstr_no_reverse)) + geom_histogram()
data %>% ggplot(aes(scale(avgstr_reverse))) + geom_histogram()
data %>% ggplot(aes(avgstr_no_reverse)) + geom_histogram()
data %>% ggplot(aes(scale(avgstr_reverse))) + geom_histogram()
data %>% ggplot(aes(scale(avgstr_no_reverse_biis))) + geom_histogram()
data %>% ggplot(aes(scale(avgstr_reverse_biis))) + geom_histogram()

 
# Screen 2 ----------------------------------------------------
### Three standard deviations from the mean of the data: longstring, duration

cut <- 3.5
data <-
  data %>%
  filter(
    
    longstr_reverse < mean(data$longstr_reverse) + (cut * sd(data$longstr_reverse)),          # Longsting outliers
    longstr_no_reverse < mean(data$longstr_no_reverse) + (cut * sd(data$longstr_no_reverse)), 
    
    avgstr_no_reverse < mean(data$avgstr_no_reverse) + (cut * sd(data$avgstr_no_reverse)), 
    avgstr_reverse < mean(data$avgstr_reverse) + (cut * sd(data$avgstr_reverse)),
    
    avgstr_reverse_biis < mean(data$avgstr_reverse_biis) + (cut * sd(data$avgstr_reverse_biis)),          # Longsting outliers
    avgstr_no_reverse_biis < mean(data$avgstr_no_reverse_biis) + (cut * sd(data$avgstr_no_reverse_biis)), 
    
    avgstr_reverse_mcarm < mean(data$avgstr_reverse_mcarm) + (cut * sd(data$avgstr_reverse_mcarm)),          # Longsting outliers
    avgstr_no_reverse_mcarm < mean(data$avgstr_no_reverse_mcarm) + (cut * sd(data$avgstr_no_reverse_mcarm)), 
    
    avgstr_no_reverse_scc < mean(data$avgstr_no_reverse_scc) + (cut * sd(data$avgstr_no_reverse_scc)),          # Longsting outliers
    avgstr_reverse_scc < mean(data$avgstr_reverse_scc) + (cut * sd(data$avgstr_reverse_scc)),          # Longsting outliers
    
    `Duration (in seconds)` > mean(data$`Duration (in seconds)`) - (2.5 * sd(data$`Duration (in seconds)`))
  )


