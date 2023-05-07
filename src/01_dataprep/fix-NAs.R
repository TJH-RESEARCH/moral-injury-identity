
# Some NAs are coded as a number



# Number of Deployments ------------------------------------------------------
### Replace NAs in number of deployments with a 0. 
### People who did not report a deployment were not asked how many
### times they deployed. For them, the number of deployments is 0.

data <-
  data %>% 
    mutate(n_deploy = ifelse(is.na(n_deploy), 0, n_deploy))


# M2C-Q -------------------------------------------------------------------
## NAs are coded as 99
data <-
  data %>% 
    mutate(across(starts_with('m2cq_') & !ends_with('total'),
           ~ ifelse(. == 99, NA, .)))


# Religious ---------------------------------------------------------------
data <-
  data %>% 
  mutate(religious = ifelse(religious == -99, NA, religious))






