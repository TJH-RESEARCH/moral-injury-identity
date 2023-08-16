
# Function: Select Scales -------------------------------------------------


## Save a copy of the data with on the scale items (no totals, metadata etc) ---
select_scales <- function(data){
  data %>% 
    select(
      # BIIS-2
      starts_with('biis_') & !ends_with('harmony') & !ends_with('blendedness') |
        
        # Civilian Identity Commitment
        starts_with('civilian_commit') |
        
        # M2C-Q
        starts_with('m2cq_') & !ends_with('mean') |
        
        # MCARM
        starts_with('mcarm_') & !ends_with('connection') & 
        !ends_with('seeking') & !ends_with('civilians') & 
        !ends_with('regret') & !ends_with('regimentation') |
        
        # MIOS
        starts_with('mios') &
        !ends_with('shame') & !ends_with('trust') &
        !contains('type') & !ends_with('screener') &
        !contains('symptoms') & !contains('events') &
        !ends_with('worst') & !ends_with('criterion_a')|
        
        # SCC
        starts_with('scc_') |
        
        # WIS
        starts_with('wis_')
    ) %>% 
    select(!ends_with('total'))
}
