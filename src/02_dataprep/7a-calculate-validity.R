

# Additional Screening Criteria --------------------------------------------



data <-
  data %>%
  mutate(
    
    
    # Air Force Warrant Officers ----------------------------------------------
    air_force_warrant_officer = ifelse(branch_air_force == 1 & warrant_officer, 1, 0),
    
    # Branch: Space Force ---------------------------------------------------
    #branch_space_force
    
    # Branch: Did not serve ---------------------------------------------------
    #branch_none
    
    # Inconsistency: Children -------------------------------------------------
    ## Report having children to one question, having no children in another.
    inconsistent_children = is.na(bipf_children) & military_family_child == 1 | !is.na(bipf_children) & is.na(military_family_child),
    
    # Inconsistency: Children-Age
    ## Report having a child who served in the military but is under 35 years themselves
    ## Perhaps not an impossibility, but highly unlikely
    inconsistent_children_age = years_of_age < 40 & military_family_child == 1,
    
    # Inconsistency: Education and Years of Age
    inconsistent_education_years = education == 'doctorate' & years_of_age < 30,
    
    # Inconsistency: Education
    ## Reports N/A to b-IPF Education question, then 'Student' to employment
    
    inconsistent_education = is.na(bipf_education) & employment_student == 1, 
    
    # Inconsistency: Rank and Years of Service --------------------------------
    inconsistent_rank = highest_rank == 'E-7 to E-9' & years_service < 8,
    
    # Inconsistency: Religion and Worship
    
    inconsistent_religion = worship > 4 & religious == 0, 

    # Inconsistency: Total Years ----------------------------------------------
    # Check that reported years are logically valid 
    validity_years = 
      years_of_age - 
      17 - 
      years_service - 
      years_separation,
    
    invalid_years = validity_years < 0
    
    
  )



# Statistical Screeners ------------------------------------------------------

## Save a copy of the data with only the scale items (no totals, metadata, demographics)

data_scales <-
  data %>% 
  select(
    # BIIS-2
    starts_with('biis_') & 
      !ends_with('total') & 
      !ends_with('harmony') &
      !ends_with('blendedness') |
      
      # Civilian Identity Commitment
      starts_with('civilian_commit') &
      !ends_with('total') |
      
      # M2C-Q
      starts_with('m2cq_') & 
      !ends_with('mean') |
      
      # MCARM
      starts_with('mcarm_') & 
      !ends_with('total') & 
      !ends_with('connection') &
      !ends_with('seeking') & 
      !ends_with('civilians') &
      !ends_with('regret') & 
      !ends_with('regimentation') |
      
      # MIOS
      starts_with('mios') &
      !ends_with('total') &
      !ends_with('shame') &
      !ends_with('trust') &
      !contains('type') &
      !ends_with('screener') &
      !contains('symptoms') &
      !contains('events') &
      !ends_with('worst') &
      !ends_with('criterion_a')|
      
      # SCC
      starts_with('scc_') & 
      !ends_with('total') |
      
      # WIS
      starts_with('wis_') & 
      !ends_with('total')
    ) 

data_scales_no_reverse_codes <-
  data_scales %>% 
  
  # to undo the reverse coding:
  mutate(
    
    # BIIS-2: Reverse Code -------------------------------------------------
    biis_5 = -1 * (biis_5 - 6), 
    biis_6 = -1 * (biis_6 - 6),
    biis_7 = -1 * (biis_7 - 6),
    biis_8 = -1 * (biis_8 - 6),
    biis_9 = -1 * (biis_9 - 6),
    biis_10 = -1 * (biis_10 - 6),
    biis_16 = -1 * (biis_16 - 6),
    biis_17 = -1 * (biis_17 - 6),
    
    # M-CARM: Reverse Code -------------------------------------------------
    mcarm_5 = -1 * (mcarm_5 - 6),
    mcarm_8 = -1 * (mcarm_8 - 6),
    mcarm_9 = -1 * (mcarm_9 - 6),
    mcarm_11 = -1 * (mcarm_11 - 6),
    mcarm_12 = -1 * (mcarm_12 - 6),
    mcarm_13 = -1 * (mcarm_13 - 6),
    mcarm_14 = -1 * (mcarm_14 - 6),
    mcarm_15 = -1 * (mcarm_15 - 6),
    mcarm_16 = -1 * (mcarm_16 - 6),
    mcarm_17 = -1 * (mcarm_17 - 6),
    mcarm_18 = -1 * (mcarm_18 - 6),
    mcarm_19 = -1 * (mcarm_19 - 6),
    mcarm_21 = -1 * (mcarm_21 - 6),
    
    # SCC: Reverse Code ---------------------------------------------------
    ## All SCC items except 6 and 11 are reverse-scored
    scc_1 = -1 * (scc_1 - 6),
    scc_2 = -1 * (scc_2 - 6),
    scc_3 = -1 * (scc_3 - 6),
    scc_4 = -1 * (scc_4 - 6),
    scc_5 = -1 * (scc_5 - 6),
    scc_7 = -1 * (scc_7 - 6),
    scc_8 = -1 * (scc_9 - 6),
    scc_9 = -1 * (scc_9 - 6),
    scc_10 = -1 * (scc_10 - 6),
    scc_12 = -1 * (scc_12 - 6),
    
    # WIS: Reverse Code ---------------------------------------------------
    wis_private_5 = -1 * (wis_private_5 - 5),
    wis_private_7 = -1 * (wis_private_7 - 5),
    wis_connection_15 = -1 * (wis_connection_15 - 5),
    wis_connection_16 = -1 * (wis_connection_16 - 5),
    wis_connection_17 = -1 * (wis_connection_17 - 5),
    wis_centrality_21 = -1 * (wis_centrality_21 - 5),
    wis_centrality_23 = -1 * (wis_centrality_23 - 5),
    wis_centrality_24 = -1 * (wis_centrality_24 - 5),
    wis_skills_30 = -1 * (wis_skills_30 - 5)
    
  )





