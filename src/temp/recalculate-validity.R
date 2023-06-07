
# Outlier Analysis --------------------------------------------------------

data <-
  data %>% 
  mutate(
    # Average longstring twice the standard deviation
    outlier_longstring_no_reverse2 = avgstr_no_reverse > mean(avgstr_no_reverse) + (1.5 * sd(avgstr_no_reverse)),
    outlier_longstring_reverse2 = avgstr_reverse > mean(avgstr_reverse) + (1.5 * sd(avgstr_reverse)),
    
    ## Psych Synonyms Correlation less than one and half standard deviations
    outlier_psychsyn2 = psychsyn < mean(psychsyn) - (1.5 * sd(psychsyn)),
    
    ## Psych Antonyms Correlation greater than one and half standard deviations
    outlier_psychant2 = psychant > mean(psychant) + (1.5 * sd(psychant)),
    
    ## Even-Odd Correaltion less than one and half standard deviations
    outlier_evenodd2 = evenodd < mean(evenodd) - (1.5 * sd(evenodd)),
    
    ## IRV 
    outlier_irvTotal2 = irvTotal > mean(irvTotal) + (2 * sd(irvTotal)),
    outlier_irv1b = irv1 > mean(irv1) + (2 * sd(irv1)),
    outlier_irv2b = irv2 > mean(irv2) + (2 * sd(irv2)),
    outlier_irv3b = irv3 > mean(irv3) + (2 * sd(irv3)),
    outlier_irv4b = irv4 > mean(irv4) + (2 * sd(irv4)),
    outlier_irv5b = irv5 > mean(irv5) + (2 * sd(irv5)),
    outlier_irv6b = irv6 > mean(irv6) + (2 * sd(irv6)),
    
    
    ## Duration faster than one and a half standard deviations
    outlier_duration2 = `Duration (in minutes)` < mean(`Duration (in minutes)`) - (1.5 * sd(`Duration (in minutes)`)),
    
    ## Difference in M2C-Q and M-CARM greater than 1.5 standard deviations
    outlier_mcarm_m2cq_difference2 = mcarm_m2cq_difference < mean(mcarm_m2cq_difference) - (1.5 * sd(mcarm_m2cq_difference))
    
  )




# -------------------------------------------------------------------------



# -------------------------------------------------------------------------
# Screen Responses








# Save those screened out by additional criteria ----------------------------------------------------
## This should be the opposite of the next script

data_extra_screening3 <-
  data %>% 
  filter(
    
    
      # Outliers
      outlier_longstring_reverse2 == 1 |
      outlier_longstring_no_reverse2 == 1 |
      outlier_psychsyn2 == 1 |
      outlier_psychant2 == 1 |
      outlier_evenodd2 == 1 |
      outlier_duration2 == 1 |
      outlier_mcarm_m2cq_difference2 == 1 #|
    #outlier_irvTotal == 1 |
    #outlier_irv1 == 1 |
    #outlier_irv2 == 1 |
    #outlier_irv3 == 1 |
    #outlier_irv4 == 1 |
    #outlier_irv5 == 1 |
    #outlier_irv6 == 1
    
    # Inconsistency: Children
    # inconsistent_children != 0 |
    
    # Inconsistency: Children-Age
    #  inconsistent_children_age == TRUE |
    
    # Inconsistency: Education
    # inconsistent_education == TRUE |
    
    # Inconsistency: Rank and Years of Service
    # inconsistent_rank == TRUE #|
    
    # Inconsistency: Total Years
    #invalid_years == TRUE # I am not sure about this one. Since I programmed the survey logic wrong and did not get all their years. 
    
  )

data_extra_screening4 <-
  data_extra_screening3 %>% filter(
    
    # Failed attention checks (i.e., instructed items)
    #attention_check_biis == 1 &
    #attention_check_wis == 1 &
    attention_checks < 1 &
      
      # Failed Validity checks
      validity_check_1 == 1 &
      
      # Answered honey pots
      honeypot1 == 0 &
      honeypot2 == 0 &
      honeypot3 == 0
    
  )


# Filter out screeners ----------------------------------------------------
data <-
  data %>% 
  filter(

    # Outliers
    outlier_longstring_no_reverse2 == 0,
    outlier_longstring_reverse2 == 0,
    outlier_psychsyn2 == 0,
    outlier_psychant2 == 0,
    outlier_evenodd2 == 0,
    outlier_duration2 == 0,
    outlier_mcarm_m2cq_difference2 == 0,
    #outlier_irvTotal == 0,
    #outlier_irv1 == 0,
    #outlier_irv2 == 0,
    #outlier_irv3 == 0,
    #outlier_irv4 == 0,
    #outlier_irv5 == 0,
    #outlier_irv6 == 0
    # Inconsistency: Children
    #  inconsistent_children == 0,
    
    # Inconsistency: Children-Age
    # inconsistent_children_age == FALSE,
    
    # Inconsistency: Education
    #inconsistent_education == FALSE, 
    
    # Inconsistency: Rank and Years of Service
    #inconsistent_rank == FALSE #,
    
    # Inconsistency: Total Years
    #invalid_years == FALSE
  )





