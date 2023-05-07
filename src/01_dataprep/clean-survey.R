
# Packages -----------------------------------------------------------------
library(tidyverse)

# Read Raw Data ---------------------------------------------------------------
data <- 
  readr::read_csv(
    here::here('data/raw/Dissertation_May 5, 2023_12.59.csv')
    )


# Split military experiences ----------------------------------------------

data <-
  data %>% 
    mutate(
      
# Split Branch ------------------------------------------------------------
      branch_air_force = str_detect(branch, pattern = '1'),      
      branch_army = str_detect(branch, pattern = '2'),
      branch_coast_guard = str_detect(branch, pattern = '3'),
      branch_marines = str_detect(branch, pattern = '4'),
      branch_navy = str_detect(branch, pattern = '5'),
      branch_space_force = str_detect(branch, pattern = '6'),
      branch_public_health_service = str_detect(branch, pattern = '7'),
      branch_none = str_detect(branch, pattern = '8'),

# Split Military Experiences
      military_exp_combat = str_detect(military_experiences, pattern = '1'),
      military_exp_noncombat_deploy = str_detect(military_experiences, pattern = '2'),
      military_exp_combat_support = str_detect(military_experiences, pattern = '3'),
      military_exp_peacekeeping_deploy = str_detect(military_experiences, pattern = '4'),
      military_exp_none = str_detect(military_experiences, pattern = '5'),

# Split MIOS Event Type
      mios_event_type_self = str_detect(mios_event_type, pattern = '1'),
      mios_event_type_other = str_detect(mios_event_type, pattern = '2'),
      mios_event_type_betrayal = str_detect(mios_event_type, pattern = '3'),

# Split MIOS PTSD Symptoms ------------------------------------------------
      mios_ptsd_symptoms_nightmares = str_detect(mios_ptsd_symptoms, pattern = '1'),
      mios_ptsd_symptoms_avoid = str_detect(mios_ptsd_symptoms, pattern = '2'),
      mios_ptsd_symptoms_vigilant = str_detect(mios_ptsd_symptoms, pattern = '3'),
      mios_ptsd_symptoms_numb = str_detect(mios_ptsd_symptoms, pattern = '4'),
      mios_ptsd_symptoms_guilty = str_detect(mios_ptsd_symptoms, pattern = '5'),
      mios_ptsd_symptoms_none = str_detect(mios_ptsd_symptoms, pattern = '0'),

# Split Unmet Needs ---------------------------------------------------------
      unmet_needs_job = str_detect(unmet_needs, pattern = '1'),
      unmet_needs_housing = str_detect(unmet_needs, pattern = '2'),
      unmet_needs_healthcare = str_detect(unmet_needs, pattern = '3'),
      unmet_needs_education = str_detect(unmet_needs, pattern = '4'),
      unmet_needs_records = str_detect(unmet_needs, pattern = '5'),
      unmet_needs_physical = str_detect(unmet_needs, pattern = '6'),
      unmet_needs_mental = str_detect(unmet_needs, pattern = '7'),
      unmet_needs_legal = str_detect(unmet_needs, pattern = '8'),
      unmet_needs_financial = str_detect(unmet_needs, pattern = '9'),
      unmet_needs_none = str_detect(unmet_needs, pattern = '10'),

# Split Military Family ---------------------------------------------------
      military_family_spouse = str_detect(military_family, pattern = '1'),
      military_family_parent = str_detect(military_family, pattern = '2'),
      military_family_sibling = str_detect(military_family, pattern = '3'),
      military_family_child = str_detect(military_family, pattern = '5'),
      military_family_other = str_detect(military_family, pattern = '7'),
      military_family_none = str_detect(military_family, pattern = '8'),

# Split Employment --------------------------------------------------------------
      employment_full_time = str_detect(employment, pattern = '1'),
      employment_part_time = str_detect(employment, pattern = '2'),
      employment_irregular = str_detect(employment, pattern = '3'),
      employment_unemployed = str_detect(employment, pattern = '4'),
      employment_retired = str_detect(employment, pattern = '5'),
      employment_student = str_detect(employment, pattern = '6'),

# Split Race --------------------------------------------------------------
      race_asian = str_detect(race, pattern = '1'),
      race_native = str_detect(race, pattern = '2'),
      race_black = str_detect(race, pattern = '3'),
      race_latino = str_detect(race, pattern = '4'),
      race_mena = str_detect(race, pattern = '5'),
      race_pacific = str_detect(race, pattern = '6'),
      race_white = str_detect(race, pattern = '7'),
      race_other = str_detect(race, pattern = '8')    
)