# Even-Odd Consistency ------------------------------------------------------
## Even-odd consistency divides each unidimensional measure 
## in two based on even and odd items. If respondents were attentive/careful,
## these two halves should correlate positively. 
## The more subscales there are in the survey, the better a measure this is. 

## If reverse scored items are in the survey, 
## they need to be reverse coded before even-odd analysis.
## Longstring should be performed twice: once with and once without the reverse coding.  

data <-
  data_scales %>%
  
  # Reorder the data. MIOS items are not sequential per unidimensional measure. 
  # This will arrange the MIOS items into the subscales, 
  # then grab everything else, which should be properly ordered. 
  
  select(
    # MIOS Shame Subscale
    mios_1, mios_3, mios_7, mios_8, mios_12, mios_13, mios_14,
    
    # MIOS Trust Subscale
    mios_2, mios_4, mios_5, mios_6, mios_9, mios_10, mios_11,
    everything()
  ) %>% 
  
  
  # Run the even-odd consistency analysis: 
  
  transmute(evenodd = careless::evenodd(x =., 
                                        # Tell how many items in each subscale
                                        # in order, so it knows where the scales are: 
                                        factors = c(7,  # MIOS Shame
                                                    7,  # MIOS Trust
                                                    10, # BIIS Harmony
                                                    7,  # BIIS Blended
                                                    4,  # Civilian Commitment
                                                    16, # M2C-Q
                                                    6,  # MCARM Purpose 
                                                    4,  # MCARM Help
                                                    3,  # MCARM Civilians
                                                    3,  # MCARM Resentment
                                                    5,  # MCARM Regimentation
                                                    12, # SCC 
                                                    7,  # WIS Private Regard
                                                    7,  # WIS Interdependent
                                                    3,  # WIS Connection
                                                    3,  # WIS Family
                                                    4,  # WIS Centrality
                                                    4,  # WIS Public Regard
                                                    3)  # WIS Skills
  )) %>% 
  bind_cols(data) # Add the results back to the original data. 




# -------------------------------------------------------------------


# Intra-individual Response Variability (also termed Inter-item Standard Deviation).
# This technique, proposed and tested by Marjanovic, Holden, Struthers, Cribbie, and Greenglass (2015), measures how much an individual strays from their own personal midpoint across a set of scale items.
# Curran 2016




# Psychometric Synonyms and Antonyms -----------------------------------------
## Finds individual-level reliability by determining which items are 
## psychometrically similar and different. The sample-level correlations
## between each possible item pair are calculated.
## The user sets a 'critical value,' then pairs with 
## positive/negative correlations of greater magnitudes than the critical value
## are determined to be synonyms/antonyms.
## Each individual respondents correlation between the set of pairs is calculated.


## First, find a suitable critical value:

data_scales %>% 
  careless::psychsyn_critval(., anto = FALSE) %>% 
  ggplot2::ggplot(aes(x = Freq)) +
  geom_histogram()

# Synonyms
data <-
  data_scales %>% 
  transmute(psychsyn = careless::psychsyn(., critval = 0.6)) %>% 
  bind_cols(data)


# Before recoding, higher correlation indicates less attention/carefullness
data <-
  data_scales_no_reverse_codes %>%
  transmute(psychant = careless::psychant(., critval = -0.6, diag = FALSE)) %>% 
  bind_cols(data)


# IRV ---------------------------------------------------------------------

# Synonyms and IRV
data <-
  data_scales %>% 
  transmute(careless::irv(x =., split = T, num.split = 6)) %>%
  bind_cols(data)
  

# Long-String Analysis: Civilian Commitment ----------------------------------
## Measures the longest of individual's consecutive responses without variance.
## The average string can also be calculated. 
## Outliers are suspicious for carelessness/inattention.

