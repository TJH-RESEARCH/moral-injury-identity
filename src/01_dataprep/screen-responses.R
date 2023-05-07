
# -------------------------------------------------------------------------
# Screen Responses

      
      

# Remove Responses that didn't pass initial screening questions ------------
data_screened_out <- 
  data %>% 
  filter(`Response Type` == "Screened Out")

data_no_consent <- 
  data %>% 
  filter(`Response Type` == "Did not consent")

data <- 
  data %>% 
  filter(`Response Type` == "Completed Survey")
      
      
# Additional Screening Criteria --------------------------------------------
      
data <-
  data %>%
      mutate(
          

# Air Force Warrant Officers ----------------------------------------------
        air_force_warrant_officer = ifelse(branch == 1 & warrant_officer, 1, 0),

# Branch: Space Force ---------------------------------------------------
        #branch_space_force

# Branch: Did not serve ---------------------------------------------------
        #branch_none

# Inconsistency: Children -------------------------------------------------
## Report having children to one question, having no children in another.
        inconsistent_children = is.na(bipf_children) & military_family_child == 1,
      
# Inconsistency: Education and Years of Age

        inconsistent_education = education == 'doctorate' & years_of_age < 26,

# Inconsistency: Rank and Years of Service --------------------------------
        inconsistent_rank = highest_rank == 'E-7 to E-9' & years_service < 7)
      
# Inconsistency: Total Years ----------------------------------------------
# Check that reported years are logically valid
data <-
  data %>% 
    mutate(
      validity_years = 
        years_of_age - 
        17 - 
        years_service - 
        years_separation,
      
      invalid_years = validity_years < 0
    )



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
    
    # Inconsistency: Education
    inconsistent_education == TRUE |
    
    # Inconsistency: Rank and Years of Service
    inconsistent_rank == TRUE |
    
    # Inconsistency: Total Years
    invalid_years == TRUE
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

# Inconsistency: Education
        inconsistent_education == FALSE, 
      
# Inconsistency: Rank and Years of Service
        inconsistent_rank == FALSE,

# Inconsistency: Total Years
        invalid_years == FALSE
)
      






      