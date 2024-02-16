
# Attention checks: 2 items

data_start <- data


# Cutoffs -----------------------------------------------------------------
attention_cutoff_main <- 2
attention_cutoff_robust <- 1


# Filter ------------------------------------------------------------------
data_main <-
  data %>% 
  filter(    
    attention_check_biis + attention_check_wis >= attention_cutoff_main
)

data_lenient <-
  data %>% 
  filter(    
    attention_check_biis + attention_check_wis >= attention_cutoff_robust
)

data_strict <-
  data %>% 
  filter(    
    attention_check_biis + attention_check_wis == attention_cutoff_main
  )

data_simple <-
  data %>% 
  filter(    
    attention_check_biis + attention_check_wis >= attention_cutoff_robust
  )


# Label Exclusion Reasons -------------------------------------------------

data_exclusions_main <-
  update_exclusions(data_start, data_main, data_exclusions, 
                        exclusion_reason_string = 'Failed attention check')

data_exclusions_lenient <-
  update_exclusions(data_start, data_strict, data_exclusions, 
                        exclusion_reason_string = 'Failed attention check')

data_exclusions_strict <-
  update_exclusions(data_start, data_lenient, data_exclusions, 
                        exclusion_reason_string = 'Failed attention check')

data_exclusions_simple <-
  update_exclusions(data_start, data_simple, data_exclusions, 
                        exclusion_reason_string = 'Failed attention check')




rm(attention_cutoff_main, attention_cutoff_robust)