## One problem for this soft launch: questions within scales were randomized. 
## Longstring should be performed twice: once with and once without any reverse coding.  
## Without reverse coding detects pure straightlining. 
## With reverse coding detects speeders who are attentive enough to negative phrasing. 

data <-  
  data %>% 
  select(starts_with('civilian_commit') &
           !ends_with('total')
  ) %>% 
  transmute(lngstr_civilian_commit = careless::longstring(.)) %>% 
  bind_cols(data)

# Long-String Analysis: MIOS --------------------------------------------------
data <-  
  data %>% 
  select(starts_with('mios') &
           !ends_with('total') &
           !ends_with('shame') &
           !ends_with('trust') &
           !contains('type') &
           !ends_with('screener') &
           !contains('symptoms') &
           !ends_with('worst') &
           !ends_with('criterion_a')
  ) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_mios = longstr,
         avgstr_mios = avgstr) %>% 
  bind_cols(data)



# Average Longstring ------------------------------------------------------

data <-
  data_scales %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse = longstr, 
         avgstr_reverse = avgstr) %>% 
  bind_cols(data)

data <-
    data_scales_no_reverse_codes %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_no_reverse = longstr, 
           avgstr_no_reverse = avgstr) %>% 
  bind_cols(data)
  
  
## I am suspicious of R_3kh9MlL3qrxkLrb given the invariance on some scales.
## however, psychometric synonyms and antonyms are scored well. 
## That may be 
## Another issue is that they report not being religion but attending a place
## of worship weekly. That might be considered a semantic synonym



# Compare MCARM and M2CQ --------------------------------------------------
## These scales should be negatively correlated. 
## M-CARM lower scores indicate greater difficulty. 1-4. 21 items
## M2C-Q higher scores indicate greater difficulty. 0-4. 16 items.

cor.test(data$m2cq_mean, data$mcarm_total)

data <-
  data %>% 
  select(mcarm_total, m2cq_mean) %>% 
  # Make these comparable scales (average response, min 0, max 4, same direction):
  
  mutate(mcarm_total = 5 - (mcarm_total - 1) / 21) %>% 
  
  # Now, a greater difference in scores should represent greater likelihood
  # of inconsistency across semantic synonyms.:
  transmute(mcarm_m2cq_difference = abs(mcarm_total - m2cq_mean)) %>% 
  bind_cols(data)


  


# Mahad -----------------------------------------------------------------------------

#data <-
  #data_scales %>% 
  # scc_9 and #scc_8 are colinear in this sample. 
  # remove one to make the function work. 
  #select(!c(scc_9, m2cq_11)) %>% 
  #careless::mahad(.) %>% 
  #bind_cols(data)





# Outlier Analysis --------------------------------------------------------

data <-
  data %>% 
  mutate(
        # Average longstring twice the standard deviation
        outlier_longstring_no_reverse = avgstr_no_reverse > mean(avgstr_no_reverse) + (2 * sd(avgstr_no_reverse)),
        outlier_longstring_reverse = avgstr_reverse > mean(avgstr_reverse) + (2 * sd(avgstr_reverse)),
        
        ## Psych Synonyms Correlation less than one and half standard deviations
        outlier_psychsyn = psychsyn < mean(psychsyn) - (2 * sd(psychsyn)),
        
        ## Psych Antonyms Correlation greater than one and half standard deviations
        outlier_psychant = psychant > mean(psychant) + (2 * sd(psychant)),
        
        ## Even-Odd Correaltion less than one and half standard deviations
        outlier_evenodd = evenodd < mean(evenodd) - (2 * sd(evenodd)),
        
        ## IRV 
        outlier_irvTotal = irvTotal > mean(irvTotal) + (2 * sd(irvTotal)),
        outlier_irv1 = irv1 > mean(irv1) + (2 * sd(irv1)),
        outlier_irv2 = irv2 > mean(irv2) + (2 * sd(irv2)),
        outlier_irv3 = irv3 > mean(irv3) + (2 * sd(irv3)),
        outlier_irv4 = irv4 > mean(irv4) + (2 * sd(irv4)),
        outlier_irv5 = irv5 > mean(irv5) + (2 * sd(irv5)),
        outlier_irv6 = irv6 > mean(irv6) + (2 * sd(irv6)),
        
        
        ## Duration faster than one and a half standard deviations
        outlier_duration = `Duration (in minutes)` < mean(`Duration (in minutes)`) - (1.5 * sd(`Duration (in minutes)`)),
        
        ## Difference in M2C-Q and M-CARM greater than 1.5 standard deviations
        outlier_mcarm_m2cq_difference = mcarm_m2cq_difference < mean(mcarm_m2cq_difference) - (1.5 * sd(mcarm_m2cq_difference))

)



data$psychant > mean(data$psychant) + (2 * sd(data$psychant))



