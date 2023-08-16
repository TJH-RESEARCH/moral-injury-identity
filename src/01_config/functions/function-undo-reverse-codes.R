

undo_reverse_codes <- function(data_scales){
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
}
