
# -------------------------------------------------------------------------
# Calculate new variables



data <-
  data %>% 
  dplyr::mutate(
    

# Split multiple response items into dummy variables---------------------------


## Branch: Dummies -------------------------------------------------------------
      branch_air_force =         str_detect(branch, pattern = '1'),      
      branch_army =              str_detect(branch, pattern = '2'),
      branch_coast_guard =       str_detect(branch, pattern = '3'),
      branch_marines =           str_detect(branch, pattern = '4'),
      branch_navy =              str_detect(branch, pattern = '5'),
      branch_space_force =       str_detect(branch, pattern = '6'),
      branch_public_health =     str_detect(branch, pattern = '7'),
      branch_none =              str_detect(branch, pattern = '8'),

## Employment: Dummies ---------------------------------------------------------
      employment_full_time =     str_detect(employment, pattern = '1'),
      employment_part_time =     str_detect(employment, pattern = '2'),
      employment_irregular =     str_detect(employment, pattern = '3'),
      employment_unemployed =    str_detect(employment, pattern = '4'),
      employment_retired =       str_detect(employment, pattern = '5'),
      employment_student =       str_detect(employment, pattern = '6'),

## MIOS Event Type: Dummies----------------------------------------------------
      mios_event_type_self =     str_detect(mios_event_type, pattern = '1'),
      mios_event_type_other =    str_detect(mios_event_type, pattern = '2'),
      mios_event_type_betrayal = str_detect(mios_event_type, pattern = '3'),

## MIOS PTSD Symptoms: Dummies ------------------------------------------------
      mios_ptsd_symptoms_nightmares =  str_detect(mios_ptsd_symptoms, pattern = '1'),
      mios_ptsd_symptoms_avoid =       str_detect(mios_ptsd_symptoms, pattern = '2'),
      mios_ptsd_symptoms_vigilant =    str_detect(mios_ptsd_symptoms, pattern = '3'),
      mios_ptsd_symptoms_numb =        str_detect(mios_ptsd_symptoms, pattern = '4'),
      mios_ptsd_symptoms_guilty =      str_detect(mios_ptsd_symptoms, pattern = '5'),
      mios_ptsd_symptoms_none =        str_detect(mios_ptsd_symptoms, pattern = '0'),

## Military Experiences: Dummies -----------------------------------------------
      military_exp_combat =        str_detect(military_experiences, pattern = '1'),
      military_exp_noncombat =     str_detect(military_experiences, pattern = '2'),
      military_exp_support =       str_detect(military_experiences, pattern = '3'),
      military_exp_peacekeeping =  str_detect(military_experiences, pattern = '4'),
      military_exp_none =          str_detect(military_experiences, pattern = '5'),

## Military Family: Dummies ----------------------------------------------------
      military_family_spouse =     str_detect(military_family, pattern = '1'),
      military_family_parent =     str_detect(military_family, pattern = '2'),
      military_family_sibling =    str_detect(military_family, pattern = '3'),
      military_family_child =      str_detect(military_family, pattern = '5'),
      military_family_other =      str_detect(military_family, pattern = '7'),
      military_family_none =       str_detect(military_family, pattern = '8'),

## Unmet Needs: Dummies --------------------------------------------------------
      unmet_needs_job =            str_detect(unmet_needs, pattern = '1'),
      unmet_needs_housing =        str_detect(unmet_needs, pattern = '2'),
      unmet_needs_healthcare =     str_detect(unmet_needs, pattern = '3'),
      unmet_needs_education =      str_detect(unmet_needs, pattern = '4'),
      unmet_needs_records =        str_detect(unmet_needs, pattern = '5'),
      unmet_needs_physical =       str_detect(unmet_needs, pattern = '6'),
      unmet_needs_mental =         str_detect(unmet_needs, pattern = '7'),
      unmet_needs_legal =          str_detect(unmet_needs, pattern = '8'),
      unmet_needs_financial =      str_detect(unmet_needs, pattern = '9'),
      unmet_needs_none =           str_detect(unmet_needs, pattern = '10'),

## Race: Dummies ---------------------------------------------------------------
      race_asian =           str_detect(race, pattern = '1'),
      race_native =          str_detect(race, pattern = '2'),
      race_black =           str_detect(race, pattern = '3'),
      race_latino =          str_detect(race, pattern = '4'),
      race_mena =            str_detect(race, pattern = '5'),
      race_pacific =         str_detect(race, pattern = '6'),
      race_white =           str_detect(race, pattern = '7'),
      race_other =           str_detect(race, pattern = '8'),   

    
# Create demographic categorical variables ------------------------------------

## Enlisted or Officer ----------------------------------------------------
      officer = ifelse(highest_rank >= 5, 1, 0),
      enlisted = ifelse(highest_rank <= 3, 1, 0),
      warrant_officer = ifelse(highest_rank == 4, 1, 0),
      
## Marital Status ---------------------------------------------------------
      never_married = ifelse(marital == 1, 1, 0),
      married = ifelse(marital == 2, 1, 0),
      divorced = ifelse(marital == 4, 1, 0),  ## NEED RECODE IN QUALTRICS
      widowed = ifelse(marital == 5, 1, 0),   ## NEED RECODE IN QUALTRICS
      
## Sex ---------------------------------------------------------------------
      sex_female = ifelse(sex == 1, 1, 0),
      sex_male = ifelse(sex == 2, 1, 0),
      sex_nonbinary = ifelse(sex == 3, 1, 0),
      sex_other = ifelse(sex == 4, 1, 0),
      
## Sexual Orientation -----------------------------------------------------
      sexual_orientation_straight = ifelse(sexual_orientation == 1, 1, 0),
      sexual_orientation_gay = ifelse(sexual_orientation == 2, 1, 0),
      sexual_orientation_bi = ifelse(sexual_orientation == 3, 1, 0),
      sexual_orientation_other = ifelse(sexual_orientation == 4, 1, 0),
      
## Years of Age ------------------------------------------------------------
      years_of_age = 2023 - birth_year,


# Meta Data ----------------------------------------------------------------
## Calculate new meta data variables
      `Duration (in minutes)` = `Duration (in seconds)` / 60,


# Miscellaneous -------------------------------------------------------------


## DIFI: Combine Pictorial and Interactive ----------------------------------
### Two different versions of the DIFI were administered, 
### depending on taking the survey on a phone or computer. 
      difi_us =       ifelse(is.na(difi_us), 0, difi_us),
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



)