# Grab the Labels -------------------------------------------------------------------
labels <- data[1,]

# Remove meta-data rows --------------------------------------------------
data <- data[3:nrow(data),]


# Data Types -----------------------------------------------------------------

## The meta-data rows mess up the data types. Having removed them above, 
## now I write a temporary CSV and read the data back in with the correct types.

data %>% write_csv(file = 'temp.csv')
data <- read_csv(here::here('temp.csv'))
file.remove('temp.csv')


# Re-label the data -------------------------------------------------------
labelled::var_label(data) <- as.character(labels)


# Fix Codes: MCARM ---------------------------------------------------------------
data <- 
  data %>% 
  mutate(mcarm_8 = mcarm_8 - 5,
         mcarm_9 = mcarm_9 - 5,
         mcarm_10 = mcarm_10 - 5,
         mcarm_11 = mcarm_11 - 5,
         mcarm_12 = mcarm_12 - 5,
         mcarm_13 = mcarm_13 - 5,
         mcarm_14 = mcarm_14 - 5,
         mcarm_15 = mcarm_15 - 5,
         mcarm_16 = mcarm_16 - 5,
         mcarm_17 = mcarm_17 - 5,
         mcarm_18 = mcarm_18 - 5,
         mcarm_19 = mcarm_19 - 5,
         mcarm_20 = mcarm_20 - 5,
         mcarm_21 = mcarm_21 - 5,
         
# Fix Codes: Religion ---------------------------------------------------------------
        religion = ifelse(religion == 5, 0, religion),
        religion = ifelse(religion == 6, NA, religion),

# Fix Codes: Education ----------------------------------------------------
        education = ifelse(education == 4, 1, education),
        education = ifelse(education == 6, 2, education),
        education = ifelse(education == 7, 3, education),
        education = ifelse(education == 8, 7, education),
        education = ifelse(education == 10, 7, education),
        education = ifelse(education == 12, 6, education),
        education = ifelse(education == 13, 7, education),

# Fix Codes: bIPF ---------------------------------------------------------
    
    # Set NAs
        bipf_spouse = ifelse(bipf_spouse == 8, NA, bipf_spouse),
        bipf_children = ifelse(bipf_children == 8, NA, bipf_children),
        bipf_family = ifelse(bipf_family == 9, NA, bipf_family),
        bipf_friends = ifelse(bipf_friends == 8, NA, bipf_friends),
        bipf_work = ifelse(bipf_work == 8, NA, bipf_work),
        bipf_education = ifelse(bipf_education == 8, NA, bipf_education),
        bipf_daily = ifelse(bipf_daily == 10, NA, bipf_daily),
        bipf_daily = ifelse(bipf_daily == 9, 7, bipf_daily),
    
    # Recode each 1 less
        bipf_spouse = bipf_spouse - 1,
        bipf_children = bipf_children - 1,
        bipf_family = bipf_family - 1,
        bipf_friends = bipf_friends - 1,
        bipf_work = bipf_work - 1,
        bipf_education = bipf_education - 1,
        bipf_daily = bipf_daily - 1
  )


# Fix names ---------------------------------------------------------------

data <-
  data %>% 
  rename(wis_interdependent_8 = wis_interdepedent_8,
         wis_interdependent_9 = wis_interdepedent_9,
         wis_interdependent_10 = wis_interdepedent_10,
         wis_interdependent_11 = wis_interdepedent_11,
         wis_interdependent_12 = wis_interdepedent_12,
         wis_interdependent_13 = wis_interdepedent_13,
         wis_interdependent_14 = wis_interdepedent_14
    )


# Recode Data -------------------------------------------------------------

