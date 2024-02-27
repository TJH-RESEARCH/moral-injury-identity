

data_start_main <- data_main
data_start_strict <- data_strict
data_start_lenient <- data_lenient


## Set the cutoff - Three and a half standard deviations from the mean of the data
cut_main <- 3
cut_lenient <- 4
cut_strict <- 2

## Filter
data_main <-
  data_main %>%
  filter(
    
    longstr_reverse < mean(data_main$longstr_reverse) + (cut_main * sd(data_main$longstr_reverse)),
    longstr_no_reverse < mean(data_main$longstr_no_reverse) + (cut_main * sd(data_main$longstr_no_reverse)), 
    
    avgstr_no_reverse < mean(data_main$avgstr_no_reverse) + (cut_main * sd(data_main$avgstr_no_reverse)), 
    avgstr_reverse < mean(data_main$avgstr_reverse) + (cut_main * sd(data_main$avgstr_reverse)),
    
    avgstr_reverse_biis < mean(data_main$avgstr_reverse_biis) + (cut_main * sd(data_main$avgstr_reverse_biis)),         
    avgstr_no_reverse_biis < mean(data_main$avgstr_no_reverse_biis) + (cut_main * sd(data_main$avgstr_no_reverse_biis)), 
    
    avgstr_reverse_mcarm < mean(data_main$avgstr_reverse_mcarm) + (cut_main * sd(data_main$avgstr_reverse_mcarm)),         
    avgstr_no_reverse_mcarm < mean(data_main$avgstr_no_reverse_mcarm) + (cut_main * sd(data_main$avgstr_no_reverse_mcarm)), 
    
    avgstr_no_reverse_scc < mean(data_main$avgstr_no_reverse_scc) + (cut_main * sd(data_main$avgstr_no_reverse_scc)),          
    avgstr_reverse_scc < mean(data_main$avgstr_reverse_scc) + (cut_main * sd(data_main$avgstr_reverse_scc)), 
  )



# Strict ------------------------------------------------------------------

## Filter
data_strict <-
  data_strict %>%
  filter(
    
    longstr_reverse < mean(data_strict$longstr_reverse) + (cut_strict * sd(data_strict$longstr_reverse)),
    longstr_no_reverse < mean(data_strict$longstr_no_reverse) + (cut_strict * sd(data_strict$longstr_no_reverse)), 
    
    avgstr_no_reverse < mean(data_strict$avgstr_no_reverse) + (cut_strict * sd(data_strict$avgstr_no_reverse)), 
    avgstr_reverse < mean(data_strict$avgstr_reverse) + (cut_strict * sd(data_strict$avgstr_reverse)),
    
    avgstr_reverse_biis < mean(data_strict$avgstr_reverse_biis) + (cut_strict * sd(data_strict$avgstr_reverse_biis)),         
    avgstr_no_reverse_biis < mean(data_strict$avgstr_no_reverse_biis) + (cut_strict * sd(data_strict$avgstr_no_reverse_biis)), 
    
    avgstr_reverse_mcarm < mean(data_strict$avgstr_reverse_mcarm) + (cut_strict * sd(data_strict$avgstr_reverse_mcarm)),         
    avgstr_no_reverse_mcarm < mean(data_strict$avgstr_no_reverse_mcarm) + (cut_strict * sd(data_strict$avgstr_no_reverse_mcarm)), 
    
    avgstr_no_reverse_scc < mean(data_strict$avgstr_no_reverse_scc) + (cut_strict * sd(data_strict$avgstr_no_reverse_scc)),          
    avgstr_reverse_scc < mean(data_strict$avgstr_reverse_scc) + (cut_strict * sd(data_strict$avgstr_reverse_scc)), 
  )



# Lenient -----------------------------------------------------------------
## Filter
data_lenient <-
  data_lenient %>%
  filter(
    
    longstr_reverse < mean(data_lenient$longstr_reverse) + (cut_lenient * sd(data_lenient$longstr_reverse)),
    longstr_no_reverse < mean(data_lenient$longstr_no_reverse) + (cut_lenient * sd(data_lenient$longstr_no_reverse)), 
    
    avgstr_no_reverse < mean(data_lenient$avgstr_no_reverse) + (cut_lenient * sd(data_lenient$avgstr_no_reverse)), 
    avgstr_reverse < mean(data_lenient$avgstr_reverse) + (cut_lenient * sd(data_lenient$avgstr_reverse)),
    
    avgstr_reverse_biis < mean(data_lenient$avgstr_reverse_biis) + (cut_lenient * sd(data_lenient$avgstr_reverse_biis)),         
    avgstr_no_reverse_biis < mean(data_lenient$avgstr_no_reverse_biis) + (cut_lenient * sd(data_lenient$avgstr_no_reverse_biis)), 
    
    avgstr_reverse_mcarm < mean(data_lenient$avgstr_reverse_mcarm) + (cut_lenient * sd(data_lenient$avgstr_reverse_mcarm)),         
    avgstr_no_reverse_mcarm < mean(data_lenient$avgstr_no_reverse_mcarm) + (cut_lenient * sd(data_lenient$avgstr_no_reverse_mcarm)), 
    
    avgstr_no_reverse_scc < mean(data_lenient$avgstr_no_reverse_scc) + (cut_lenient * sd(data_lenient$avgstr_no_reverse_scc)),          
    avgstr_reverse_scc < mean(data_lenient$avgstr_reverse_scc) + (cut_lenient * sd(data_lenient$avgstr_reverse_scc)), 
  )





# Label Exclusion Reasons -------------------------------------------------

data_exclusions_main <-
  update_exclusions(data_start = data_start_main,
                    data = data_main,
                    data_exclusions = data_exclusions_main,
                    exclusion_reason_string = 'Invariance (Average Long String)')

data_exclusions_strict <-
  update_exclusions(data_start = data_start_strict,
                    data = data_strict,
                    data_exclusions = data_exclusions_strict,
                    exclusion_reason_string = 'Invariance (Average Long String)')

data_exclusions_lenient <-
  update_exclusions(data_start = data_start_lenient,
                    data = data_lenient,
                    data_exclusions = data_exclusions_lenient,
                    exclusion_reason_string = 'Invariance (Average Long String)')


rm(cut_lenient, cut_main, cut_strict,
   data_start_main, data_start_strict, data_start_lenient)
