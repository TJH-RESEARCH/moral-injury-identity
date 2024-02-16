

screen_longstring  <- 
  function(data, biis_cut, mcarm_cut, scc_cut){
    data <-
    data %>% 
    
    ## Straightlined the M2CQ with a score more than 0
    filter(longstr_m2cq == 16, m2cq_mean == 0) %>% 
    bind_rows(data %>% filter(longstr_m2cq != 16)) %>% 
    
    ## Straightlined the MIOS with score higher more than 0
    filter(longstr_mios == 14, mios_total == 0) %>% 
    bind_rows(data %>% filter(longstr_mios != 14)) %>% 
    
    filter(
      ## Longstring by scale
      longstr_reverse_biis < biis_cut,         # BIIS = 17 items total
      longstr_no_reverse_biis < biis_cut,
      longstr_reverse_mcarm < mcarm_cut,        # MCARM = 21 items
      longstr_no_reverse_mcarm < mcarm_cut,
      longstr_reverse_scc < scc_cut,          # SCC = 12 items
      longstr_no_reverse_scc < scc_cut)
  
  return(data)
  }
  
  
