# -------------------------------------------------------------------------#
# Reverse code survey items where applicable

data <-
  data %>% 
    dplyr::mutate(
  
# BIIS-2: Reverse Code ----------------------------------------------------
      biis_5 = 6 - biis_5,
      biis_6 = 6 - biis_6,
      biis_7 = 6 - biis_7,
      biis_8 = 6 - biis_8,
      biis_9 = 6 - biis_9,
      biis_10 = 6 - biis_10,
      biis_16 = 6 - biis_16,
      biis_17 = 6 - biis_17,

# M-CARM: Reverse Code ----------------------------------------------------
      mcarm_5 = 6 - mcarm_5,
      mcarm_8 = 6 - mcarm_8,
      mcarm_9 = 6 - mcarm_9,
      mcarm_11 = 6 - mcarm_11,
      mcarm_12 = 6 - mcarm_12,
      mcarm_13 = 6 - mcarm_13,
      mcarm_14 = 6 - mcarm_14,
      mcarm_15 = 6 - mcarm_15,
      mcarm_16 = 6 - mcarm_16,
      mcarm_17 = 6 - mcarm_17,
      mcarm_18 = 6 - mcarm_18,
      mcarm_19 = 6 - mcarm_19,
      mcarm_21 = 6 - mcarm_21,

# SCC: Reverse Code -------------------------------------------------------
## All SCC items except 6 and 11 are reverse-scored
      scc_1 = 6 - scc_1,
      scc_2 = 6 - scc_2,
      scc_3 = 6 - scc_3,
      scc_4 = 6 - scc_4,
      scc_5 = 6 - scc_5,
      scc_7 = 6 - scc_7,
      scc_8 = 6 - scc_9,
      scc_9 = 6 - scc_9,
      scc_10 = 6 - scc_10,
      scc_12 = 6 - scc_12,
      
# WIS: Reverse Code -------------------------------------------------------
      wis_private_5 = 5 - wis_private_5,
      wis_private_7 = 5 - wis_private_7,
      wis_connection_15 = 5 - wis_connection_15,
      wis_connection_16 = 5 - wis_connection_16,
      wis_connection_17 = 5 - wis_connection_17,
      wis_centrality_21 = 5 - wis_centrality_21,
      wis_centrality_23 = 5 - wis_centrality_23,
      wis_centrality_24 = 5 - wis_centrality_24,
      wis_skills_30 = 5 - wis_skills_30,
  
)

# -------------------------------------------------------------------------#