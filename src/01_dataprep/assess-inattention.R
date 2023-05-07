
# Statistical Screeners ------------------------------------------------------

# Even-Odd Consistency ------------------------------------------------------
## Even-odd consistency divides each unidimensional measure 
## in two based on even and odd items. If respondents were attentive/careful,
## these two halves should correlate positively. 
## The more subscales there are in the survey, the better a measure this is. 
## 


data <-
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
      !ends_with('total') |
      
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
      !ends_with('worst') &
      !ends_with('criterion_a')|
      
      # SCC
      starts_with('scc_') & 
      !ends_with('total') |
      
      # WIS
      starts_with('wis_') & 
      
      # Doesn't end with 'total
      !ends_with('total')) %>%
  
  # to calculate even-odd, you have to undo the reverse coding:
  mutate(
    
    # BIIS-2: Reverse Code -------------------------------------------------
    biis_5 = -1 * (biis_5 - 6), 
    biis_6 = -1 * (biis_6 - 6),
    biis_7 = -1 * (biis_7 - 6),
    biis_8 = -1 * (biis_8 - 6),
    biis_9 = -1 * (biis_9 - 6),
    biis_10 = -1 * (biis_10 - 6),
    biis_16 = -1 * (biis_16 - 6),
    biis_17 = -1 * (biis_17 - 6),
    
    # M-CARM: Reverse Code -------------------------------------------------
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
    
    # SCC: Reverse Code ---------------------------------------------------
    ## All SCC items except 6 and 11 are reverse-scored
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
    
    # WIS: Reverse Code ---------------------------------------------------
    wis_private_5 = -1 * (wis_private_5 - 5),
    wis_private_7 = -1 * (wis_private_7 - 5),
    wis_connection_15 = -1 * (wis_connection_15 - 5),
    wis_connection_16 = -1 * (wis_connection_16 - 5),
    wis_connection_17 = -1 * (wis_connection_17 - 5),
    wis_centrality_21 = -1 * (wis_centrality_21 - 5),
    wis_centrality_23 = -1 * (wis_centrality_23 - 5),
    wis_centrality_24 = -1 * (wis_centrality_24 - 5),
    wis_skills_30 = -1 * (wis_skills_30 - 5)
    
  ) %>% 
  select(
    # MIOS Shame Subscale
    mios_1, mios_3, mios_7, mios_8, mios_12, mios_13, mios_14,
    
    # MIOS Trust Subscale
    mios_2, mios_4, mios_5, mios_6, mios_9, mios_10, mios_11,
    everything()
  ) %>% 
  transmute(evenodd = careless::evenodd(x =., 
                                        # Tell how many items in each subscale
                                        # in order: 
                                        factors = c(7,  # MIOS Shame
                                                    7,  # MIOS Trust
                                                    10, # BIIS Harmony
                                                    7,  # BIIS Blended
                                                    4,  # Civilian Commitment
                                                    16, # M2C-Q
                                                    6,  # MCARM Purpose 
                                                    4,  # MCARM Help
                                                    3,  # MCARM Civilians
                                                    3,  # MCARM Resentment
                                                    5,  # MCARM Regimentation
                                                    12, # SCC 
                                                    7,  # WIS Private Regard
                                                    7,  # WIS Interdependent
                                                    3,  # WIS Connection
                                                    3,  # WIS Family
                                                    4,  # WIS Centrality
                                                    4,  # WIS Public Regard
                                                    3)  # WIS Skills
  )) %>% 
  bind_cols(data)


# Long-String Analysis: Civilian Commitment ----------------------------------
## Measures the longest of individual's consecutive responses without variance.
## The average string can also be calculated. 
## Outliers are suspicious for carelessness/inattention

data <-  
  data %>% 
  select(starts_with('civilian_commit') &
           !ends_with('total')
  ) %>% 
  transmute(lngstr_civilian_commit = careless::longstring(.)) %>% 
  bind_cols(data)


# -------------------------------------------------------------------

# Intra-individual Response Variability (also termed Inter-item Standard Deviation).
# This technique, proposed and tested by Marjanovic, Holden, Struthers, Cribbie, and Greenglass (2015), measures how much an individual strays from their own personal midpoint across a set of scale items.
# Curran 2016




# Psychometric Synonyms and Antonyms -----------------------------------------

## First, find a suitable critical value:

