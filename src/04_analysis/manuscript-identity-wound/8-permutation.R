
# PERMUTATION




# Library -------------------------------------------------------------------
library(infer)


# Centrality -------------------------------------------------------------
observed_fit_centrality <- 
  data %>% 
  infer::specify(wis_centrality_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_family +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
                 ) %>% 
  infer::fit()

# Use permutation to generate a null distribution
null_fit_centrality <- 
  data %>% 
  infer::specify(wis_centrality_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_family +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit_centrality,
  point_estimate = observed_fit_centrality,
  level = .95
  
)

null_fit_centrality %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red') +
  labs(title = 'Military Centrality', 
       subtitle = 'Point estimate of Moral Injury coefficient on null distribution',
       x = 'Estimate (b)',
       y = 'Count'
       ) +
  theme_bw() +
  theme_fonts



# -------------------------------------------------------------------------


# Connection -------------------------------------------------------------
observed_fit_connection <- 
  data %>% 
  infer::specify(wis_connection_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_family +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::fit()

# Use permutation to generate a null distribution
null_fit_connection <- 
  data %>% 
  infer::specify(wis_connection_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_family +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit_connection,
  point_estimate = observed_fit_connection,
  level = .95
  
)

null_fit_connection %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red') +
  labs(title = 'Military Connection', 
       subtitle = 'Point estimate of Moral Injury coefficient on null distribution',
       x = 'Estimate (b)',
       y = 'Count'
  ) +
  theme_bw() +
  theme_fonts




# Family ------------------------------------------------------------------

observed_fit_family <- 
  data %>% 
  infer::specify(wis_family_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_family +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::fit()

# Use permutation to generate a null distribution
null_fit_family <- 
  data %>% 
  infer::specify(wis_family_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_family +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit_family,
  point_estimate = observed_fit_family,
  level = .95
  
)

null_fit_family %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red') +
  labs(title = 'Military as Family', 
       subtitle = 'Point estimate of Moral Injury coefficient on null distribution',
       x = 'Estimate (b)',
       y = 'Count'
  ) +
  theme_bw() +
  theme_fonts



# Interdependent ----------------------------------------------------------


observed_fit_interdependent <- 
  data %>% 
  infer::specify(wis_interdependent_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_interdependent +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::fit()

# Use permutation to generate a null distribution
null_fit_interdependent <- 
  data %>% 
  infer::specify(wis_interdependent_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_interdependent +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit_interdependent,
  point_estimate = observed_fit_interdependent,
  level = .95
  
)

null_fit_interdependent %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red') +
  labs(title = 'Military as interdependent', 
       subtitle = 'Point estimate of Moral Injury coefficient on null distribution',
       x = 'Estimate (b)',
       y = 'Count'
  ) +
  theme_bw() +
  theme_fonts



# Private Regard ----------------------------------------------------------


observed_fit_private_regard <- 
  data %>% 
  infer::specify(wis_private_regard_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_private_regard +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::fit()

# Use permutation to generate a null distribution
null_fit_private_regard <- 
  data %>% 
  infer::specify(wis_private_regard_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_private_regard +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit_private_regard,
  point_estimate = observed_fit_private_regard,
  level = .95
  
)

null_fit_private_regard %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red') +
  labs(title = 'Military as private_regard', 
       subtitle = 'Point estimate of Moral Injury coefficient on null distribution',
       x = 'Estimate (b)',
       y = 'Count'
  ) +
  theme_bw() +
  theme_fonts


# Public Regard ----------------------------------------------------------


observed_fit_public_regard <- 
  data %>% 
  infer::specify(wis_public_regard_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_public_regard +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::fit()

# Use permutation to generate a null distribution
null_fit_public_regard <- 
  data %>% 
  infer::specify(wis_public_regard_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_public_regard +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit_public_regard,
  point_estimate = observed_fit_public_regard,
  level = .95
  
)

null_fit_public_regard %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red') +
  labs(title = 'Military as public_regard', 
       subtitle = 'Point estimate of Moral Injury coefficient on null distribution',
       x = 'Estimate (b)',
       y = 'Count'
  ) +
  theme_bw() +
  theme_fonts




# Skills ----------------------------------------------------------


observed_fit_skills <- 
  data %>% 
  infer::specify(wis_skills_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_skills +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::fit()

# Use permutation to generate a null distribution
null_fit_skills <- 
  data %>% 
  infer::specify(wis_skills_total ~ 
                   mios_total +
                   mios_ptsd_symptoms +
                   service_era_persian_gulf +
                   service_era_post_911 +
                   service_era_vietnam +
                   sex_male +
                   branch_air_force +
                   branch_marines +
                   branch_navy +
                   race_white +
                   military_skills +
                   years_service +
                   years_separation +
                   rank_e1_e3 +
                   rank_e7_e9 +
                   nonenlisted
  ) %>% 
  infer::hypothesize(null = 'independence') %>% 
  infer::generate(reps = 1000, type = 'permute') %>%             
  infer::fit()


infer::get_confidence_interval(
  null_fit_skills,
  point_estimate = observed_fit_skills,
  level = .95
  
)

null_fit_skills %>% 
  filter(term == 'mios_total') %>% 
  ggplot(aes(estimate)) +
  geom_histogram() + 
  geom_vline(xintercept = observed_fit %>% 
               filter(term == 'mios_total') %>% 
               select(estimate) %>% sum(), 
             color = 'red') +
  labs(title = 'Military as skills', 
       subtitle = 'Point estimate of Moral Injury coefficient on null distribution',
       x = 'Estimate (b)',
       y = 'Count'
  ) +
  theme_bw() +
  theme_fonts

