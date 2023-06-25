
#Bayesian MANOVA

library(brms)
options(brms.backend = "cmdstanr")
library(cmdstanr)
cmdstanr::set_cmdstan_path('~/cmdstan/')
library(tidybayes)


# Functions ---------------------------------------------------------------
standardize <- function(x) {
  (x - mean(x)) / sd(x)
}

# Correlation ---------------------------------------------------------------
model_correlation <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      brms::mvbind(wis_private_regard_total,
                   wis_public_regard_total,
                   wis_interdependent_total,
                   wis_connection_total,
                   wis_family_total,
                   wis_centrality_total,
                   wis_skills_total,
                   mios_ptsd_symptoms_total)  ~ 1
    ) + set_rescor(TRUE),
    cores = 4)

model_correlation %>% print(digits = 3)
model_correlation %>% posterior_summary()

# Multivariate Response Model ---------------------------------------------------------------
model_multivariate <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      
      brms::mvbind(wis_private_regard_total,
                     wis_public_regard_total,
                     wis_interdependent_total,
                     wis_connection_total,
                     wis_family_total,
                     wis_centrality_total,
                     wis_skills_total)  ~ 
        1 +
        mios_total +
        mios_ptsd_symptoms_total +
        years_service + 
        branch + 
        reserve +
        military_family_total +
        (1 + years_of_age | sex)
      ) + set_prior("normal(55,15)", class = "b", coef = "years_of_age"),
      set_rescor(TRUE),
    cores = 4)



# Regression including interaction:
res <- lm(
  cbind(wis_private_regard_total,
          wis_public_regard_total,
          wis_interdependent_total,
          wis_connection_total,
          wis_family_total,
          wis_centrality_total,
          wis_skills_total)  ~ 
  1 +
  mios_total +
  mios_ptsd_symptoms_total +
  years_service + 
  branch + 
  reserve +
  military_family_total +
  years_of_age + sex, data = data)


# Path diagram:
semPlot::semPaths(res)




# View the Model Summary
model_multivariate %>% print(digits = 3)

model_multivariate %>% 
  tidybayes::summarise_draws() %>% print(n = 200)

model_multivariate %>% 
  tidybayes::summarise_draws() %>% 
  filter(variable == "b_wisprivateregardtotal_mios_total" |
           variable == "b_wispublicregardtotal_mios_total" |
           variable == "b_wisinterdependenttotal_mios_total" |
           variable == "b_wisprivateregardtotal_mios_total" |
           variable == "b_wisconnectiontotal_mios_total" |
           variable == "b_wisfamilytotal_mios_total" |
           variable == "b_wiscentralitytotal_mios_total" |
           variable == "b_wisskillstotal_mios_total")

model_multivariate %>% brms::posterior_summary()

model_multivariate %>% tidybayes::parameters()
model_multivariate %>% spread_draws()
model_multivariate %>%
  spread_draws(condition_mean[condition]) %>%
  head(10)


# View the Regression Lines
model_multivariate %>% brms::conditional_effects()

pp_check(model_multivariate, resp = "wisinterdependenttotal")





draws <- model_multivariate %>% brms::as_draws()
tidybayes::tidy_draws(draws)



# View the R-squared
model_multivariate %>% brms::bayes_R2()

# Plot the R-squared posterior distributions for each regression in the model

model_multivariate %>% 
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



#vignette("brms_multilevel")
vignette("brms_overview")



# Standardized Multivariate Response Model ---------------------------------------------------------------

data <-
  data %>% 
  mutate(wis_private_regard_total_z  = standardize(wis_private_regard_total), 
         wis_public_regard_total_z  = standardize(wis_public_regard_total), 
         wis_interdependent_total_z = standardize(wis_interdependent_total),
         wis_connection_total_z      = standardize(wis_connection_total),
         wis_family_total_z      = standardize(wis_family_total),
         wis_centrality_total_z      = standardize(wis_centrality_total),
         wis_skills_total_z      = standardize(wis_skills_total),
         mios_total_z = standardize(mios_total),
         mios_ptsd_symptoms_total_z = standardize(mios_ptsd_symptoms_total)
         )

model_multi_standard <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      
      brms::mvbind(wis_private_regard_total_z,
                   wis_public_regard_total_z,
                   wis_interdependent_total_z,
                   wis_connection_total_z,
                   wis_family_total_z,
                   wis_centrality_total_z,
                   wis_skills_total_z
                   )  ~ 
        1 +
        mios_total_z +
        mios_ptsd_symptoms_total_z
    ) + set_rescor(TRUE),
    cores = 4)

# View the Model Summary
model_multi_standard %>% print(digits = 3)

# View the Regression Lines
model_multi_standard %>% brms::conditional_effects()

# View the R-squared
model_multi_standard %>% brms::bayes_R2()
