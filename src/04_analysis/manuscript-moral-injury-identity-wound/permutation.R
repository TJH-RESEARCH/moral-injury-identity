


# Infer -------------------------------------------------------------------
library(infer)

observed_fit <- 
  data %>% 
  filter(branch_public_health == 0,
         service_era_korea == 0) %>% 
  infer::specify(wis_total ~ 
                   mios_total + 
                   years_service +
                   branch +
                   race +
                   military_family) %>% 
  infer::fit()

# Use permutation to generate a null distribution
null_fit <- 
  data %>% 
  infer::specify(wis_total ~ 
                   mios_total + 
                   years_service +
                   branch +
                   race +
                   military_family) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 5000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit,
  point_estimate = observed_fit,
  level = .95
  
)


null_fit %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red')


infer::visualize() +
  shade_p_value(observed_fit, direction = 'boh')


