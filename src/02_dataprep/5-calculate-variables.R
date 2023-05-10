
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
    

# Create demographic categorical variables ------------------------------------

## Enlisted or Officer ----------------------------------------------------
      officer = dplyr::if_else(highest_rank >= 5, 1, 0),
      enlisted = dplyr::if_else(highest_rank <= 3, 1, 0),
      warrant_officer = dplyr::if_else(highest_rank == 4, 1, 0),
      
## Marital Status ---------------------------------------------------------
      never_married = dplyr::if_else(marital == 1, 1, 0),
      married = dplyr::if_else(marital == 2, 1, 0),
      divorced = dplyr::if_else(marital == 4, 1, 0),  ## NEED RECODE IN QUALTRICS
      widowed = dplyr::if_else(marital == 5, 1, 0),   ## NEED RECODE IN QUALTRICS
      
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

