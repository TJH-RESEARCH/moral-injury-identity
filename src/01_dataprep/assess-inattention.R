


# Additional Screening Criteria --------------------------------------------



data <-
  data %>%
  mutate(
    
    
    # Air Force Warrant Officers ----------------------------------------------
    air_force_warrant_officer = ifelse(branch == 1 & warrant_officer, 1, 0),
    
    # Branch: Space Force ---------------------------------------------------
    #branch_space_force
    
    # Branch: Did not serve ---------------------------------------------------
    #branch_none
    
    # Inconsistency: Children -------------------------------------------------
    ## Report having children to one question, having no children in another.
    inconsistent_children = is.na(bipf_children) & military_family_child == 1 | !is.na(bipf_children) & is.na(military_family_child),
    
    # Inconsistency Children-Age
    ## Report having a child who served in the military but is under 35 years themselves
    ## Perhaps not an impossibility, but highly unlikely
    inconsistent_children_age = years_of_age < 35 & military_family_child == 1,
    
    # Inconsistency: Education and Years of Age
    inconsistent_education = education == 'doctorate' & years_of_age < 26,
    
    # Inconsistency: Rank and Years of Service --------------------------------
    inconsistent_rank = highest_rank == 'E-7 to E-9' & years_service < 7,

    # Recode Attention and Validity Checks to be 0-1
    failed_attn_check_1 = dplyr::if_else(is.na(attn_check_1), 0, 1),
    failed_attn_check_2 = dplyr::if_else(is.na(attn_check_2), 0, 1),
    failed_validity_check = dplyr::if_else(is.na(validity_check), 0, 1),

    # Inconsistency: Total Years ----------------------------------------------
    # Check that reported years are logically valid 
    validity_years = 
      years_of_age - 
      17 - 
      years_service - 
      years_separation,
    
    invalid_years = validity_years < 0
  )



# Statistical Screeners ------------------------------------------------------

# Even-Odd Consistency ------------------------------------------------------
## Even-odd consistency divides each unidimensional measure 
## in two based on even and odd items. If respondents were attentive/careful,
## these two halves should correlate positively. 
## The more subscales there are in the survey, the better a measure this is. 