data <-
  data %>% 
  
  # Rename some variables to be more accurate
  
    rename(difi_distance = difi_us_slide_1,
           difi_overlap = difi_us_slide_2,
           religious = religion,
           marital = married) %>% 
  
  
  # Calculate recoded variables
  
    dplyr::mutate(
    
      # Meta Data
      `Duration (in minutes)` = `Duration (in seconds)` / 60,
      
      ## DIFI - Combine Pictorial and Interactive
      
      difi_us = ifelse(is.na(difi_us), 0, difi_us),
      difi_distance = ifelse(difi_us == 1, 0, difi_distance),
      difi_distance = ifelse(difi_us == 2, 23, difi_distance),
      difi_distance = ifelse(difi_us == 3, 69, difi_distance),
      difi_distance = ifelse(difi_us == 4, 100, difi_distance),
      difi_distance = ifelse(difi_us == 5, 125, difi_distance),
      
      difi_overlap = ifelse(difi_us == 1, 0, difi_overlap),
      difi_overlap = ifelse(difi_us == 2, 14, difi_overlap),
      difi_overlap = ifelse(difi_us == 3, 66, difi_overlap),
      difi_overlap = ifelse(difi_us == 4, 100, difi_overlap),
      difi_overlap = ifelse(difi_us == 5, 100, difi_overlap),
  
      n_deploy = ifelse(is.na(n_deploy), 0, n_deploy),
  
      ## Sex
      sex_female = ifelse(sex == 1, 1, 0),
      sex_male = ifelse(sex == 2, 1, 0),
      sex_nonbinary = ifelse(sex == 3, 1, 0),
      sex_other = ifelse(sex == 4, 1, 0),
      
      ## Sexual Orientation
      sexual_orientation_straight = ifelse(sexual_orientation == 1, 1, 0),
      sexual_orientation_gay = ifelse(sexual_orientation == 2, 1, 0),
      sexual_orientation_bi = ifelse(sexual_orientation == 3, 1, 0),
      sexual_orientation_other = ifelse(sexual_orientation == 4, 1, 0),
      
      ## Marital Status
      never_married = ifelse(marital == 1, 1, 0),
      married = ifelse(marital == 2, 1, 0),
      divorced = ifelse(marital == 4, 1, 0),  ## NEED RECODE IN QUALTRICS
      widowed = ifelse(marital == 5, 1, 0),   ## NEED RECODE IN QUALTRICS
      
      ## Enlisted or Officer
      officer = ifelse(highest_rank >= 5, 1, 0),
      enlisted = ifelse(highest_rank <= 3, 1, 0),
      warrant_officer = ifelse(highest_rank == 4, 1, 0),
      
      ## Years of Age
      years_of_age = 2023 - birth_year,
      
      # Reverse Code BIIS-2
      biis_5 = 6 - biis_5,
      biis_6 = 6 - biis_6,
      biis_7 = 6 - biis_7,
      biis_8 = 6 - biis_8,
      biis_9 = 6 - biis_9,
      biis_10 = 6 - biis_10,
      biis_16 = 6 - biis_16,
      biis_17 = 6 - biis_17,
      
      
      ## reverse-coding is not the same as multiplying by -1
      ## instead, subtract the coded score from 1+ the highest answer
      ## 2 on a 1 to 5 scale becomes a 4. 1 become
      # M-CARM rescore
      mcarm_5 = 6 - mcarm_5,
      mcarm_8 = 6 - mcarm_8,
      mcarm_9 = 6 - mcarm_9,
      mcarm_11 = 6 - mcarm_11,
      mcarm_12 = 6 - mcarm_12,
      mcarm_13 = 6 - mcarm_13,
      mcarm_14 = 6 - mcarm_14,
      mcarm_15 = 6 - mcarm_15,
      mcarm_16 = 6 - mcarm_16,
      mcarm_17 = 6 - mcarm_17,
      mcarm_18 = 6 - mcarm_18,
      mcarm_19 = 6 - mcarm_19,
      mcarm_21 = 6 - mcarm_21,
      
      # SCC Recode
      ## All SCC items except 6 and 11 are reverse-scored
      
      scc_1 = 6 - scc_1,
      scc_2 = 6 - scc_2,
      scc_3 = 6 - scc_3,
      scc_4 = 6 - scc_4,
      scc_5 = 6 - scc_5,
      scc_7 = 6 - scc_7,
      scc_8 = 6 - scc_9,
      scc_9 = 6 - scc_9,
      scc_10 = 6 - scc_10,
      scc_12 = 6 - scc_12,
      
      
      # Reverse Code M-CARM
      
      wis_private_5 = 5 - wis_private_5,
      wis_private_7 = 5 - wis_private_7,
      wis_connection_15 = 5 - wis_connection_15,
      wis_connection_16 = 5 - wis_connection_16,
      wis_connection_17 = 5 - wis_connection_17,
      wis_centrality_21 = 5 - wis_centrality_21,
      wis_centrality_23 = 5 - wis_centrality_23,
      wis_centrality_24 = 5 - wis_centrality_24,
      wis_skills_30 = 5 - wis_skills_30,
      
  ) %>% 
    
    # Sum Sub-Scales ----------------------------------------------------------
  
  dplyr::mutate(
    
    # BIIS-2 Sub Scales
    
    biis_harmony = 
      biis_1 +
      biis_2 +
      biis_3 +
      biis_4 +
      biis_5 +
      biis_6 +
      biis_7 +
      biis_8 +
      biis_9 +
      biis_10,
    
    biis_blendedness = 
      biis_11 +
      biis_12 +
      biis_13 +
      biis_14 +
      biis_15 +
      biis_16 +
      biis_17,
    
    # BIIS-2 Total
    biis_total = 
      biis_harmony + 
      biis_blendedness, 
    
    # b-IPF Total
    bipf_total = 
      bipf_spouse +
      bipf_children +
      bipf_family +
      bipf_friends +
      bipf_work +
      bipf_education +
      bipf_daily,
    
    # Civilian Identity Commitment Total
    
    civilian_commit_total = 
      civilian_commit_1 + 
      civilian_commit_2 +
      civilian_commit_3 +
      civilian_commit_4,
    
    # M2C-Q Total
    m2cq_total = 
      m2cq_1 +
      m2cq_2 +
      m2cq_3 +
      m2cq_4 +
      m2cq_5 +
      m2cq_6 +
      m2cq_7 +
      m2cq_8 +
      m2cq_9 +
      m2cq_10 +
      m2cq_11 +
      m2cq_12 +
      m2cq_13 +
      m2cq_14 +
      m2cq_15 +
      m2cq_16,
    
    # M-CARM Subscales
    mcarm_purpose_connection = 
      mcarm_1 + 
      mcarm_2 + 
      mcarm_3 + 
      mcarm_4 +
      mcarm_5 + 
      mcarm_6,
    
    mcarm_help_seeking =
      mcarm_7 + 
      mcarm_8 + 
      mcarm_9 +
      mcarm_10,
    
    mcarm_beliefs_about_civilians =
      mcarm_11 + 
      mcarm_12 + 
      mcarm_13,
    
    mcarm_resentment_regret =
      mcarm_14 + 
      mcarm_15 +
      mcarm_16,
    
    mcarm_regimentation = 
      mcarm_17 +
      mcarm_18 +
      mcarm_19 +
      mcarm_20 +
      mcarm_21, 
    
    # M-CARM Total
    
    mcarm_total =
      mcarm_purpose_connection +
      mcarm_help_seeking + 
      mcarm_beliefs_about_civilians +
      mcarm_resentment_regret +
      mcarm_regimentation,
    
    # MIOS Sub Scales
    
    mios_shame = 
      mios_1 +
      mios_3 +
      mios_7 +
      mios_8 +
      mios_12 +
      mios_13 +
      mios_14,
    
    mios_trust = 
      mios_2 +
      mios_4 +
      mios_5 +
      mios_6 +
      mios_9 +
      mios_10 +
      mios_11,
    
    # MIOS Total
    
    mios_total =
      mios_shame + 
      mios_trust,
    
    
    # SCC Total
    
    scc_total =
      scc_1 +
      scc_2 +
      scc_3 +
      scc_4 +
      scc_5 +
      scc_6 +
      scc_7 +
      scc_8 +
      scc_9 +
      scc_10 +
      scc_11 +
      scc_12,
    
    
    # Unmet Needs ---------------------------------------------------------
    unmet_needs_total =
      unmet_needs_job +
      unmet_needs_housing +
      unmet_needs_healthcare +
      unmet_needs_education +
      unmet_needs_records + 
      unmet_needs_physical +
      unmet_needs_mental +
      unmet_needs_legal +
      unmet_needs_financial,
    
    
    # WIS Scales
    
    wis_private_regard_total =
      wis_private_1 +
      wis_private_2 +
      wis_private_3 +
      wis_private_4 +
      wis_private_5 +
      wis_private_6 +
      wis_private_7,
    
    wis_interdependent_total = 
      wis_interdependent_8 +
      wis_interdependent_9 +
      wis_interdependent_10 +
      wis_interdependent_11 +
      wis_interdependent_12 +
      wis_interdependent_13 +
      wis_interdependent_14,
    
    wis_connection_total =
      wis_connection_15 +
      wis_connection_16 +
      wis_connection_17,
    
    wis_family_total = 
      wis_family_18 +
      wis_family_19 +
      wis_family_20,
    
    wis_centrality_total =
      wis_centrality_21 +
      wis_centrality_22 +
      wis_centrality_23 +
      wis_centrality_24,
    
    wis_public_regard_total =
      wis_public_25 +
      wis_public_26 +
      wis_public_27 +
      wis_public_28,
    
    wis_skills_total =
      wis_skills_29 +
      wis_skills_30 +
      wis_skills_31,
    
    
    
    
    discharge_reason = factor(discharge_reason,
                              levels = c(1:4),
                              labels = c('Voluntary Discharge',
                                         'Medical Discharge',
                                         'Service Completed',
                                         'Other')
    ),
    
    
    education = factor(education,
                       levels = c(1:7),
                       labels = c('high school',
                                  'some college',
                                  'associates',
                                  'bachelors',
                                  'masters',
                                  'professional',
                                  'doctorate')
    ),
    
    
    highest_rank = factor(highest_rank,
                          levels = c(1:7),
                          labels = c('E-1 to E-3',
                                     'E-4 to E-6',
                                     'E-7 to E-9',
                                     'W-1 to CW-5',
                                     'O-1 to O-3',
                                     'O-4 to O-6',
                                     'O-7 to O-10')
                          
    ),
    
    job_like_military = factor(job_like_military,
                               levels = c(1:4), 
                               labels = c('Not similar at all',
                                          'A little similar',
                                          'Moderately simiar',
                                          'Very similar')
                               
    ),
    
    marital = factor(marital,
                     levels = c(1, 2, 4, 5),
                     labels = c('Never married', 
                                'Married or living with a partner', 
                                'Divorced/Separated', 
                                'Widowed')
                     
    ),
    
    politics = factor(politics,
                      levels = c(1:6),
                      labels = c('Left', 
                                 'Leaning left', 
                                 'Center', 
                                 'Leaning right', 
                                 'Right', 
                                 "None/Don't know")
                      
    ),
    
    religious = factor(religious,
                      levels = c(1, 0, -99),
                      labels = c('Yes', 
                                 'No', 
                                 'Unsure')
    ),
    
    sex = factor(sex,
                 levels = c(1:4),
                 labels = c('female', 
                            'male', 
                            'nonbinary', 
                            'other')
    ),
    
    
    worship = factor(worship,
                     levels = (1:5),
                     labels = c('never', 
                                'rarely', 
                                'at least once a year', 
                                'often but not every week', 
                                'weekly')
    )
    
    
    
)


