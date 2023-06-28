
# Remove outliers

### While the original exclusion criteria allowed for
### members of the US Public Health Service and 
### Korean war era to serve, only 2 respondents were from the
### public health service and one from the Korean War era. 
### As these variables will be included in the regression
### model for Chapter 2, these respondents will be removed 
### from the data.


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
