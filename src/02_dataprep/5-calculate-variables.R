
# -------------------------------------------------------------------------#
# Calculate new variables including categorical variables from multi-response
# Create factor variables

data <-
  data %>% 
  dplyr::mutate(

# Create categorical variables ---------------------------------------------
## Branch ------------------------------------------------------------------
    branch_multiple = 
        dplyr::if_else(
                (branch_air_force + 
                branch_army + 
                branch_coast_guard + 
                branch_marines +
                branch_navy +
                branch_space_force + 
                branch_public_health) > 1, 1, 0),
    branch = case_when(
        branch_multiple == 1 ~ 'Multiple',
        branch_air_force == 1 ~ 'Air Force',
        branch_army == 1 ~ 'Army', 
        branch_coast_guard == 1 ~ 'Coast Guard',
        branch_marines == 1 ~ 'Marines',
        branch_navy == 1 ~ 'Navy',
        branch_space_force == 1 ~ 'Space Force',
        branch_public_health == 1 ~ 'Public Health Service'), 
    branch = factor(branch),

## Disability percentage
    disability_percent = ifelse(is.na(disability_percent), 0, disability_percent),

## Discharge -------------------------------------------------------------
    discharge_reason = factor(discharge_reason, 
                              levels = c(1:4), 
                              labels = c('Voluntary Discharge',
                                         'Medical Discharge',
                                         'Service Completed',
                                         'Other'), 
                              ordered = F),
    discharge_reason = if_else(is.na(discharge_reason), 'Not yet discharged', discharge_reason),


## Education -------------------------------------------------------------
    education = factor(education, 
                       levels = c(1:7),
                       labels = c('High school diploma or equivalent',
                                  'Some college',
                                  'Associates degree',
                                  'Bachelors degree',
                                  'Masters degree',
                                  'Applied or professional doctorate',
                                  'Doctorate'),
                       ordered = T),

## Employment -------------------------------------------------------------
    employment_multiple = if_else(
                              employment_full_time + 
                              employment_part_time + 
                              employment_irregular + 
                              employment_unemployed + 
                              employment_retired + 
                              employment_student > 1, 1, 0),
    employment = case_when(
        employment_multiple == 1 ~ 'Multiple',
        employment_full_time == 1 ~ 'Full Time',
        employment_part_time == 1 ~ 'Part Time',
        employment_irregular == 1 ~ 'Irregular',
        employment_unemployed == 1 ~ 'Unemployed',
        employment_retired == 1 ~ 'Retired',
        employment_student == 1 ~ 'Student',
    ),
    employment = factor(employment),

## Enlisted or Officer ----------------------------------------------------
      officer = dplyr::if_else(highest_rank >= 5, 1, 0),
      enlisted = dplyr::if_else(highest_rank <= 3, 1, 0),
      warrant_officer = dplyr::if_else(highest_rank == 4, 1, 0),
      nonenlisted = dplyr::if_else(highest_rank > 3, 1, 0),
      rank_e1_e3 = dplyr::if_else(highest_rank == 1, 1, 0),
      rank_e4_e6 = dplyr::if_else(highest_rank == 2, 1, 0),
      rank_e7_e9 = dplyr::if_else(highest_rank == 3, 1, 0),
      rank_w1_cw5 = dplyr::if_else(highest_rank == 4, 1, 0),
      rank_o1_o3 = dplyr::if_else(highest_rank == 5, 1, 0),
      rank_o4_o6 = dplyr::if_else(highest_rank == 6, 1, 0),

## Highest Rank -----------------------------------------------------------
      highest_rank = factor(highest_rank,
                            levels = c(1:7),
                            labels = c('E-1 to E-3', 
                                       'E-4 to E-6',
                                       'E-7 to E-9',
                                       'W-1 to CW-5',
                                       'O-1 to O-3',
                                       'O-4 to O-6',
                                       'O-7 to O-10'),
                            ordered = T),

## Marital Status ---------------------------------------------------------
      never_married = dplyr::if_else(marital == 0, 1, 0),
      married = dplyr::if_else(marital == 1, 1, 0),
      divorced = dplyr::if_else(marital == 2, 1, 0),
      widowed = dplyr::if_else(marital == 3, 1, 0),
      marital = factor(marital, 
                       levels = c(0:3),
                       labels = c('Never married', 'Married', 'Divorced', 'Widowed'),
                       ordered = F),
      
## Military Experiences ----------------------------------------------------
      military_exp_total = military_exp_combat + 
        military_exp_noncombat +
        military_exp_support + 
        military_exp_peacekeeping,

      military_exp_none = if_else(military_exp_total == 0, 1, 0), 

## Military Family ---------------------------------------------------------
      military_family_total = 
        military_family_spouse +      
        military_family_parents +
        military_family_sibling +
        military_family_child +
        military_family_other,
    
## MIOS Event Type ---------------------------------------------------------
      mios_event_type_multiple = if_else(mios_event_type_self +
                                 mios_event_type_other + 
                                 mios_event_type_betrayal > 1, 1, 0),

      mios_event_type = case_when(
        mios_event_type_multiple == 1 ~ "Multiple",
        mios_event_type_self == 1 ~ "Self",
        mios_event_type_other == 1 ~ "Other",
        mios_event_type_betrayal == 1 ~ "Betrayal",
        .default = "None"),
      mios_event_type = factor(mios_event_type),
      military_family = (military_family_none - 1) * -1,

## Politics ----------------------------------------------------------------


## Race --------------------------------------------------------------------
      race_multiple = if_else(
                          race_asian + 
                          race_native + 
                          race_black + 
                          race_latino +
                          race_mena + 
                          race_pacific +
                          race_white + 
                          race_other > 1, 1, 0),
      race = case_when(
          race_multiple == 1 ~ "Multiple",
          race_asian == 1 ~ "Asian",
          race_native == 1 ~ "American Indian or Alaska Native",
          race_black == 1 ~ "Black or African American",
          race_latino == 1 ~ "Hispanic, Latino, or Spanish origin",
          race_mena == 1 ~ "Middle Eastern or North African",
          race_pacific == 1 ~ "Native Hawaiian or Other Pacific Islander",
          race_white == 1 ~ "White",
          race_other == 1 ~ "Some other race, ethnicity, or origin"
      ),
      race = factor(race),

## Sex ---------------------------------------------------------------------
      sex_female = dplyr::if_else(sex == 1, 1, 0),
      sex_male = dplyr::if_else(sex == 2, 1, 0),
      sex_nonbinary = dplyr::if_else(sex == 3, 1, 0),
      sex_other = dplyr::if_else(sex == 4, 1, 0),
      sex = factor(sex, levels = c(1:4), 
                   labels = c('female', 'male', 'non-binary', 'other'),
                   ordered = F),
      
## Sexual Orientation -----------------------------------------------------
      sexual_orientation_straight = dplyr::if_else(sexual_orientation == 1, 1, 0),
      sexual_orientation_gay = dplyr::if_else(sexual_orientation == 2, 1, 0),
      sexual_orientation_bi = dplyr::if_else(sexual_orientation == 3, 1, 0),
      sexual_orientation_other = dplyr::if_else(sexual_orientation == 4, 1, 0),
      sexual_orientation = factor(sexual_orientation, levels = c(1:4), 
                                  labels = c('straight', 'gay', 'bisexual', 'other'),
                                  ordered = F),
      
## Years of Age ------------------------------------------------------------
      years_of_age = 2023 - birth_year,


# Miscellaneous -------------------------------------------------------------

## Duration ----------------------------------------------------------------
      `Duration (in minutes)` = `Duration (in seconds)` / 60,


## DIFI: Combine Pictorial and Interactive ----------------------------------
### Two different versions of the DIFI were administered, depending on taking the survey on a phone or computer. 
      difi_us =       dplyr::if_else(is.na(difi_us), 0, difi_us),

      difi_distance = case_when(
                                difi_us == 0 ~ difi_distance,                         
                                difi_us == 1 ~ 0, 
                                difi_us == 2 ~ 23, 
                                difi_us == 3 ~ 69, 
                                difi_us == 4 ~ 100, 
                                difi_us == 5 ~ 125
      ),
      difi_overlap = case_when(
                                difi_us == 1 ~ difi_overlap,                        
                                difi_us == 1 ~ 0,
                                difi_us == 2 ~ 14,
                                difi_us == 3 ~ 66,
                                difi_us == 4 ~ 100,
                                difi_us == 5 ~ 100
      ),


# Combine the old years variable and new ----------------------------------
      years_service = if_else(years_service == '4years4months', '4.5', years_service),
      years_service = if_else(years_service == '4 1/2', '4.5', years_service),
      years_service = as.numeric(if_else(is.na(years_service), '0', years_service)),
      years_reserve_hidden = as.numeric(ifelse(is.na(years_reserve_hidden), '0', years_reserve_hidden)),
      years_service = years_service + years_reserve_hidden,
      years_separation = if_else(is.na(years_separation), 0, years_separation),

# Service Era -------------------------------------------------------------

      year_entered_military = 2023 - years_separation - years_service,
      year_left_military = 2023 - years_separation, 
      service_era_post_wwii      = if_else((year_entered_military >= 1947 & year_entered_military < 1950) | (year_left_military >= 1947 & year_left_military < 1950), 1, 0), 
      service_era_korea          = if_else((year_entered_military >= 1950 & year_entered_military < 1956) | (year_left_military >= 1950 & year_left_military < 1956), 1, 0), 
      service_era_cold_war       = if_else((year_entered_military >= 1956 & year_entered_military < 1990) | (year_left_military >= 1956 & year_left_military < 1990), 1, 0), 
      service_era_vietnam        = if_else((year_entered_military >= 1964 & year_entered_military <= 1975) | (year_left_military >= 1964 & year_left_military <= 1975), 1, 0), 
      service_era_persian_gulf   = if_else((year_entered_military >= 1990 & year_entered_military < 2001) | (year_left_military >= 1990 & year_left_military < 2001), 1, 0), 
      service_era_post_911       = if_else((year_entered_military >= 2001) | (year_left_military >= 2001), 1, 0), 
      
      service_era_multiple = if_else(
                                    service_era_post_wwii +
                                    service_era_korea +
                                    service_era_cold_war +
                                    service_era_vietnam +
                                    service_era_persian_gulf +
                                    service_era_post_911
                                    > 1, 1, 0),

      service_era = case_when(
                              service_era_post_wwii == 1 ~ "Post-WWII",
                              service_era_korea == 1 ~ "Korea", 
                              service_era_cold_war == 1 ~ "Cold War",
                              service_era_vietnam == 1 ~ "Vietnam", 
                              service_era_persian_gulf == 1 ~ "Persian Gulf: Pre-9/11", 
                              service_era_post_911 == 1 ~ "Post-9/11",
                              (service_era_multiple == 1 & service_era_cold_war == 0) ~ "Multiple"
                              ),


# Age Enlisted/Separated --------------------------------------------------
      validity_years = years_of_age - 17 - years_service - years_separation,
      invalid_years = validity_years < 0,
      age_enlisted = years_of_age - years_service - years_separation,
      age_separated = years_of_age - years_separation,


# MIOS x PTSD -------------------------------------------------------------
      trauma_type = case_when(
        mios_screener == 1 & mios_criterion_a == 1 ~ 4,
        mios_screener == 0 & mios_criterion_a == 1 ~ 3,
        mios_screener == 1 & mios_criterion_a == 0 ~ 2,
        mios_screener == 0 & mios_criterion_a == 0 ~ 1
        ),
      trauma_type = factor(trauma_type, levels = c(1:4), 
                           labels = c('No MIOS or PTSD Event',
                                     'PTSD Event without MIOS Event',
                                     'MIOS Event without PTSD Event',
                                     'MIOS and PTSD Event'))
)