# Screening ---------------------------------------------------------------

data_screened_out <- 
  data %>% 
    filter(`Response Type` == "Screened Out")

data_no_consent <- 
  data %>% 
  filter(`Response Type` == "Did not consent")

  
data <- 
  data %>% 
    filter(`Response Type` == "Completed Survey")


# Additional Screeners ----------------------------------------------------

data <-
  data %>%
  mutate(
    
    # There are no warrant officers in the Air Force
    validity_air_force_warrant_officer = 
      ifelse(branch == 1 & warrant_officer, 1, 0),
    
    # Cannot report more years than age
    ## need to work on this
    
    )

    # Report having children to one question, having no children in another
data <- 
  data %>% 
    mutate(
      inconsistent_children =
        is.na(bipf_children) & 
        military_family_child == 1
  )



# Reaches E-7 to E-9 rank in under seven years
data %>% 
  select(highest_rank, years_service) %>% print(n = 500)

data <- 
  data %>% 
    mutate(
      inconsistent_rank = 
        highest_rank == 'E-7 to E-9' & years_service < 7
    )




# Filter out screeners ----------------------------------------------------

# No warrant officers in the Air Force
data <-
  data %>% 
  filter(
    validity_air_force_warrant_officer == 0
  )
  
# No Space Force
data %>% 
  filter(branch_space_force == 1)