data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness') |
           starts_with('civilian_commit') &
           !ends_with('total') |
           starts_with('m2cq_') & 
           !ends_with('total') |
           starts_with('mcarm_') & 
           !ends_with('total') & 
           !ends_with('connection') &
           !ends_with('seeking') & 
           !ends_with('civilians') &
           !ends_with('regret') & 
           !ends_with('regimentation') |
           starts_with('mios') &
           !ends_with('total') &
           !ends_with('shame') &
           !ends_with('trust') &
           !contains('type') &
           !ends_with('screener') &
           !contains('symptoms') &
           !ends_with('worst') &
           !ends_with('criterion_a') |
           starts_with('scc_') & 
           !ends_with('total') |
           starts_with('wis_') & 
           !ends_with('total')) %>%
  careless::psychsyn_critval(., anto = FALSE) %>% 
  ggplot2::ggplot(aes(x = Freq)) +
  geom_histogram()

data <-
  data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness') |
           starts_with('civilian_commit') &
           !ends_with('total') |
           starts_with('m2cq_') & 
           !ends_with('total') |
           starts_with('mcarm_') & 
           !ends_with('total') & 
           !ends_with('connection') &
           !ends_with('seeking') & 
           !ends_with('civilians') &
           !ends_with('regret') & 
           !ends_with('regimentation') |
           starts_with('mios') &
           !ends_with('total') &
           !ends_with('shame') &
           !ends_with('trust') &
           !contains('type') &
           !ends_with('screener') &
           !contains('symptoms') &
           !ends_with('worst') &
           !ends_with('criterion_a') |
           starts_with('scc_') & 
           !ends_with('total') |
           starts_with('wis_') & 
           !ends_with('total')) %>%
  transmute(psychant = careless::psychant(., critval = -0.7, diag = FALSE),
            psychsyn = careless::psychsyn(., critval = 0.7),
            irv = careless::irv(x =., num.split = 10)) %>% 
  bind_cols(data)



# Average Longstring ------------------------------------------------------

data <-
  data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness') |
           starts_with('m2cq_') & 
           !ends_with('total') |
           starts_with('mcarm_') & 
           !ends_with('total') & 
           !ends_with('connection') &
           !ends_with('seeking') & 
           !ends_with('civilians') &
           !ends_with('regret') & 
           !ends_with('regimentation') |
           starts_with('mios') &
           !ends_with('total') &
           !ends_with('shame') &
           !ends_with('trust') &
           !contains('type') &
           !ends_with('screener') &
           !contains('symptoms') &
           !ends_with('worst') &
           !ends_with('criterion_a')|
           starts_with('scc_') & 
           !ends_with('total') |
           starts_with('wis_') & 
           !ends_with('total')) %>%
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  select(avgstr) %>% 
  bind_cols(data)



# Inspect Careless/Inattentive Response Indices -------------------------------

data %>% 
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_histogram()

data %>% 
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_boxplot()

data %>% 
  ggplot2::ggplot(aes(x = psychant)) +
  geom_histogram()

data %>% 
  ggplot2::ggplot(aes(x = psychant)) +
  geom_boxplot()

data %>% 
  ggplot2::ggplot(aes(x = psychant, 
                      y = psychsyn, 
                      size = evenodd, 
                      color = irv)) +
  geom_point()


data %>% 
  select(ResponseId, 
         psychant,
         psychsyn,
         evenodd,
         irv,
         avgstr,
         lngstr_civilian_commit,
         `Duration (in minutes)`)


# -----------------------------------------------------------------------------
data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness') |
           starts_with('civilian_commit') &
           !ends_with('total') |
           starts_with('m2cq_') & 
           !ends_with('total') |
           starts_with('mcarm_') & 
           !ends_with('total') & 
           !ends_with('connection') &
           !ends_with('seeking') & 
           !ends_with('civilians') &
           !ends_with('regret') & 
           !ends_with('regimentation') |
           starts_with('mios') &
           !ends_with('total') &
           !ends_with('shame') &
           !ends_with('trust') &
           !contains('type') &
           !ends_with('screener') &
           !contains('symptoms') &
           !ends_with('worst') &
           !ends_with('criterion_a') |
           starts_with('scc_') & 
           !ends_with('total') |
           starts_with('wis_') & 
           !ends_with('total')) %>%
  careless::irv(.)
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------



# Long-String Analysis: MIOS --------------------------------------------------
data <-  
  data %>% 
  select(starts_with('mios') &
           !ends_with('total') &
           !ends_with('shame') &
           !ends_with('trust') &
           !contains('type') &
           !ends_with('screener') &
           !contains('symptoms') &
           !ends_with('worst') &
           !ends_with('criterion_a')
  ) %>% 
  careless::longstring(avg = T) %>% 
  tibble() %>% 
  rename(longstr_mios = longstr,
         avgstr_mios = avgstr) %>% 
  bind_cols(data)




# -------------------------------------------------------------------------
# Inspect: Average String

data %>% 
  ggplot2::ggplot(aes(avgstr)) +
  geom_boxplot()

# Inspect: Even-Odd Consistency

data %>% 
  ggplot2::ggplot(aes(evenodd)) +
  geom_histogram()



# WORKING -----------------------------------------------------------------


