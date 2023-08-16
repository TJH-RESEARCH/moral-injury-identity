



## Reorder items to be sequential per unidimensional measure ------------------
data_scales_reordered <- 
  
reorder_data_scales <- function(data_scales){
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
}