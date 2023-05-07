

# -------------------------------------------------------------------------
# Some variables are not properly coded when downloaded from the survey host.
## This script fixes the unconventional codes. It does NOT reverse code them.



data <- 
  data %>% 
  dplyr::mutate(
    
# Fix Codes: bIPF ---------------------------------------------------------

      # Set NAs
      bipf_spouse =      ifelse(bipf_spouse == 8, NA, bipf_spouse),
      bipf_children =    ifelse(bipf_children == 8, NA, bipf_children),
      bipf_family =      ifelse(bipf_family == 9, NA, bipf_family),
      bipf_friends =     ifelse(bipf_friends == 8, NA, bipf_friends),
      bipf_work =        ifelse(bipf_work == 8, NA, bipf_work),
      bipf_education =   ifelse(bipf_education == 8, NA, bipf_education),
      bipf_daily =       ifelse(bipf_daily == 10, NA, bipf_daily),
      bipf_daily =       ifelse(bipf_daily == 9, 7, bipf_daily),
      
      # Recode each 1 less
      bipf_spouse =      bipf_spouse - 1,
      bipf_children =    bipf_children - 1,
      bipf_family =      bipf_family - 1,
      bipf_friends =     bipf_friends - 1,
      bipf_work =        bipf_work - 1,
      bipf_education =   bipf_education - 1,
      bipf_daily =       bipf_daily - 1,

# Fix Codes: Education ----------------------------------------------------
      education =        ifelse(education == 4, 1, education),
      education =        ifelse(education == 6, 2, education),
      education =        ifelse(education == 7, 3, education),
      education =        ifelse(education == 8, 7, education),
      education =        ifelse(education == 10, 7, education),
      education =        ifelse(education == 12, 6, education),
      education =        ifelse(education == 13, 7, education),

# Fix Codes: MCARM ---------------------------------------------------------------

      mcarm_8 =          mcarm_8 - 5,
      mcarm_9 =          mcarm_9 - 5,
      mcarm_10 =         mcarm_10 - 5,
      mcarm_11 =         mcarm_11 - 5,
      mcarm_12 =         mcarm_12 - 5,
      mcarm_13 =         mcarm_13 - 5,
      mcarm_14 =         mcarm_14 - 5,
      mcarm_15 =         mcarm_15 - 5,
      mcarm_16 =         mcarm_16 - 5,
      mcarm_17 =         mcarm_17 - 5,
      mcarm_18 =         mcarm_18 - 5,
      mcarm_19 =         mcarm_19 - 5,
      mcarm_20 =         mcarm_20 - 5,
      mcarm_21 =         mcarm_21 - 5,
         
# Fix Codes: Religion ---------------------------------------------------------------
      religious =        ifelse(religious == 5, 0, religious),
      religious =        ifelse(religious == 6, NA, religious)

  )

