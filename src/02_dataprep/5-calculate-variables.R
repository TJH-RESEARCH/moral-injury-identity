
# -------------------------------------------------------------------------
# Calculate new variables



data <-
  data %>% 
  dplyr::mutate(
    


## Military Experiences: Dummies -----------------------------------------------
      military_exp_total = military_exp_combat + 
                          military_exp_noncombat +
                          military_exp_support + 
                          military_exp_peacekeeping,
    

# Create categorical variables ------------------------------------


## Branch: Multiple
    branch_multiple = ifelse(
                            (branch_air_force + 
                            branch_army + 
                            branch_coast_guard + 
                            branch_marines +
                            branch_navy +
                            branch_space_force + 
                            branch_public_health) > 1, 1, 0),


## Branch ------------------------------------------------------------------
    branch = ifelse(branch_air_force == 1, 'Air Force', NA), 
    branch = ifelse(branch_army == 1, 'Army', branch), 
    branch = ifelse(branch_coast_guard == 1, 'Coast Guard', branch), 
    branch = ifelse(branch_marines == 1, 'Marines', branch), 
    branch = ifelse(branch_navy == 1, 'Navy', branch), 
    branch = ifelse(branch_space_force == 1, 'Space Force', branch), 
    branch = ifelse(branch_public_health == 1, 'Public Health Service', branch), 
    branch = ifelse(branch_multiple == 1, 'Multiple', branch), 
    branch = factor(branch),


## Enlisted or Officer ----------------------------------------------------
      officer = dplyr::if_else(highest_rank >= 5, 1, 0),
      enlisted = dplyr::if_else(highest_rank <= 3, 1, 0),
      warrant_officer = dplyr::if_else(highest_rank == 4, 1, 0),
      
## Marital Status ---------------------------------------------------------
      never_married = dplyr::if_else(marital == 1, 1, 0),
      married = dplyr::if_else(marital == 2, 1, 0),
      divorced = dplyr::if_else(marital == 4, 1, 0),  ## NEED RECODE IN QUALTRICS
      widowed = dplyr::if_else(marital == 5, 1, 0),   ## NEED RECODE IN QUALTRICS
      
## Military Experiences ----------------------------------------------------
      military_exp_none = if_else(military_exp_total == 0, 1, 0), 

## MIOS Event Type

      mios_event_type_multiple = ifelse(mios_event_type_self +
                                 mios_event_type_other + 
                                 mios_event_type_betrayal > 1, 1, 0),
      
      mios_event_type_multiple = ifelse(mios_event_type_self +
                                    mios_event_type_other + 
                                    mios_event_type_betrayal == 0, NA, mios_event_type_multiple),

      mios_event_type = ifelse(mios_event_type_self == 1, 'Self', NA),
      mios_event_type = ifelse(mios_event_type_other == 1, 'Other', mios_event_type),
      mios_event_type = ifelse(mios_event_type_betrayal == 1, 'Betrayal', mios_event_type),
      mios_event_type = ifelse(mios_event_type_multiple == 1, 'Miultiple', mios_event_type),


## Race --------------------------------------------------------------------

      race_multiple = ifelse(
                          race_asian + 
                          race_native + 
                          race_black + 
                          race_latino +
                          race_mena + 
                          race_pacific +
                          race_white + 
                          race_other > 1, 1, 0),
      race = ifelse(race_asian == 1, "Asian", NA),
      race = ifelse(race_native == 1, "Native America", race),
      race = ifelse(race_black == 1, "Black or African American", race),
      race = ifelse(race_latino == 1, "Hispanic or Latino", race),
      race = ifelse(race_mena == 1, "Middle Eastern or North African", race),
      race = ifelse(race_pacific == 1, "Hawaiin or Pacific Islander", race),
      race = ifelse(race_white == 1, "White", race),
      race = ifelse(race_other == 1, "Other", race),
      race = ifelse(race_multiple == 1, "Multiple", race),
      race = factor(race),

## Sex ---------------------------------------------------------------------
      sex_female = dplyr::if_else(sex == 1, 1, 0),
      sex_male = dplyr::if_else(sex == 2, 1, 0),
      sex_nonbinary = dplyr::if_else(sex == 3, 1, 0),
      sex_other = dplyr::if_else(sex == 4, 1, 0),
      
## Sexual Orientation -----------------------------------------------------
      sexual_orientation_straight = dplyr::if_else(sexual_orientation == 1, 1, 0),
      sexual_orientation_gay = dplyr::if_else(sexual_orientation == 2, 1, 0),
      sexual_orientation_bi = dplyr::if_else(sexual_orientation == 3, 1, 0),
      sexual_orientation_other = dplyr::if_else(sexual_orientation == 4, 1, 0),
      
## Years of Age ------------------------------------------------------------
      years_of_age = 2023 - birth_year,


# Meta Data ----------------------------------------------------------------
## Calculate new meta data variables
      `Duration (in minutes)` = `Duration (in seconds)` / 60,


# Miscellaneous -------------------------------------------------------------


## DIFI: Combine Pictorial and Interactive ----------------------------------
### Two different versions of the DIFI were administered, 
### depending on taking the survey on a phone or computer. 
      difi_us =       dplyr::if_else(is.na(difi_us), 0, difi_us),
      difi_distance = dplyr::if_else(difi_us == 1, 0, difi_distance),
      difi_distance = dplyr::if_else(difi_us == 2, 23, difi_distance),
      difi_distance = dplyr::if_else(difi_us == 3, 69, difi_distance),
      difi_distance = dplyr::if_else(difi_us == 4, 100, difi_distance),
      difi_distance = dplyr::if_else(difi_us == 5, 125, difi_distance),
      
      difi_overlap = dplyr::if_else(difi_us == 1, 0, difi_overlap),
      difi_overlap = dplyr::if_else(difi_us == 2, 14, difi_overlap),
      difi_overlap = dplyr::if_else(difi_us == 3, 66, difi_overlap),
      difi_overlap = dplyr::if_else(difi_us == 4, 100, difi_overlap),
      difi_overlap = dplyr::if_else(difi_us == 5, 100, difi_overlap),

)