data <- 
  data %>% 
  filter(branch_space_force != 1)

    
# failed attention checks
data %>% 
  filter(attn_check_1 == 'fail' |
         attn_check_2 == 'fail')

data <-
data %>% 
  filter(is.na(attn_check_1) & is.na(attn_check_2))


# Failed Validity checks
data %>% 
  filter(validity_check_1 != 1)

data <-
  data %>% 
  filter(validty_check_1 == 1)


# Answered honey pots

data %>% 
  filter(!is.na(honeypot1) | !is.na(honeypot2) | !is.na(honeypot3))

data <- 
  data %>% 
  filter(is.na(honeypot1) & is.na(honeypot2) & is.na(honeypot3))


# Were inconsistent in reporting of having children
  
data %>% 
  filter(inconsistent_children == 1)
  
data <- 
  data %>% 
    filter(inconsistent_children != 1)
  
  
# Reaches E-7 in under 7 years
data %>% 
  filter(inconsistent_rank == TRUE)

data <-
  data %>% 
  filter(inconsistent_rank != TRUE)
  
# -------------------------------------------------------------------------


# You can use dplyr::select( to choose which columns you want to use and 
# you specify their length in the factors argument.
# You actually don't want to subset one scale at a time because
# evenodd consistency should be calculated across different scales 
# in your entire battery. It is just important to specify in the factors
# argument where the cut-off are.

