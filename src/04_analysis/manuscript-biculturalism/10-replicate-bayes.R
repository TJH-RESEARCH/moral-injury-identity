### Military-Civilian Biculturalism?: 
### Bicultural Identity and the Adjustment of Separated Service Members

# Replicate the analysis with Bayesian regression


# Replication with Bayes -------------------------------------------------------------------
library(brms)
options(brms.backend = "cmdstanr")
library(cmdstanr)
cmdstanr::set_cmdstan_path('~/cmdstan/')
library(tidybayes)

f_blendedness <- brms::bf(biis_blendedness ~ 1 +
                            wis_centrality_total +
                            wis_connection_total +
                            wis_family_total +
                            wis_interdependent_total +
                            wis_private_regard_total +
                            wis_public_regard_total +
                            wis_skills_total +
                            civilian_commit_total)
f_harmony <- brms::bf(biis_harmony ~ 1 +
                        wis_centrality_total +
                        wis_connection_total +
                        wis_family_total +
                        wis_interdependent_total +
                        wis_private_regard_total +
                        wis_public_regard_total +
                        wis_skills_total +
                        civilian_commit_total)

model_biculturalism <- 
  brms::brm(
    data = data, 
    family = gaussian,
    f_blendedness + f_harmony + set_rescor(TRUE),
    cores = 4)



# Print the model summary
model_biculturalism %>% print(digits = 3)

# Print the R-squared estimates for each regression
model_biculturalism %>% bayes_R2() %>% round(digits = 3)

# Plot the R-squared posterior distributions for each regression in the model
model_biculturalism %>% 
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


# Get draws
draws <- 
  model_biculturalism %>% 
  as_draws_df()


# parameter estimates
draws %>% 
  pivot_longer(b_biisblendedness_Intercept:b_biisharmony_civilian_commit_total) %>% 
  group_by(name) %>% 
  tidybayes::mean_qi(value) %>% 
  mutate_if(is_double, round, digits = 3) %>% 
  rename(mean = value) %>% print(n = 50)
