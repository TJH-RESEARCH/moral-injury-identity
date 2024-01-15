

message('Screening invalid responses...')

# Load Functions ----------------------------------------------------------
source(here::here('src/01_config/functions/function-select-scales.R'))
source(here::here('src/01_config/functions/function-reorder-data.R'))
source(here::here('src/01_config/functions/function-undo-reverse-codes.R'))
source(here::here('src/01_config/functions/function-calculate-longstring.R'))
source(here::here('src/01_config/functions/function-calculate-longstring-again.R'))


# Additional Screening Criteria  -------------------

## Air Force Warrant Officer
data <- data %>% mutate(air_force_warrant_officer = ifelse(branch == 'Air Force' & warrant_officer == 1, 1, 0)) # Air Force Warrant Officers

## Warrant Officer with too few years of service
data <- data %>% mutate(warrant_officer_years = ifelse(warrant_officer == 1 & years_service < 8, 1, 0))

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

## Psychometric Synonyms/Antonyms ------------------------------------------------
data <-
  data %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychsyn = careless::psychsyn(., critval = 0.7)) %>% 
  bind_cols(data)

data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% # Before recoding, higher correlation indicates less attention/carefullness
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychant = careless::psychant(., critval = -0.55, diag = FALSE)) %>% 
  bind_cols(data)


## Longstring ------------------------------------------------
data <- data %>% calculate_longstring()

# ----------------------------------------------------------------------------#

# SCREEN RESPONSES

# Save copies of the original data and the data scrubbed by Qualtrics --------
data_original <- data %>% mutate(d_sq_flagged = NA, d_sq = NA)

data_scrubbed_qualtrics <- data %>% 
  filter(Progress == 100,
         term == 'Scrubbed' |
           term == 'Scrubbed Out' |
           term == 'scrubbed'
  )


longstring_cut <- .8

# Screen 1 ------------------------------------------
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
    `Duration (in seconds)` > 300,
    
    ## Even-Odd Consistency
    evenodd <= -.3,
    
    ## Longstring by scale
    longstr_reverse_biis < (longstring_cut * 17),         # BIIS = 17 items total - <15
    longstr_no_reverse_biis < (longstring_cut * 17),
    longstr_reverse_mcarm < (longstring_cut * 19),        # MCARM = 21 items - <19
    longstr_no_reverse_mcarm < (longstring_cut * 19),
    longstr_reverse_scc < (longstring_cut * 12),          # SCC = 12 items - <10
    longstr_no_reverse_scc < (longstring_cut * 12)
  )

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
             
             evenodd > -0.30 ~ 'Even odd inconsistency',
             
             longstr_reverse_biis >= (longstring_cut * 17) | longstr_no_reverse_biis >= (longstring_cut * 17) | 
               longstr_reverse_mcarm >= (longstring_cut * 21) | longstr_no_reverse_mcarm >= (longstring_cut * 21) | 
               longstr_reverse_scc >= (longstring_cut * 12) | longstr_no_reverse_scc >= (longstring_cut * 12) ~ 'Straightlining',
             
             .default = "Not excluded 1"))


# Recalculate Indices ------------------------------------------------------
# with partially cleaned data


## Mahalanobis Distance (D) ---- 
#data <-
#  data %>% # Recalculate the indices with the partially cleaned data
#  select_scales() %>% 
#  #select(!starts_with('scc')) %>% # Including the SCC produces an era for singularity 
#  mutate(careless::mahad(x = ., 
#                            plot = FALSE, 
#                            flag = TRUE, 
#                            confidence = 0.999, 
#                            na.rm = TRUE)) %>% 
#  rename(d_sq_flagged = flagged) %>%
#  bind_cols(data)



## Longstring ---- 
data <- data %>% calculate_longstring_again()


# Screen 2 ----------------------------------------------------
### Three standard deviations from the mean of the data: longstring, duration

cut <- 3
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


data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>% 
  anti_join(data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 
           case_when(
             
             `Duration (in seconds)` <= mean(data$`Duration (in seconds)`) - 
               (3 * sd(data$`Duration (in seconds)`)) ~ "Response time",
             
             .default = 'Average String')) %>% 
  bind_rows(data_scrubbed_researcher)



# Screen 3 ------------------------------------------------


## Psychometric Synonyms ---- 
data <-
  data %>% 
  select_scales() %>% 
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychsyn = careless::psychsyn(., critval = 0.6)) %>% 
  bind_cols(data %>% select(!psychsyn))


