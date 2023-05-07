

# -------------------------------------------------------------------------

# Rename variables  -------------------------------------------------------

data <-
  data %>% 
  rename(

      # The name of this subscale is misspelled:
       wis_interdependent_8 = wis_interdepedent_8,
       wis_interdependent_9 = wis_interdepedent_9,
       wis_interdependent_10 = wis_interdepedent_10,
       wis_interdependent_11 = wis_interdepedent_11,
       wis_interdependent_12 = wis_interdepedent_12,
       wis_interdependent_13 = wis_interdepedent_13,
       wis_interdependent_14 = wis_interdepedent_14,
       
       # Rename some variables to be more accurate
       difi_distance = difi_us_slide_1,
       difi_overlap = difi_us_slide_2,
       religious = religion,
       marital = married
  )

