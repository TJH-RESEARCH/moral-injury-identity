# Save this plus operator that ignores NA to the env
`%+%` <- function(x, y)  mapply(sum, x, y, MoreArgs = list(na.rm = TRUE))


# -------------------------------------------------------------------------
# Calculate the sum scores of scales and subscales


data <-
  data %>% 
    dplyr::mutate(


# BIIS-2: Sub Scales -------------------------------------------------------
        biis_harmony = 
          biis_1 +
          biis_2 +
          biis_3 +
          biis_4 +
          biis_5 +
          biis_6 +
          biis_7 +
          biis_8 +
          biis_9 +
          biis_10,
        
        biis_blendedness = 
          biis_11 +
          biis_12 +
          biis_13 +
          biis_14 +
          biis_15 +
          biis_16 +
          biis_17,
        
# BIIS-2: Total -------------------------------------------------------------
        biis_total = 
          biis_harmony + 
          biis_blendedness, 
        
# b-IPF: Total --------------------------------------------------------------
        bipf_total = 
          bipf_spouse %+%
          bipf_children %+%
          bipf_family %+%
          bipf_friends %+%
          bipf_work %+%
          bipf_education %+%
          bipf_daily,
        bipf_none = if_else(bipf_total == 0, 1, 0),

# Civilian Identity Commitment: Total --------------------------------------
        civilian_commit_total = 
          civilian_commit_1 + 
          civilian_commit_2 +
          civilian_commit_3 +
          civilian_commit_4

# Brake the chain to create rowwise grouping for the M2C-2
) %>%
  
        
# M2C-Q: Total --------------------------------------------------------------
## Items 6-9 are not applicable to everyone. Respondents can answer “N/A.”
## Thus, the sum of responses is not valid. Instead, the rowwise mean should be
## calculated, ignoring NAs. 
  
  rowwise() %>% 
  mutate(
    m2cq_mean = mean(
                     c(m2cq_1, 
                       m2cq_2, 
                       m2cq_3, 
                       m2cq_4, 
                       m2cq_5, 
                       m2cq_6, 
                       m2cq_7, 
                       m2cq_8,
                       m2cq_9,
                       m2cq_10,
                       m2cq_11,
                       m2cq_12,
                       m2cq_13, 
                       m2cq_14,
                       m2cq_15,
                       m2cq_16), na.rm = TRUE)
    ) %>% 
  
  # Remove the row wise grouping and continue the data transformation:
  ungroup() %>% 
  mutate(

        
# M-CARM: Sub Scales --------------------------------------------------------
        mcarm_purpose_connection =  
          mcarm_1 + 
          mcarm_2 + 
          mcarm_3 + 
          mcarm_4 +
          mcarm_5 + 
          mcarm_6,
        
        mcarm_help_seeking =
          mcarm_7 + 
          mcarm_8 + 
          mcarm_9 +
          mcarm_10,
        
        mcarm_beliefs_about_civilians =
          mcarm_11 + 
          mcarm_12 + 
          mcarm_13,
        
        mcarm_resentment_regret =
          mcarm_14 + 
          mcarm_15 +
          mcarm_16,
        
        mcarm_regimentation = 
          mcarm_17 +
          mcarm_18 +
          mcarm_19 +
          mcarm_20 +
          mcarm_21, 
        
# M-CARM Total ---------------------------------------------------------------
        mcarm_total =
          mcarm_purpose_connection +
          mcarm_help_seeking + 
          mcarm_beliefs_about_civilians +
          mcarm_resentment_regret +
          mcarm_regimentation,
        

        
# MIOS Sub Scales -----------------------------------------------------------
        mios_shame = 
          mios_1 +
          mios_3 +
          mios_7 +
          mios_8 +
          mios_12 +
          mios_13 +
          mios_14,
        
        mios_trust = 
          mios_2 +
          mios_4 +
          mios_5 +
          mios_6 +
          mios_9 +
          mios_10 +
          mios_11,
        
# MIOS Total ----------------------------------------------------------------
        mios_total =
          mios_shame + 
          mios_trust,

# MIOS PTSD Symptoms ------------------------------------------------------
        mios_ptsd_symptoms_total = 
          mios_ptsd_symptoms_nightmares + 
          mios_ptsd_symptoms_avoid +
          mios_ptsd_symptoms_vigilant +
          mios_ptsd_symptoms_numb +
          mios_ptsd_symptoms_guilty,

# SCC: Total ---------------------------------------------------------------
        scc_total =
          scc_1 +
          scc_2 +
          scc_3 +
          scc_4 +
          scc_5 +
          scc_6 +
          scc_7 +
          scc_8 +
          scc_9 +
          scc_10 +
          scc_11 +
          scc_12,
        
# Unmet Needs: Total --------------------------------------------------------
        unmet_needs_total =
          unmet_needs_job +
          unmet_needs_housing +
          unmet_needs_healthcare +
          unmet_needs_education +
          unmet_needs_records + 
          unmet_needs_physical +
          unmet_needs_mental +
          unmet_needs_legal +
          unmet_needs_financial,
        
# WIS Scales ---------------------------------------------------------------
        
        wis_private_regard_total =
          wis_private_1 +
          wis_private_2 +
          wis_private_3 +
          wis_private_4 +
          wis_private_5 +
          wis_private_6 +
          wis_private_7,
        
        wis_interdependent_total = 
          wis_interdependent_8 +
          wis_interdependent_9 +
          wis_interdependent_10 +
          wis_interdependent_11 +
          wis_interdependent_12 +
          wis_interdependent_13 +
          wis_interdependent_14,
        
        wis_connection_total =
          wis_connection_15 +
          wis_connection_16 +
          wis_connection_17,
        
        wis_family_total = 
          wis_family_18 +
          wis_family_19 +
          wis_family_20,
        
        wis_centrality_total =
          wis_centrality_21 +
          wis_centrality_22 +
          wis_centrality_23 +
          wis_centrality_24,
        
        wis_public_regard_total =
          wis_public_25 +
          wis_public_26 +
          wis_public_27 +
          wis_public_28,
        
        wis_skills_total =
          wis_skills_29 +
          wis_skills_30 +
          wis_skills_31,

        wis_total =
           wis_centrality_total + 
           wis_connection_total +
           wis_family_total +
           wis_interdependent_total +
           wis_private_regard_total +
           wis_public_regard_total +
           wis_skills_total


)


