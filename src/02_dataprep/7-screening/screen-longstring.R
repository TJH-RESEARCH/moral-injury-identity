
source(here::here('src/01_config/functions/function-calculate-longstring.R'))

data_start_main <- data_main
data_start_strict <- data_strict
data_start_lenient <- data_lenient


# Longstring by scale
# BIIS = 17 items: 13 (75%) - 15 (90%) - 17 (100%)
biis_longstring_cut_main <- round(17 * .9, 0)
biis_longstring_cut_strict <- round(17 * .75, 0)
biis_longstring_cut_lenient <- 17

# MCARM = 21 items: 16 (75%) - 19 (90%) - 21 (100%)
mcarm_longstring_cut_main <- round(16 * .9, 0)
mcarm_longstring_cut_strict <- round(19 * .75, 0)
mcarm_longstring_cut_lenient <- 21

# SCC = 12 items: 9 (75%) - 11 (90%) - 12 (100%)
scc_longstring_cut_main <- round(12 * .9, 0)
scc_longstring_cut_strict <- round(12 * .75, 0)
scc_longstring_cut_lenient <- 12


# Screen: Longstring ----------------------------------------------------------------
## Now screen the really obvious and aggregriuos instances of straightlining, 
## which is the main threat on an online survey, along with answering in a random pattern

data_main <-  
  data_main %>% 
  calculate_longstring() %>% 
  screen_longstring(biis_cut = biis_longstring_cut_main, 
                    mcarm_cut = mcarm_longstring_cut_main, 
                    scc_cut = scc_longstring_cut_main)

data_strict <- 
  data_strict %>% 
  calculate_longstring() %>% 
  screen_longstring(biis_cut = biis_longstring_cut_strict, 
                    mcarm_cut = mcarm_longstring_cut_strict, 
                    scc_cut = scc_longstring_cut_strict)

data_lenient <- 
  data_lenient %>% 
  calculate_longstring() %>% 
  screen_longstring(biis_cut = biis_longstring_cut_lenient, 
                    mcarm_cut = mcarm_longstring_cut_lenient, 
                    scc_cut = scc_longstring_cut_lenient)


# Label Exclusion Reasons -------------------------------------------------

data_exclusions_main <-
  update_exclusions(data_start = data_start_main,
                        data = data_main,
                        data_exclusions = data_exclusions,
                        exclusion_reason_string = 'Invariance (Long String)')

data_exclusions_strict <-
  update_exclusions(data_start = data_start_strict,
                        data = data_strict,
                        data_exclusions = data_exclusions,
                        exclusion_reason_string = 'Invariance (Long String)')

data_exclusions_lenient <-
  update_exclusions(data_start = data_start_lenient,
                        data = data_lenient,
                        data_exclusions = data_exclusions,
                        exclusion_reason_string = 'Invariance (Long String)')




# clean up environment ------------------------------------------------------------

rm(biis_longstring_cut_lenient, biis_longstring_cut_main, biis_longstring_cut_strict,
    mcarm_longstring_cut_lenient, mcarm_longstring_cut_strict, mcarm_longstring_cut_main,
   scc_longstring_cut_lenient, scc_longstring_cut_main, scc_longstring_cut_strict,
   data_start_main, data_start_strict, data_start_lenient)

