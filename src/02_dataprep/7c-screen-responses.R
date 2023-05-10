
# -------------------------------------------------------------------------
# Screen Responses


      





# Save those screened out by additional criteria ----------------------------------------------------
## This should be the opposite of the next script

data_extra_screening <-
  data %>% 
  filter(
    
    # No warrant officers in the Air Force
    air_force_warrant_officer == 1 |
    
    # Branch: Space Force
    #branch_space_force == 1 |
    
    # Branch: Did not serve
    branch_none == 1 |
        
    # Failed attention checks (i.e., instructed items)
    attention_check_biis == 0 |
    attention_check_wis == 0 |
    
    # Failed Validity checks
    validity_check_1 == 0 |
    
    # Answered honey pots
    honeypot1 == 1 |
    honeypot2 == 1 |
    honeypot3 == 1 |
    
    # Outliers
    outlier_longstring_reverse == 1 |
    outlier_longstring_no_reverse == 1 |
    outlier_psychsyn == 1 |
    outlier_psychant == 1 |
    outlier_evenodd == 1 |
    outlier_duration == 1 |
    outlier_mcarm_m2cq_difference == 1 #|
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

data_extra_screening2 <-
  data_extra_screening %>% filter(
    
    # Failed attention checks (i.e., instructed items)
      attention_check_biis == 1 &
      attention_check_wis == 1 &
      
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

# No warrant officers in the Air Force
        air_force_warrant_officer == 0,
      
# Branch: Space Force
       # branch_space_force != 1,
  
# Branch: Did not serve
        branch_none == 0,

# Failed attention checks (i.e., instructed items)
        attention_check_biis == 1,
        attention_check_wis == 1,
      
# Failed Validity checks
        validity_check_1 == 1,
    
# Answered honey pots
        honeypot1 == 0,
        honeypot2 == 0,
        honeypot3 == 0,

# Outliers
        outlier_longstring_no_reverse == 0,
        outlier_longstring_reverse == 0,
        outlier_psychsyn == 0,
        outlier_psychant == 0,
        outlier_evenodd == 0,
        outlier_duration == 0,
        outlier_mcarm_m2cq_difference == 0,
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



      