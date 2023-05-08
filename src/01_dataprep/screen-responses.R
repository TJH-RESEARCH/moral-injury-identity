
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
    branch_space_force == 1 |
    
    # Branch: Did not serve
    branch_none == 1 |
        
    # Failed attention checks (i.e., instructed items)
    attn_check_1 == 'fail' |
    attn_check_2 == 'fail' |
    
    # Failed Validity checks
    validity_check_1 != 1 |
    
    # Answered honey pots
    is.na(honeypot1) == FALSE |
    is.na(honeypot2) == FALSE |
    is.na(honeypot3) == FALSE |
    
    # Inconsistency: Children
    inconsistent_children != 0 |
      
    # Inconsistency: Children-Age
    inconsistent_children_age == TRUE |
    
    # Inconsistency: Education
    inconsistent_education == TRUE |
    
    # Inconsistency: Rank and Years of Service
    inconsistent_rank == TRUE #|
    
    # Inconsistency: Total Years
    #invalid_years == TRUE # I am not sure about this one. Since I programmed the survey logic wrong and did not get all their years. 
    
    
  ) %>% 
  select(id, 
         ResponseId, 
         `Response Type`,
         attn_check_1,
         attn_check_2,
         mos,
         validity_check,
         `Duration (in minutes)`,
         air_force_warrant_officer,
         branch_space_force,
         branch_none,
         inconsistent_children,
         inconsistent_children_age,
         years_of_age,
         bipf_children,
         military_family_child,
         inconsistent_education,
         inconsistent_rank,
         validity_years,
         invalid_years,
         honeypot1,
         honeypot2,
         honeypot3
         )



# Filter out screeners ----------------------------------------------------
data <-
  data %>% 
  filter(

# No warrant officers in the Air Force
        air_force_warrant_officer == 0,
      
# Branch: Space Force
        branch_space_force != 1,
  
# Branch: Did not serve
        branch_none != 1,

# Failed attention checks (i.e., instructed items)
        is.na(attn_check_1),
        is.na(attn_check_2),
      
# Failed Validity checks
        validity_check_1 == 1,
    
# Answered honey pots
        is.na(honeypot1),
        is.na(honeypot2),
        is.na(honeypot3),
      
# Inconsistency: Children
        inconsistent_children == 0,

# Inconsistency: Children-Age
        inconsistent_children_age == FALSE,

# Inconsistency: Education
        inconsistent_education == FALSE, 
      
# Inconsistency: Rank and Years of Service
        inconsistent_rank == FALSE #,

# Inconsistency: Total Years
        #invalid_years == FALSE
)
      






      