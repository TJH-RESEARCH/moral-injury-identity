
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
                 wis_cluster +
                 civilian_cluster +
                 wis_cluster *
                 civilian_cluster
                   ) %>% 
  infer::fit()

## Use permutation to generate a null distribution
null_fit_blendedness <- 
  data %>% 
  infer::specify(biis_blendedness ~ 
                   wis_cluster +
                   civilian_cluster +
                   wis_cluster *
                   civilian_cluster) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
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
                   wis_cluster +
                   civilian_cluster +
                   wis_cluster *
                   civilian_cluster
  ) %>% 
  infer::fit()

## Use permutation to generate a null distribution
null_fit_harmony <- 
  data %>% 
  infer::specify(biis_harmony  ~ 
                   wis_cluster +
                   civilian_cluster +
                   wis_cluster *
                   civilian_cluster) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
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


null_fit_harmony %>%
  filter(term != 'intercept') %>% 
  left_join(observed_fit_harmony, by = c('term' = 'term')) %>% 
  rename(null = estimate.x, point = estimate.y) %>% 
  ggplot(aes(null)) +
  geom_histogram() +
  facet_grid(vars(term)) +
  geom_vline(aes(xintercept = point), color = '#d55e00') +
  theme_fonts +
  theme_bw() +
  labs(title = 'Permutation Testing', 
       subtitle = 'Observed Point Estimate on Null Distribution') +
  theme(axis.title.y = element_blank(), 
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank())




# Bootstrap ---------------------------------------------------------------

library(lmboot)

results_boot_blendedness <- 
  lmboot::ANOVA.boot(as.vector(biis_blendedness) ~ 
                     civilian_cluster +
                     wis_cluster +
                     civilian_cluster * wis_cluster,
                   B = 1000,
                   type = 'residual',
                   wild.dist = 'normal',
                   seed = 1,
                   data = data
                    )

results_boot_blendedness$`p-values`