data <-
  data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness') |
           starts_with('m2cq_') & 
           !ends_with('total') |
           starts_with('mcarm_') & 
           !ends_with('total') & 
           !ends_with('connection') &
           !ends_with('seeking') & 
           !ends_with('civilians') &
           !ends_with('regret') & 
           !ends_with('regimentation') |
           starts_with('mios') &
           !ends_with('total') &
           !ends_with('shame') &
           !ends_with('trust') &
           !contains('type') &
           !ends_with('screener') &
           !contains('symptoms') &
           !ends_with('worst') &
           !ends_with('criterion_a')|
           starts_with('scc_') & 
           !ends_with('total') |
           starts_with('wis_') & 
           !ends_with('total')) %>%
  careless::evenodd(factors = c(17, 16, 21, 14, 12, 31) # The length of the scales
  ) %>% 
  tibble() %>% 
  rename(evenodd = '.') %>% 
  bind_cols(data)



View(data)


# WORKING -----------------------------------------------------------------




# Check that the years are logically valid
data %>% 
  select(years_of_age,
         years_active,
         years_since_sep,
         years_service,
         years_separation,
         years_reserve
         ) %>% 
  mutate(
    validity_years = 
      years_of_age - 
        17 - 
        years_service - 
        years_separation - 
        years_active -
        years_reserve
                
    )







  
# Straightlining

### Longest consecutive run of same answer
data %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  bind_cols(data)

## Longstring might not work if the respondents get the questions in random order...
## The MIOS is not random


# Intra-individual Response Variability (IRV)
## "standard deviation of responses across 
## a set of consecutive item responses for an individual" (Dunn et al. 2018).
## https://cran.r-project.org/web/packages/careless/careless.pdf




## Split calculates this across the data when split into crude groups

data %>% 
  careless::irv() %>% 
  tibble() %>% 
  rename(irv = '.') %>% 
  bind_cols(data)
  
data %>% 
  careless::irv(split = TRUE, num.split = 5)

## should remove metadata to calculate IRV
data %>% 
  select(-c(StartDate,
            EndDate,
            Status,
            Progress,
            `Duration (in seconds)`,
            `Duration (in minutes)`,
            Finished,
            RecordedDate,
            ResponseId,
            DistributionChannel,
            UserLanguage,
            Q_RelevantIDDuplicate,
            Q_RecaptchaScore,
            Q_RelevantIDDuplicate,
            Q_RecaptchaScore,
            Q_RelevantIDFraudScore,
            Q_RelevantIDLastStartDate,
            Q_RelevantIDDuplicateScore,
            Q_BallotBoxStuffing,
            LS,
            PS,
            `Response Type`)) %>% 
  careless::irv(split = TRUE, num.split = 5)




# Careless on BIIS-2

data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness')
         ) %>%  
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_biis = longstr,
         avgstr_biis = avgstr)

data %>% 
  select(starts_with('biis_') & 
          !ends_with('total') & 
          !ends_with('harmony') &
          !ends_with('blendedness')
           ) %>% 
  careless::irv() %>% 
  tibble() %>% 
  rename(irv_biis = '.')



# Careless on SCC
data %>% 
  select(starts_with('scc_') & !ends_with('total')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_scc = longstr,
         avgstr_scc = avgstr)

