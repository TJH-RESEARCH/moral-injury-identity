

# -------------------------------------------------------------------------
## Create Factors for Variables

data <-
  data %>% 
  dplyr::mutate(


# Branch: Factor ----------------------------------------------------------
          branch = factor(branch,
                         levels = c(1:8),
                         labels = c(
                           'Air Force',
                           'Army',
                           'Coast Guard',
                           'Marines',
                           'Navy',
                           'Space Force',
                           'US Public Health Service',
                           'I have not served in the military'
                         )
          ),
    
    
# Discharge Reason: Factor ------------------------------------------------
          discharge_reason = factor(discharge_reason,
                                    levels = c(1:4),
                                    labels = c('Voluntary Discharge',
                                               'Medical Discharge',
                                               'Service Completed',
                                               'Other')
          ),
          
# Education: Factor -------------------------------------------------------
          education = factor(education,
                             levels = c(1:7),
                             labels = c('high school',
                                        'some college',
                                        'associates',
                                        'bachelors',
                                        'masters',
                                        'professional',
                                        'doctorate')
          ),
          
# Highest Rank: Factor ----------------------------------------------------
          highest_rank = factor(highest_rank,
                                levels = c(1:7),
                                labels = c('E-1 to E-3',
                                           'E-4 to E-6',
                                           'E-7 to E-9',
                                           'W-1 to CW-5',
                                           'O-1 to O-3',
                                           'O-4 to O-6',
                                           'O-7 to O-10')
          ),


# Marital Status: Factor
          marital = factor(marital,
                           levels = c(1, 2, 4, 5),
                           labels = c('Never married', 
                                      'Married or living with a partner', 
                                      'Divorced/Separated', 
                                      'Widowed')
          ),


# Politics: Factor --------------------------------------------------------
          politics = factor(politics,
                            levels = c(1:6),
                            labels = c('Left', 
                                       'Leaning left', 
                                       'Center', 
                                       'Leaning right', 
                                       'Right', 
                                       "None/Don't know")
          ),


# Race: Factor ------------------------------------------------------------

          race = factor(race),
          race = fct_recode(race,
                         'Asian' = '1',
                         'Native' = '2',
                         'Black' = '3',
                         'Latinx' = '4',
                         'MENA' = '5',
                         'Pacific' = '6', 
                         'White' = '7',
                         'Other' = '8',
                         'Native & White' = '27'),

# Religious: Factor -------------------------------------------------------
          religious = factor(religious,
                             levels = c(1, 0, -99),
                             labels = c('Yes', 
                                        'No', 
                                        'Unsure')
          ),

# Sex: Factor -------------------------------------------------------------
          sex = factor(sex,
                       levels = c(1:4),
                       labels = c('female', 
                                  'male', 
                                  'nonbinary', 
                                  'other')
          ),
          
# Worship: Factor ---------------------------------------------------------
          worship = factor(worship,
                           levels = (1:5),
                           labels = c('never', 
                                      'rarely', 
                                      'at least once a year', 
                                      'often but not every week', 
                                      'weekly')
          )
          
)