
# PERMUTATION TESTING

# Military-Civilian Biculturalism?: 
# Bicultural Identity and the Adjustment of Separated Service Members



# Load Package ---------------------------------------------------------------
library(infer)

# Model 1: Blendedness -------------------------------------------------------

## Create observed fit
observed_fit_blendedness <- 
  data %>% 
  infer::specify(biis_blendedness ~ 
                 wis_centrality_total +
                 wis_connection_total +
                 wis_family_total +
                 wis_interdependent_total +
                 wis_private_regard_total +
                 wis_public_regard_total +
                 wis_skills_total +
                 civilian_commit_total
                   ) %>% 
  infer::fit()

## Use permutation to generate a null distribution
null_fit_blendedness <- 
  data %>% 
  infer::specify(biis_blendedness ~ 
                   wis_centrality_total +
                   wis_connection_total +
                   wis_family_total +
                   wis_interdependent_total +
                   wis_private_regard_total +
                   wis_public_regard_total +
                   wis_skills_total +
                   civilian_commit_total) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 5000, type = 'permute') %>%             
  infer::fit()


# Get 95% confidence intervals
infer::get_confidence_interval(
  null_fit_blendedness,
  point_estimate = observed_fit_blendedness,
  level = .95
)

# Plot the observed point estimates on the null distributions
null_fit_blendedness %>%
  visualize() +
  shade_p_value(obs_stat = observed_fit_blendedness, direction = "two-sided")





# Model 2: Harmony -------------------------------------------------------

## Create observed fit
observed_fit_harmony <- 
  data %>% 
  infer::specify(biis_harmony ~ 
                   wis_centrality_total +
                   wis_connection_total +
                   wis_family_total +
                   wis_interdependent_total +
                   wis_private_regard_total +
                   wis_public_regard_total +
                   wis_skills_total +
                   civilian_commit_total
  ) %>% 
  infer::fit()

## Use permutation to generate a null distribution
null_fit_harmony <- 
  data %>% 
  infer::specify(biis_harmony ~ 
                   wis_centrality_total +
                   wis_connection_total +
                   wis_family_total +
                   wis_interdependent_total +
                   wis_private_regard_total +
                   wis_public_regard_total +
                   wis_skills_total +
                   civilian_commit_total) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 5000, type = 'permute') %>%             
  infer::fit()


# Get 95% confidence intervals
infer::get_confidence_interval(
  null_fit_harmony,
  point_estimate = observed_fit_harmony,
  level = .95
)

# Plot the observed point estimates on the null distributions
null_fit_harmony %>%
  visualize() +
  shade_p_value(obs_stat = observed_fit_harmony, direction = "two-sided")



