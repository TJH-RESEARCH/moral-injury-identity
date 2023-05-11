
# SCRAPS ------------------------------------------------------------------



# WORKING -----------------------------------------------------------------

# to undo the reverse coding:
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
  
)




# Plots of Inattention Indices --------------------------------------------


# -------------------------------------------------------------------------
# Inspect: Average String

data %>% 
  ggplot2::ggplot(aes(avgstr)) +
  geom_boxplot()

# Inspect: Even-Odd Consistency

data %>% 
  ggplot2::ggplot(aes(evenodd)) +
  geom_histogram()


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




# Outlier Analysis --------------------------------------------------------

data <-
  data %>% 
  mutate(
    # Average longstring twice the standard deviation
    outlier_longstring_no_reverse = avgstr_no_reverse > mean(avgstr_no_reverse) + (2 * sd(avgstr_no_reverse)),
    outlier_longstring_reverse = avgstr_reverse > mean(avgstr_reverse) + (2 * sd(avgstr_reverse)),
    
    ## Psych Synonyms Correlation less than one and half standard deviations
    outlier_psychsyn = psychsyn < mean(psychsyn) - (2 * sd(psychsyn)),
    negative_correlation_psychsyn = psychsyn < 0,
    
    ## Psych Antonyms Correlation greater than one and half standard deviations
    outlier_psychant = psychant > mean(psychant) + (2 * sd(psychant)),
    positive_correlation_psychant  = psychant > 0,
    
    ## Even-Odd Correaltion less than one and half standard deviations
    outlier_evenodd = evenodd < mean(evenodd) - (2 * sd(evenodd)),
    
    ## IRV 
    outlier_irvTotal = irvTotal > mean(irvTotal) + (2 * sd(irvTotal)),
    outlier_irv1 = irv1 > mean(irv1) + (2 * sd(irv1)),
    outlier_irv2 = irv2 > mean(irv2) + (2 * sd(irv2)),
    outlier_irv3 = irv3 > mean(irv3) + (2 * sd(irv3)),
    outlier_irv4 = irv4 > mean(irv4) + (2 * sd(irv4)),
    outlier_irv5 = irv5 > mean(irv5) + (2 * sd(irv5)),
    outlier_irv6 = irv6 > mean(irv6) + (2 * sd(irv6)),
    
    
    ## Duration faster than one and a half standard deviations
    outlier_duration = `Duration (in minutes)` < mean(`Duration (in minutes)`) - (1.5 * sd(`Duration (in minutes)`)),
    
    ## Difference in M2C-Q and M-CARM greater than 1.5 standard deviations
    outlier_mcarm_m2cq_difference = mcarm_m2cq_difference < mean(mcarm_m2cq_difference) - (1.5 * sd(mcarm_m2cq_difference))
    
  )


# Mahad -----------------------------------------------------------------------------

#data <-
#data_scales %>% 
# scc_9 and #scc_8 are colinear in this sample. 
# remove one to make the function work. 
#select(!c(scc_9, m2cq_11)) %>% 
#careless::mahad(.) %>% 
#bind_cols(data)



cor.test(data$m2cq_mean, data$mcarm_total)




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


# -------------------------------------------------------------------------


## Finds individual-level reliability by determining which items are 
## psychometrically similar and different. The sample-level correlations
## between each possible item pair are calculated.
## The user sets a 'critical value,' then pairs with 
## positive/negative correlations of greater magnitudes than the critical value
## are determined to be synonyms/antonyms.
## Each individual respondents correlation between the set of pairs is calculated.


## First, find a suitable critical value:

data_scales %>% 
  careless::psychsyn_critval(., anto = FALSE) %>% 
  ggplot2::ggplot(aes(x = Freq)) +
  geom_histogram()

# Compare MCARM and M2CQ --------------------------------------------------
## These scales should be negatively correlated. 
## M-CARM lower scores indicate greater difficulty. 1-4. 21 items
## M2C-Q higher scores indicate greater difficulty. 0-4. 16 items.



