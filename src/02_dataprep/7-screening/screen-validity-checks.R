
# 1 validity check item; Inconsistencies across demographic items; Free response screening


data_start <- data


# Label:
data <- 
  data %>% 
  mutate(air_force_warrant_officer = ifelse(branch == 'Air Force' & warrant_officer == 1, 1, 0)) # Air Force Warrant Officers

data <- 
  data %>% 
  mutate(warrant_officer_years = ifelse(warrant_officer == 1 & years_service < 8, 1, 0)) # Warrant Officer with too few years of service



data <-
  data %>% 
  filter(
    
    branch_none == 0,                     # Branch: Did not serve
    validity_check_1 == 1,                # Failed Validity checks
    air_force_warrant_officer == 0,       # No warrant officers in the Air Force
    warrant_officer_years == 0,           # Becoming a warrant officer takes longer than 5 years
    
  )



## These are again, I think, are fairly uncontroversial removals.
## Respondents were inconsistent between answers in ways that are implausible
## or impossible. 

## PhD Under 25 years old
data <-
  data %>% 
  filter(education == 'Doctorate', years_of_age > 25) %>% 
  bind_rows(data %>% filter(education != 'Doctorate'))

## Reached E-7 to E-9 in under 6 years
data <-
  data %>% 
  filter(highest_rank == 'E-7 to E-9', years_service > 5) %>% 
  bind_rows(data %>% filter(highest_rank != 'E-7 to E-9'))

## Invalid years of service
data <-
  data %>% 
  filter(years_service < 50, years_separation < 130,
         years_of_age < 100, validity_years > -5, age_enlisted < 60
  )

## Invalid MOS Free Response
data <-
  data %>% 
  filter(  
    ResponseId != 'R_DIuctUzEpM5pXQR',   # R_DIuctUzEpM5pXQR Dont know [mos], Army 8 years service, 15 years separated
    ResponseId != 'R_3qwzDFSzxJtD1S8'   # R_3qwzDFSzxJtD1S8 Years active 1990
  )






# Label Exclusion Reasons -------------------------------------------------

data_exclusions <-
  update_exclusions(data_start,
                    data = data,
                    data_exclusions = data_exclusions,
                    exclusion_reason_string = 'Invalid responses')
