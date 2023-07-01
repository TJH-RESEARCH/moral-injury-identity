
# Replicate the analysis with Bayesian regression


# Replication with Bayes -------------------------------------------------------------------
library(brms)
options(brms.backend = "cmdstanr")
library(cmdstanr)
cmdstanr::set_cmdstan_path('~/cmdstan/')
library(tidybayes)

f1 <- brms::bf(wis_centrality_total ~ 1 + mios_total + mios_ptsd_symptoms_total + years_service + branch_air_force + branch_marines + branch_navy + race_white + military_family)
f2 <- brms::bf(wis_private_regard_total ~ 1 + mios_total + mios_ptsd_symptoms_total + years_service + branch_air_force + branch_marines + branch_navy + race_white + military_family)
f3 <- brms::bf(wis_public_regard_total ~ 1 + mios_total + mios_ptsd_symptoms_total + years_service + branch_air_force + branch_marines + branch_navy + race_white + military_family)
f4 <- brms::bf(wis_family_total ~ 1 + mios_total + mios_ptsd_symptoms_total + years_service + branch_air_force + branch_marines + branch_navy + race_white + military_family)
f5 <- brms::bf(wis_interdependent_total ~ 1 + mios_total + mios_ptsd_symptoms_total + years_service + branch_air_force + branch_marines + branch_navy + race_white + military_family)
f6 <- brms::bf(wis_connection_total ~ 1 + mios_total + mios_ptsd_symptoms_total + years_service + branch_air_force + branch_marines + branch_navy + race_white + military_family)
f7 <- brms::bf(wis_skills_total ~ 1 + mios_total + mios_ptsd_symptoms_total + years_service + branch_air_force + branch_marines + branch_navy + race_white + military_family)


model_1 <- 
  brms::brm(
    data = data, 
    family = gaussian,
    f1 + f2 + f3 + f4 + f5 + f6 + f7 + set_rescor(TRUE),
    cores = 4)



# Print the model summary
model_1 %>% print(digits = 3)

# Print the R-squared estimates for each regression
model_1 %>% bayes_R2() %>% round(digits = 3)

# Plot the R-squared posterior distributions for each regression in the model
model_1 %>% 
  bayes_R2(summary = F) %>% 
  data.frame() %>% 
  pivot_longer(everything()) %>% 
  mutate(name = str_remove(name, "R2")) %>% 
  
  ggplot(aes(x = value, color = name, fill = name)) +
  geom_density(alpha = .5) +
  ggthemes::scale_color_ptol() +
  ggthemes::scale_fill_ptol() +
  scale_x_continuous(NULL, limits = 0:1) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = expression(The~italic(R)^2*" distributions"),
       subtitle = "") +
  theme_minimal() +
  theme(legend.title = element_blank())



# Get draws and rename with common mediation path names
draws <- 
  model_1 %>% 
  as_draws_df() %>% 
  mutate(
    b_centrality = b_wiscentralitytotal_mios_total,
    b_connection = b_wisconnectiontotal_mios_total,
    b_family = b_wisfamilytotal_mios_total,
    b_interdependent = b_wisinterdependenttotal_mios_total,
    b_private_regard = b_wisprivateregardtotal_mios_total,
    b_public_regard = b_wispublicregardtotal_mios_total,
    b_skills = b_wisskillstotal_mios_total,
    iy_centrality = b_wiscentralitytotal_Intercept,
    iy_connection = b_wisconnectiontotal_Intercept,
    iy_family = b_wisfamilytotal_Intercept,
    iy_interdependent = b_wisinterdependenttotal_Intercept,
    iy_private_regard = b_wisprivateregardtotal_Intercept,
    iy_public_regard = b_wispublicregardtotal_Intercept,
    iy_skills = b_wisskillstotal_Intercept
  )


# parameter estimates on the paths
draws %>% 
  pivot_longer(b_centrality:iy_skills) %>% 
  group_by(name) %>% 
  tidybayes::mean_qi(value) %>% 
  mutate_if(is_double, round, digits = 3) %>% 
  rename(mean = value) %>% print(n = 50)