## Psychometric Antonyms ---- 
data <-
  data %>% 
  select_scales() %>% 
  undo_reverse_codes() %>% # Before recoding, higher correlation indicates less attention/carefullness
  select(!contains('mios'), !contains('m2cq')) %>%
  transmute(psychant = careless::psychant(., critval = -0.5, diag = FALSE)) %>% 
  bind_cols(data %>% select(!psychant))

# Filter by Psychometric Synonym/Antonym
data <-
  data %>% 
  filter(
    psychsyn > 0.15,
    psychant < -0.15
  )


data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>%
  anti_join(data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId')) %>%
  mutate(exclusion_reason = 'Psychometric synonym/antonym inconsistency') %>% 
  bind_rows(data_scrubbed_researcher)



# Screen 4 -------------------------------------------
#data <- data %>% 
#  filter(d_sq_flagged == FALSE)

data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>%
  anti_join(data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId')) %>%
  mutate(exclusion_reason = 'Multivariate Outlier') %>%
  bind_rows(data_scrubbed_researcher)


# Screen 5 -------------------------------------
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

## PhD Under 28
data <-
  data %>% 
  filter(education == 'Doctorate', years_of_age > 28) %>% 
  bind_rows(data %>% filter(education != 'Doctorate'))

## Reached E-7 to E-9 in under 7 years
data <-
  data %>% 
  filter(highest_rank == 'E-7 to E-9', years_service > 6) %>% 
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


data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>% 
  anti_join(data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId')) %>% 
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
  bind_rows(data_scrubbed_researcher)



# IRV -------------------------------------------------------------------------

data <-
  data %>% 
  select_scales() %>% 
  careless::irv(split = T, num.split = 3) %>% 
  tibble() %>% 
  bind_cols(data)

data <- 
  data %>%
    filter(
    
      irvTotal < mean(data$irvTotal) + (cut * sd(data$irvTotal)),
      irv1 < mean(data$irv1) + (cut * sd(data$irv1)), 
      irv2 < mean(data$irv1) + (cut * sd(data$irv2)), 
      irv3 < mean(data$irv1) + (cut * sd(data$irv3))
    )

data_scrubbed_researcher <- 
  anti_join(data_original, data, by = c('ResponseId' = 'ResponseId')) %>% 
  anti_join(data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId')) %>% 
  mutate(exclusion_reason = 'IRV') %>% 
  bind_rows(data_scrubbed_researcher)


# Write Data --------------------------------------------------------------



# Get a copy of the one's qualtrics removed that I didnt:
data_scrubbed_researcher_not_qualtrics <-
  anti_join(data_scrubbed_researcher, data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId'))

data_scrubbed_qualtrics_not_researcher <-
  anti_join(data_scrubbed_qualtrics, data_scrubbed_researcher, by = c('ResponseId' = 'ResponseId'))

data_scrubbed_both_research_qualtrics <-
  anti_join(data_scrubbed_qualtrics, data_scrubbed_qualtrics_not_researcher, by = c('ResponseId' = 'ResponseId'))




data %>% 
  write_csv(file = here::here(paste('data/processed/data_clean.csv')))

data_original %>% 
  write_csv(file = here::here(paste('data/processed/data_unclean.csv')))

data_scrubbed_researcher_not_qualtrics %>% 
  select(ResponseId, exclusion_reason) %>% 
  write_csv(file = here::here('data/processed/IDs_to_have_Qualtrics_scrub.csv'))

data_scrubbed_researcher_not_qualtrics %>% 
  write_csv(file = here::here('data/processed/scrubbed_researcher_not_qualtrics.csv'))

data_scrubbed_qualtrics_not_researcher %>% 
  write_csv(file = here::here('data/processed/scrubbed_qualtrics_not_researcher.csv'))

# Save to env data that excludes the results scrubbed by Qualtrics
data <- anti_join(data, data_scrubbed_qualtrics, by = c('ResponseId' = 'ResponseId'))


rm(calculate_longstring, 
   calculate_longstring_again, 
   reorder_data_scales, 
   undo_reverse_codes, 
   data_scales_reordered,
   select_scales,
   cut,
   longstring_cut)
#   data_scrubbed_qualtrics, 
#   data_scrubbed_researcher, 
#   data_scrubbed_qualtrics_not_researcher, 
#   data_scrubbed_researcher_not_qualtrics)


message('Done.')