# Even-Odd Consistency ------------------------------------------------------
## Even-odd consistency divides each unidimensional measure 
## in two based on even and odd items. If respondents were attentive/careful,
## these two halves should correlate positively. 
## The more subscales there are in the survey, the better a measure this is. 

## If reverse scored items are in the survey, 
## they need to be reverse coded before even-odd analysis.
## Longstring should be performed twice: once with and once without the reverse coding.  




# Create visualizations ---------------------------------------------------

## Load packages 
library(patchwork)

## Create a new list

## Psychometric Synonyms/Antonyms
psych_scatter <-
  data %>% 
  ggplot2::ggplot(aes(x = psychant, 
                      y = psychsyn)) +
  geom_text(aes(label = id)) +
  labs(title = 'Psychological Synonym and Antonym Correlations') +
  lims(x = c(-1, 0), y = c(0, 1))

psychsyn_box <-
  data %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_boxplot() +
  labs(title = 'Psychological Synonym Correlation')

psychsyn_hist <-
  data %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_histogram()

psychant_box <-
  data %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_boxplot() +
  labs(title = 'Psychological Antonym Correlation')

psychant_hist <-
  data %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_histogram()

## Duration

duration_box <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_boxplot() +
  labs(title = 'Duration')

duration_hist <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_histogram()


## Even-Odd Consistency

evenodd_box <-
  data %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_boxplot() +
  labs(title = 'Even-Odd Consistency')

evenodd_hist <-
  data %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_histogram() +
  labs(title = '')

## Difference between M2C-Q and M-CARM scores  

diff_hist <-
  data %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_histogram() +
  labs(title = '')

diff_box <-
  data %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_boxplot() +
  labs(title = 'Difference between M2C-Q and M-CARM (0-4 range)')


# Visualize ---------------------------------------------------------------

psychsyn_box / psychsyn_hist
psychant_box / psychant_hist
psych_scatter
duration_box / duration_hist
evenodd_box / evenodd_hist
diff_box / diff_hist


## Declare validation rules -------------------------------------------------
validity_rules <- 
  validate::validator(
    air_force_warrant_officer = air_force_warrant_officer == 0,
    space_force = branch_space_force == 0,
    branch_none = branch_none == 0,
    inconsistent_children = inconsistent_children == 0,
    inconsistent_children_age = inconsistent_children_age == 0,
    inconsistent_education_years = inconsistent_education_years == 0,
    inconsistent_education = inconsistent_education == 0, 
    inconsistent_rank = inconsistent_rank == 0,
    inconsistent_religion = inconsistent_religion == 0, 
    inconsistent_retirement = inconsistent_retirement == 0, 
    validity_check_1 = validity_check_1 == 1,
    attention_check_1 = attention_check_biis == 1,
    attention_check_2 = attention_check_wis == 1,
    honeypot1 = honeypot1 == 0,
    honeypot2 = honeypot2 == 0,
    honeypot3 = honeypot3 == 0,
    validity_years = validity_years >= 0,
    
    outlier_psychant = outlier_psychant == 0,
    outlier_psychsyn = outlier_psychsyn == 0,
    outlier_longstring_reverse = outlier_longstring_reverse == 0,
    outlier_longstring_no_reverse = outlier_longstring_no_reverse == 0,
    
    
    outlier_evenodd = outlier_evenodd == 0,
    #outlier_duration = outlier_evenodd == 0,
    outlier_irvTotal = outlier_irvTotal == 0,
    outlier_irv1 = outlier_irv1 == 0,
    outlier_irv2 = outlier_irv2 == 0,
    outlier_irv3 = outlier_irv3 == 0,
    outlier_irv4 = outlier_irv4 == 0,
    outlier_irv5 = outlier_irv5 == 0,
    outlier_irv6 = outlier_irv6 == 0,
    outlier_mcarm_m2cq_diff = outlier_mcarm_m2cq_difference == 0
  )