data %>% 
  select(starts_with('scc_') & !ends_with('total')) %>% 
  careless::irv() %>% 
  tibble() %>% 
  rename(irv_scc = '.')

# Careless on M2C-Q
data %>% 
  select(starts_with('m2cq_') & !ends_with('total')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_m2cq = longstr,
         avgstr_m2cq = avgstr)

data %>% 
  select(starts_with('m2cq_') & !ends_with('total')) %>% 
  careless::irv() %>% 
  tibble() %>% 
  rename(irv_mcarm = '.')

# Careless on M-CARM
data_mcarm <-
  data %>% 
  select(starts_with('mcarm_') & 
           !ends_with('total') & 
           !ends_with('connection') &
           !ends_with('seeking') & 
           !ends_with('civilians') &
           !ends_with('regret') & 
           !ends_with('regimentation'))

data_mcarm %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_mcarm = longstr,
         avgstr_mcarm = avgstr)

data_mcarm %>% 
  careless::irv() %>% 
  tibble() %>% 
  rename(irv_mcarm = '.')


# Careless on WIS?
data %>% 
  select(starts_with('wis_') & !ends_with('total')) %>% 
  careless::irv() %>% 
  tibble() %>% 
  rename(irv_wis = '.')

data %>% 
  select(starts_with('wis_') & !ends_with('total')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_wis = longstr,
         avgstr_wis = avgstr)

# Careless on WIS?
data %>% 
  select(starts_with('wis_') & !ends_with('total')) %>% 
  careless::irv() %>% 
  tibble() %>% 
  rename(irv_wis = '.')

data %>% 
  select(starts_with('wis_') & !ends_with('total')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_wis = longstr,
         avgstr_wis = avgstr)

## THESE CARELESS should be done with only the items that are responded to, 
## not those that I calculate or any metadata

## Should probably also do these before recoding



# Inspect Data ------------------------------------------------------------

## Skim
data %>% 
  skimr::skim() 

### Codebook
print(tibble::enframe(sjlabelled::get_label(data)), n = 500)






# Response Times ----------------------------------------------------------

data %>% 
  select(`Duration (in minutes)`) %>% 
  #filter(`Duration (in minutes)`) %>% 
  summary()

time_boxplot <-
  data %>% 
  select(`Duration (in minutes)`) %>% 
  ggplot(aes(`Duration (in minutes)`)) +
  geom_boxplot()
  
time_histogram <-
  data %>% 
  select(`Duration (in minutes)`) %>% 
  ggplot(aes(`Duration (in minutes)`)) +
  geom_histogram()

library(patchwork)

time_histogram / time_boxplot

# Is response time a function of age?
lm(`Duration (in minutes)` ~ years_of_age, data) %>% summary()



# How representative is my data? ------------------------------------------


## Branch
data %>% 
  mutate(branch = factor(branch,
                         levels = c(1:8),
                         labels = c(
                           'Air Force',
                           'Army',
                           'Coast Guard',
                           'Marines',
                           'Navy',
                           'Space Force',
                           'US Public Health Service',
                           'I have not served in the military'
                         ))) %>%
  group_by(branch) %>% 
  count(sort = T)
            
## Education
data %>% 
  group_by(education) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100)

## Race
data %>% 
  select(starts_with('race')) %>% 
  mutate(race = factor(race),
         race = fct_recode(race,
          'Asian' = '1',
          'Native' = '2',
          'Black' = '3',
          'Latinx' = '4',
          'MENA' = '5',
          'Pacific' = '6', 
          'White' = '7',
          'Other' = '8',
          'Native & White' = '27')
         ) %>% print(n = 100) %>% 
  group_by(race) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100)
  
  
## Rank
data %>% 
  group_by(highest_rank) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100)


## Sex
data %>% 
  group_by(sex) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100)

  
## Sexuality
data %>% 
  mutate(sexual_orientation = factor(sexual_orientation,
                                     levels = c(1:4),
                                     labels = c('Straight',
                                                'Gay',
                                                'Bisexual',
                                                "Other"))) %>% 
  group_by(sexual_orientation) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  mutate(percent = n / sum(n) * 100)


  
  
  

# Early Hypothesis Testing ------------------------------------------------

data %>% 
  lm(mcarm_total ~ mios_total + wis_private_regard_total, data = .
    
  ) %>% summary()










  


