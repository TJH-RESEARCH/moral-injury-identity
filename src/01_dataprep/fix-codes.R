


# My variables are losing their labels after Base R transformations in mutate!
# Hopefully I can fix these codes in Qualtrics and not need to do any work on labels here.


# -------------------------------------------------------------------------
# Some variables are not properly coded when downloaded from the survey host.
## This script fixes the unconventional codes. It does NOT reverse code them.



data <- 
  data %>% 
  dplyr::mutate(
    
# Fix Codes: bIPF ---------------------------------------------------------

      # Set NAs
      bipf_spouse =      dplyr::if_else(bipf_spouse == 8, NA, bipf_spouse),
      bipf_children =    dplyr::if_else(bipf_children == 8, NA, bipf_children),
      bipf_family =      dplyr::if_else(bipf_family == 9, NA, bipf_family),
      bipf_friends =     dplyr::if_else(bipf_friends == 8, NA, bipf_friends),
      bipf_work =        dplyr::if_else(bipf_work == 8, NA, bipf_work),
      bipf_education =   dplyr::if_else(bipf_education == 8, NA, bipf_education),
      bipf_daily =       dplyr::if_else(bipf_daily == 10, NA, bipf_daily),
      bipf_daily =       dplyr::if_else(bipf_daily == 9, 7, bipf_daily),
      
      # Recode each 1 less
      bipf_spouse =      bipf_spouse - 1,
      bipf_children =    bipf_children - 1,
      bipf_family =      bipf_family - 1,
      bipf_friends =     bipf_friends - 1,
      bipf_work =        bipf_work - 1,
      bipf_education =   bipf_education - 1,
      bipf_daily =       bipf_daily - 1,

# Fix Codes: Education ----------------------------------------------------
      education =        dplyr::if_else(education == 4, 1, education),
      education =        dplyr::if_else(education == 6, 2, education),
      education =        dplyr::if_else(education == 7, 3, education),
      education =        dplyr::if_else(education == 8, 7, education),
      education =        dplyr::if_else(education == 10, 7, education),
      education =        dplyr::if_else(education == 12, 6, education),
      education =        dplyr::if_else(education == 13, 7, education),

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
      religious =        dplyr::if_else(religious == 5, 0, religious),
      religious =        dplyr::if_else(religious == 6, NA, religious)

  )

