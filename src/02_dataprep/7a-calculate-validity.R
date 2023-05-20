

# Additional Screening Criteria ----------------------------------------------
data <-
  data %>%
  mutate(

    ## Air Force Warrant Officers ---------------------------------------------
    air_force_warrant_officer = ifelse(branch == 'Air Force' & warrant_officer == 1, 1, 0),
    
    ## Inconsistency: Children and Years of Age -------------------------------
    inconsistent_children_age = years_of_age < 40 & military_family_child == 1, ## Inconsistency: Children-Age. ## Report having a child who served in the military but is under 35 years themselves. Perhaps not an impossibility, but hihly unlikely
    
    ## Inconsistency: Education and Years of Age
    inconsistent_education_years = education == 'Doctorate' & years_of_age < 30,
    
    ## Inconsistency: Rank and Years of Service -------------------------------
    inconsistent_rank = highest_rank == 'E-7 to E-9' & years_service < 8
  )


# Save a copy of the data with on the scale items (no totals, metadata etc) ---
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

# Reorder items to be sequential per unidimensional measure ------------------
data_scales_reordered <- 
  data_scales %>% 
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
    
    wis_private_1, wis_private_2, wis_private_3, wis_private_4,
    wis_private_5, wis_private_6, wis_private_7,
    wis_interdependent_8, wis_interdependent_9, wis_interdependent_10,
    wis_interdependent_11, wis_interdependent_12, wis_interdependent_13, 
    wis_interdependent_14, 
    wis_connection_15, wis_connection_16, wis_connection_17,
    wis_family_18, wis_family_19, wis_family_20,
    wis_centrality_21, wis_centrality_22, wis_centrality_23, wis_centrality_24,
    wis_public_25, wis_public_26, wis_public_27, wis_public_28,
    wis_skills_29, wis_skills_30, wis_skills_31
    
  )


# Save a Copy of Data with undone Reverse Coding -----------------------------
data_scales_no_reverse_codes <-
  data_scales_reordered %>% 
  
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


# Calculate Indices of Inconsistency ----------------------------------------

## Even-Odd Consistency ------------------------------------------------------
data <-
  data_scales_reordered %>%
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
  )) %>% bind_cols(data) # Add the results back to the original data. 


## Mohad --------------------------------------------------------------------
data <-
  data_scales %>% 
    select(!starts_with('scc')) %>% # Including the SCC produces an era for singularity 
    transmute(careless::mahad(x = ., 
                              plot = FALSE, 
                              flag = TRUE, 
                              confidence = 0.99, 
                              na.rm = TRUE)) %>% 
    rename(d_sq_flagged = flagged) %>% 
    bind_cols(data)
  

## Psychometric Synonyms ----------------------------------------------------
data <-
  data_scales %>% 
  transmute(psychsyn = careless::psychsyn(., critval = 0.7)) %>% 
  bind_cols(data)


## Psychometric Antonyms ----------------------------------------------------
data <-
  data_scales_no_reverse_codes %>%   # Before recoding, higher correlation indicates less attention/carefullness
  transmute(psychant = careless::psychant(., critval = -0.5, diag = FALSE)) %>% 
  bind_cols(data)

  
## Average Longstring: With Reverse Scoring ----------------------------------
data <-
  data_scales %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse = longstr, 
         avgstr_reverse = avgstr) %>% 
  bind_cols(data)


## Average Longstring: Without Reverse Scoring -------------------------------
data <-
    data_scales_no_reverse_codes %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_no_reverse = longstr, 
           avgstr_no_reverse = avgstr) %>% 
  bind_cols(data)


## Longstring BIIS -----------------------------------------------------------
data <-
  data_scales %>% 
    select(starts_with('biis')) %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_reverse_biis = longstr, 
           avgstr_reverse_biis = avgstr) %>% 
    bind_cols(data)


## Longstring - No Reverse: BIIS ---------------------------------------------
data <-
  data_scales_no_reverse_codes %>% 
    select(starts_with('biis')) %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_no_reverse_biis = longstr, 
           avgstr_no_reverse_biis = avgstr) %>% 
    bind_cols(data)


## Longstring M2CQ -----------------------------------------------------------
data <-
  data_scales %>% 
    select(starts_with('m2cq')) %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_reverse_m2cq = longstr, 
           avgstr_reverse_m2cq = avgstr) %>% 
    bind_cols(data)


## Longstring MCARM ----------------------------------------------------------
data <-
  data_scales %>% 
    select(starts_with('mcarm')) %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_reverse_mcarm = longstr, 
           avgstr_reverse_mcarm = avgstr) %>% 
    bind_cols(data)


## Longstring - No Reverse: MCARM --------------------------------------------
data <-
  data_scales_no_reverse_codes %>% 
    select(starts_with('mcarm')) %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_no_reverse_mcarm = longstr, 
           avgstr_no_reverse_mcarm = avgstr) %>% 
    bind_cols(data)


## Longstring MIOS -----------------------------------------------------------
data <-
  data_scales %>% 
    select(starts_with('mios')) %>% 
    careless::longstring(avg = T) %>% 
    tibble() %>% 
    rename(longstr_mios = longstr, 
           avgstr_mios = avgstr) %>% 
    bind_cols(data)


## Longstring SCC ------------------------------------------------------------
data <-
  data_scales %>% 
  select(starts_with('scc')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_reverse_scc = longstr, 
         avgstr_reverse_scc = avgstr) %>% 
  bind_cols(data)


## Longstring - No Reverse: SCC ----------------------------------------------
data <-
  data_scales_no_reverse_codes %>% 
  select(starts_with('scc')) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_no_reverse_scc = longstr, 
         avgstr_no_reverse_scc = avgstr) %>% 
  bind_cols(data)


rm(data_scales, data_scales_no_reverse_codes, data_scales_reordered)
# ---------------------------------------------------------------------------#
