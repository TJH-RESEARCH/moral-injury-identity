
# Remove outliers

# Print the Demographics:
demographic_representation


# Filter ------------------------------------------------------------------
data <-
  data %>% 
  filter(
    
    # Only 2 US Public Health Service
    ## Can affect interpretation of Brannch coefficients:
    branch_public_health == 0,
    
    # Only 
         service_era_korea == 0)

# Race can be added to model as dichotomouc white/non-white
# Will not put branch_multiple in the model