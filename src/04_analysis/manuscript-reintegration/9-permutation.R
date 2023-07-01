


# Infer -------------------------------------------------------------------
library(infer)


observed_fit_mcarm <- 
  data %>% 
  filter(branch_public_health == 0,
         service_era_korea == 0) %>% 
  infer::specify(mcarm_total ~
                 mios_total +
                 biis_harmony + 
                 biis_blendedness + mios_total +
                 mios_ptsd_symptoms + 
                 service_era_persian_gulf + 
                 service_era_post_911 + 
                 service_era_vietnam + 
                 sex_male + 
                 disability) %>% 
  infer::fit()


# Use permutation to generate a null distribution
null_fit_mcarm <- 
  data %>% 
  infer::specify(mcarm_total ~
                   mios_total +
                   biis_harmony + 
                   biis_blendedness + mios_total +
                   mios_ptsd_symptoms + 
                   service_era_persian_gulf + 
                   service_era_post_911 + 
                   service_era_vietnam + 
                   sex_male + 
                   disability) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 5000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit_mcarm,
  point_estimate = observed_fit_mcarm,
  level = .95
  
)


null_fit_mcarm %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit_mcarm %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red')

