

# Additional Screening Criteria --------------------------------------------
data <-
  data %>%
  mutate(

    ## Air Force Warrant Officers ----------------------------------------------
    air_force_warrant_officer = ifelse(branch == 'Air Force' & warrant_officer == 1, 1, 0),
    
    ## Inconsistency: Children -------------------------------------------------
    inconsistent_children = is.na(bipf_children) & military_family_child == 1, ## Report having children to one question, having no children in another.
    inconsistent_children_age = years_of_age < 40 & military_family_child == 1, ## Inconsistency: Children-Age. ## Report having a child who served in the military but is under 35 years themselves. Perhaps not an impossibility, but hihly unlikely
    
    ## Inconsistency: Education and Years of Age
    inconsistent_education_years = education == 'Doctorate' & years_of_age < 30,
    
    ## Inconsistency: Education
    inconsistent_education = is.na(bipf_education) & employment_student == 1, ## Reports N/A to b-IPF Education question, then 'Student' to employment
    
    ## Inconsistency: Rank and Years of Service --------------------------------
    inconsistent_rank = highest_rank == 'E-7 to E-9' & years_service < 8,
    
    ## Inconsistency: Religion and Worship
    inconsistent_religion = worship > 4 & religious == 0, 

    ## Inconsistency: Retirement
    inconsistent_retirement = is.na(bipf_work) & (employment_retired == 0 | employment_unemployed == 0 ), 
    
    ## Inconsistency: Total Years ----------------------------------------------
    ### Check that reported years are logically valid 
    validity_years = 
      years_of_age - 
      17 - 
      years_service - 
      years_separation,
    
    invalid_years = validity_years < 0,
    
    age_enlisted = 
      years_of_age - 
      years_service - 
      years_separation,
    
    age_separated = 
      years_of_age - 
      years_separation,
    
    
    ## Failed attention checks (i.e., instructed items)
    attention_checks = attention_check_biis + attention_check_wis
  )


# Save a copy of the data with on the scale items (no totals, metadata etc) ----
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
    ) %>% 
  
  ## Reorder items to be sequential per unidimensional measure.:
  select(
    biis_1, biis_2, biis_3, biis_4, biis_5, biis_6, biis_7, biis_8,
    biis_9, biis_10, biis_11, biis_12, biis_13, biis_14, biis_15,
    biis_16, biis_17,
    
    starts_with('civilian_commit'),
    
    starts_with('m2cq_'),
    
    mcarm_1, mcarm_2, mcarm_3, mcarm_4, mcarm_5, mcarm_6, mcarm_7, mcarm_8,
    mcarm_9, mcarm_10, mcarm_11, mcarm_12, mcarm_13, mcarm_14, mcarm_15,
    mcarm_16, mcarm_17, mcarm_18, mcarm_19, mcarm_20, mcarm_21, 
    
    mios_1, mios_3, mios_7, mios_8, mios_12, mios_13, mios_14,
    mios_2, mios_4, mios_5, mios_6, mios_9, mios_10, mios_11,
    
    starts_with('scc'),
    
    wis_private_1,
    wis_private_2,
    wis_private_3,
    wis_private_4,
    wis_private_5,
    wis_private_6,
    wis_private_7,
    wis_interdependent_8,
    wis_interdependent_9,
    wis_interdependent_10,
    wis_interdependent_11,
    wis_interdependent_12,
    wis_interdependent_13,
    wis_interdependent_14,
    wis_connection_15,
    wis_connection_16,
    wis_connection_17,
    wis_family_18,
    wis_family_19,
    wis_family_20,
    wis_centrality_21,
    wis_centrality_22,
    wis_centrality_23,
    wis_centrality_24,
    wis_public_25,
    wis_public_26,
    wis_public_27,
    wis_public_28,
    wis_skills_29,
    wis_skills_30,
    wis_skills_31
    
  )


# Save a Copy of Data with undone Reverse Coding -----------------------------
data_scales_no_reverse_codes <-
  data_scales %>% 
  
  # to undo the reverse coding:
  mutate(

    ## BIIS-2: Undo Reverse Code 
    biis_5 = -1 * (biis_5 - 6), 
    biis_6 = -1 * (biis_6 - 6),
    biis_7 = -1 * (biis_7 - 6),
    biis_8 = -1 * (biis_8 - 6),
    biis_9 = -1 * (biis_9 - 6),
    biis_10 = -1 * (biis_10 - 6),
    biis_16 = -1 * (biis_16 - 6),
    biis_17 = -1 * (biis_17 - 6),
    
   # # M-CARM: Undo Reverse Code 
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
    
    ## SCC: Undo Reverse Code
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
    
    # WIS: Undo Reverse Code
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


# Calculate Indices of Inconsistency --------------------------------------

## Even-Odd Consistency ------------------------------------------------------
data <-
  data_scales %>%

  
  ## Run the even-odd consistency analysis: 
  transmute(evenodd = 
              careless::evenodd(x =., 
                        # nItems in each subscale in order:
                        factors = c(
                                    10, # BIIS Harmony
                                    7,  # BIIS Blended
                                    4,  # Civilian Commitment
                                    16, # M2C-Q
                                    6,  # MCARM Purpose 
                                    4,  # MCARM Help
                                    3,  # MCARM Civilians
                                    3,  # MCARM Resentment
                                    5,  # MCARM Regimentation
                                    7,  # MIOS Shame
                                    7,  # MIOS Trust
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

## Psychometric Synonyms --------------------------------------------------
data <-
  data_scales %>% 
  transmute(psychsyn = careless::psychsyn(., critval = 0.7)) %>% 
  bind_cols(data)

## Psychometric Antonyms --------------------------------------------------
# Before recoding, higher correlation indicates less attention/carefullness
data <-
  data_scales_no_reverse_codes %>%
  transmute(psychant = careless::psychant(., critval = -0.5, diag = FALSE)) %>% 
  bind_cols(data)

## IRV ---------------------------------------------------------------------
# Intra-individual Response Variability (also termed Inter-item Standard Deviation).
# "This technique, proposed and tested by Marjanovic, Holden, Struthers, Cribbie, and Greenglass (2015), measures how much an individual strays from their own personal midpoint across a set of scale items." (Curran 2016)
data <-
  data_scales %>% 
  transmute(careless::irv(x =., split = T, num.split = 6)) %>%
  bind_cols(data)
  
## Average Longstring: With Reverse Scoring --------------------------------
data <-
  data_scales %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse = longstr, 
         avgstr_reverse = avgstr) %>% 
  bind_cols(data)

## Average Longstring: Without Reverse Scoring -----------------------------
data <-
    data_scales_no_reverse_codes %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_no_reverse = longstr, 
           avgstr_no_reverse = avgstr) %>% 
  bind_cols(data)

## Compare MCARM and M2CQ --------------------------------------------------
data <-
  data %>% 
  select(mcarm_total, m2cq_mean) %>% 
  # Make these comparable scales (average response, min 0, max 4, same direction):
  
  mutate(mcarm_total = 5 - (mcarm_total - 1) / 21) %>% 
  
  # Now, a greater difference in scores should represent greater likelihood
  # of inconsistency across semantic synonyms.:
  transmute(mcarm_m2cq_difference = abs(mcarm_total - m2cq_mean)) %>% 
  bind_cols(data)