## If reverse scored items are in the survey, 
## they need to be reverse coded before even-odd analysis.
## Longstring should be performed twice: once with and once without the reverse coding.  



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
      !ends_with('mean') |
      
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
  
  # Reorder the data. MIOS items are not sequential per unidimensional measure. 
  # This will arrange the MIOS items into the subscales, 
  # then grab everything else, which should be properly ordered. 
  
  select(
    # MIOS Shame Subscale
    mios_1, mios_3, mios_7, mios_8, mios_12, mios_13, mios_14,
    
    # MIOS Trust Subscale
    mios_2, mios_4, mios_5, mios_6, mios_9, mios_10, mios_11,
    everything()
  ) %>% 
  
  
  # Run the even-odd consistency analysis: 
  
  transmute(evenodd = careless::evenodd(x =., 
                                        # Tell how many items in each subscale
                                        # in order, so it knows where the scales are: 
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
  bind_cols(data) # Add the results back to the original data. 




# -------------------------------------------------------------------


# Intra-individual Response Variability (also termed Inter-item Standard Deviation).
# This technique, proposed and tested by Marjanovic, Holden, Struthers, Cribbie, and Greenglass (2015), measures how much an individual strays from their own personal midpoint across a set of scale items.
# Curran 2016




# Psychometric Synonyms and Antonyms -----------------------------------------
## Finds individual-level reliability by determining which items are 
## psychometrically similar and different. The sample-level correlations
## between each possible item pair are calculated.
## The user sets a 'critical value,' then pairs with 
## positive/negative correlations of greater magnitudes than the critical value
## are determined to be synonyms/antonyms.
## Each individual respondents correlation between the set of pairs is calculated.


## First, find a suitable critical value:

data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness') |
           
           starts_with('civilian_commit') &
           !ends_with('total') |
           
           starts_with('m2cq_') & 
           !ends_with('mean') |
           
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
           !ends_with('mean') |
           
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



# Long-String Analysis: Civilian Commitment ----------------------------------
## Measures the longest of individual's consecutive responses without variance.
## The average string can also be calculated. 
## Outliers are suspicious for carelessness/inattention.

## One problem for this soft launch: questions within scales were randomized. 
## Longstring should be performed twice: once with and once without any reverse coding.  
## Without reverse coding detects pure straightlining. 
## With reverse coding detects speeders who are attentive enough to negative phrasing. 

data <-  
  data %>% 
  select(starts_with('civilian_commit') &
           !ends_with('total')
  ) %>% 
  transmute(lngstr_civilian_commit = careless::longstring(.)) %>% 
  bind_cols(data)

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



# Average Longstring ------------------------------------------------------

data <-
  data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness') |
           
           starts_with('m2cq_') & 
           !ends_with('mean') |
           
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
#  select(avgstr) %>% 
  bind_cols(data)


## I am suspicious of R_3kh9MlL3qrxkLrb given the invariance on some scales.
## however, psychometric synonyms and antonyms are scored well. 
## That may be 
## Another issue is that they report not being religion but attending a place
## of worship weekly. That might be considered a semantic synonym



# Compare MCARM and M2CQ --------------------------------------------------
## These scales should be negatively correlated. 
## M-CARM lower scores indicate greater difficulty. 1-4. 21 items
## M2C-Q higher scores indicate greater difficulty. 0-4. 16 items.

cor.test(data$m2cq_mean, data$mcarm_total)

data <-
  data %>% 
  select(mcarm_total, m2cq_mean) %>% 
  # Make these comparable scales (average response, min 0, max 4, same direction):
  
  mutate(mcarm_total = 5 - (mcarm_total - 1) / 21) %>% 
  
  # Now, a greater difference in scores should represent greater likelihood
  # of inconsistency across semantic synonyms.:
  transmute(mcarm_m2cq_difference = abs(mcarm_total - m2cq_mean)) %>% 
  arrange(desc(mcarm_m2cq_difference))  %>% 
  bind_cols(data)
  


# Mahad -----------------------------------------------------------------------------

data_scales <- 
  data %>% 
  select(starts_with('biis_') & 
           !ends_with('total') & 
           !ends_with('harmony') &
           !ends_with('blendedness') |
           
           starts_with('m2cq_') & 
           !ends_with('mean') |
           
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
           !ends_with('total'))

data_scales %>% 
  # scc_9 and #scc_8 are colinear in this sample. 
  # remove one to make the function work. 
 select(!c(scc_9, m2cq_11)) %>% 
careless::mahad(.)

data_scales %>% View()


data_scales %>% 
  select(!scc_9) %>% 
careless::psychsyn_critval(., anto = F)


# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------






# -------------------------------------------------------------------------




data_temp <- 
data %>% 
  mutate(
    attn_check_1 = dplyr::if_else(is.na(attn_check_1), 0, 1),
    attn_check_2 = dplyr::if_else(is.na(attn_check_2), 0, 1),
    validity_check = dplyr::if_else(is.na(validity_check), 0, 1),
    attn_check_score = attn_check_1 + attn_check_2
  ) %>% 
  select(id, 
         ResponseId, 
         `Response Type`,
         validity_check,
         attn_check_score,
         attn_check_1,
         attn_check_2,
         mos,
         `Duration (in minutes)`,
         air_force_warrant_officer,
         branch_space_force,
         branch_none,
         inconsistent_children,
         inconsistent_children_age,
         years_of_age,
         bipf_children,
         military_family_child,
         inconsistent_education,
         inconsistent_rank,
         validity_years,
         invalid_years,
         honeypot1,
         honeypot2,
         honeypot3,
         psychant, 
         psychsyn, 
         evenodd, 
         irv,
         mcarm_m2cq_difference
  ) %>% 
  arrange(desc(validity_check), desc(attn_check_score)) %>% 
  filter(validity_check == 0, attn_check_score < 2)
  
data_temp %>% View()


# Psychometric Synonyms/Antonyms ------------------------------------------
library(patchwork)

psych_scatter <-
  data_temp %>% 
    ggplot2::ggplot(aes(x = psychant, 
                        y = psychsyn)) +
    geom_text(aes(label = id))

psychsyn_box <-
  data_temp %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_boxplot()

psychsyn_hist <-
  data_temp %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_histogram()

psychant_box <-
  data_temp %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_boxplot()

psychant_hist <-
  data_temp %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_histogram()

psychsyn_box / psychsyn_hist
psychant_box / psychant_hist
psych_scatter


# Duration ----------------------------------------------------------------

duration_box <-
  data_temp %>%
    ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
    geom_boxplot()

duration_hist <-
  data_temp %>%
    ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
    geom_histogram()

duration_box / duration_hist

# Duration ----------------------------------------------------------------

evenodd_box <-
  data_temp %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_boxplot()

evenodd_hist <-
  data_temp %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_histogram()

evenodd_box / evenodd_hist

#  -----------------------------------------------------------------------

diff_hist <-
  data_temp %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_histogram()

diff_box <-
  data_temp %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_boxplot()

diff_box / diff_hist





# Validate ----------------------------------------------------------------



### This could be done with the package `validate`
library(validate)

validity_rules <- 
  validate::validator(
    air_force_warrant_officer = air_force_warrant_officer == 0,
    space_force = branch_space_force == 0,
    branch_none = branch_none == 0,
    inconsistent_children = inconsistent_children == 0,
    inconsistent_children_age = inconsistent_children_age == 0,
    inconsistent_education = inconsistent_education == 0,
    inconsistent_rank = inconsistent_rank == 0,
    validity_years = validity_years >= 0,
    validity_check = failed_validity_check == 0,
    attn_check_1 = failed_attn_check_1 == 0,
    attn_check_2 = failed_attn_check_2 == 0,
    psychsyn = psychsyn > .2,
    psychant = psychant < -.2,
    evenodd = evenodd < 0,
    honeypot1 = is.na(honeypot1),
    honeypot2 = is.na(honeypot2),
    honeypot3 = is.na(honeypot3)
  )

quality_check <- validate::confront(data, validity_rules)
validate::summary(quality_check)
validate::barplot(quality_check, xlab = "")

validate::aggregate(quality_check, by="record")



