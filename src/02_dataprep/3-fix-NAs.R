
# Some NAs are coded as a number



# Number of Deployments ------------------------------------------------------
### Replace NAs in number of deployments with a 0. 
### People who did not report a deployment were not asked how many
### times they deployed. For them, the number of deployments is 0.

data <-
  data %>% 
    mutate(n_deploy = dplyr::if_else(is.na(n_deploy), 0, n_deploy)) %>% 

# Replace NAs on Dummy variables with 0s -----------------------------------
  mutate(across(starts_with('branch_') | 
                starts_with('employment_') | 
                starts_with('honeypot') |
                starts_with('military_exp') |
                starts_with('military_family_') |
                starts_with('mios_') | 
                starts_with('race_') | 
                starts_with('unmet_needs_'),
                ~ dplyr::if_else(is.na(.), 0, .))) %>% 

# NAs coded as -99  -------------------------------------------------------
    mutate(across(starts_with('m2cq_') | starts_with('bipf') | religious,
           ~ dplyr::if_else(. == -99, NA, .)))





