
# Remove outliers

### While the original exclusion criteria allowed for
### members of the US Public Health Service and 
### Korean war era to serve, only 2 respondents were from the
### public health service and one from the Korean War era. 
### As these variables will be included in the regression
### model for Chapter 2, these respondents will be removed 
### from the data.



# Account 1 -----------------------------------------------------------------
n_original <- nrow(data)

# Filter ------------------------------------------------------------------
data <-
  data %>% 
  filter(
    
    # Only 2 US Public Health Service
    ## Can affect interpretation of Branch coefficients:
    branch_public_health == 0,
    
    # Only 1 korean war vet 
    service_era_korea == 0,
    
    # Remove MIOS outliers
    mios_total <= 43,
    
    # Remove WIS Outliers
    wis_total >= 58
    
    )

# Race can be added to model as dichotomouc white/non-white
# Will not put branch_multiple in the model

## Message:
message(paste(n_original - nrow(data),'cases removed as outliers.'))

## Clean up:
rm(n_original)
