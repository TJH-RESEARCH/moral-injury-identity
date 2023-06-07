
# Bayesian multiple mediation

## two options: serial multiple mediation or parallel multiple mediation

library(brms)
options(brms.backend = "cmdstanr")
library(cmdstanr)
cmdstanr::set_cmdstan_path('~/cmdstan/')
library(ggthemes)

# Parallel ----------------------------------------------------------------

## Model 1: MIOS -> WIS Subscales -> MCARM

model_1 <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(mcarm_total ~ 
               1 + 
               wis_private_regard_total + 
               wis_public_regard_total +
               wis_interdependent_total + 
               wis_connection_total + 
               wis_family_total + 
               wis_centrality_total + 
               wis_skills_total + 
               mios_total + 
               mios_ptsd_symptoms_total +
               military_family_total +
               years_separation +
               years_service + 
               highest_rank +
               unmet_needs_total) +
      brms::bf(wis_private_regard_total ~
                 1 + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      brms::bf(wis_public_regard_total ~
                 1 + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      brms::bf(wis_interdependent_total ~
                 1 + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      brms::bf(wis_connection_total ~
                 1 + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      brms::bf(wis_family_total ~
                 1 + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      brms::bf(wis_centrality_total ~
                 1 + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      brms::bf(wis_skills_total ~
                 1 + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      set_rescor(FALSE),
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
  scale_color_ptol() +
  scale_fill_ptol() +
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
  mutate(a1 = b_wisprivateregardtotal_mios_total,
         a2 = b_wispublicregardtotal_mios_total,
         a3 = b_wisinterdependenttotal_mios_total,
         a4 = b_wisconnectiontotal_mios_total,
         a5 = b_wisfamilytotal_mios_total,
         a6 = b_wiscentralitytotal_mios_total,
         a7 = b_wisskillstotal_mios_total,
         b1 = b_mcarmtotal_wis_private_regard_total,
         b2 = b_mcarmtotal_wis_public_regard_total,
         b3 = b_mcarmtotal_wis_interdependent_total,
         b4 = b_mcarmtotal_wis_connection_total,
         b5 = b_mcarmtotal_wis_family_total,
         b6 = b_mcarmtotal_wis_centrality_total,
         b7 = b_mcarmtotal_wis_skills_total,
         c_prime = b_mcarmtotal_mios_total,
         im1 = b_wisprivateregardtotal_Intercept,
         im2 = b_wispublicregardtotal_Intercept,
         im3 = b_wisinterdependenttotal_Intercept,
         im4 = b_wisconnectiontotal_Intercept,
         im5 = b_wisfamilytotal_Intercept,
         im6 = b_wiscentralitytotal_Intercept,
         im7 = b_wisskillstotal_Intercept,
         iy  = b_mcarmtotal_Intercept
  )


# parameter estimates on the paths
draws %>% 
  pivot_longer(a1:iy) %>% 
  group_by(name) %>% 
  tidybayes::mean_qi(value) %>% 
  mutate_if(is_double, round, digits = 3) %>% print(n = 50)


# Calculate the indirect effects
draws <- draws %>%  
  mutate(a1b1    = a1 * b1,
         a2b2    = a2 * b2,
         a3b3    = a3 * b3,
         a4b4    = a4 * b4,
         a5b5    = a5 * b5,
         a6b6    = a6 * b6,
         a7b7    = a7 * b7) %>% 
  mutate(total_indirect_effect = a1b1 + a2b2 + a3b3 + a4b4 + a5b5 + a6b6 + a7b7)


# summarize posterior distributions of indirect effects
draws %>% 
  pivot_longer(a1b1:total_indirect_effect) %>% 
  group_by(name) %>% 
  tidybayes::median_qi(value) %>% 
  bind_rows(
    draws %>% 
      pivot_longer(a1b1:total_indirect_effect) %>% 
      group_by(name) %>% 
      tidybayes::mean_qi(value)
  ) %>% 
  mutate_if(is_double, round, digits = 3) %>% arrange(name)



# Plot indirect effects
my_labels <- c(expression(italic(a)[1]*italic(b)[1]),
               expression(italic(a)[2]*italic(b)[2]),
               expression(italic(a)[3]*italic(b)[3]),
               expression(italic(a)[4]*italic(b)[4]),
               expression(italic(a)[5]*italic(b)[5]),
               expression(italic(a)[6]*italic(b)[6]),
               expression(italic(a)[7]*italic(b)[7]))

draws %>% 
  pivot_longer(a1b1:a7b7) %>% 
  ggplot(aes(x = value, fill = name, color = name)) +
  geom_density(alpha = .5) +
  scale_color_ptol(NULL, labels = my_labels,
                   guide = guide_legend(label.hjust = 0)) +
  scale_fill_ptol(NULL, labels = my_labels,
                  guide = guide_legend(label.hjust = 0)) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = "The indirect effects of the parallel multiple mediator model",
       x = NULL) +
  theme_minimal()

# Plot the total indirect effect
draws %>% 
  pivot_longer(total_indirect_effect) %>% 
  
  # plot!
  ggplot(aes(x = value, fill = name, color = name)) +
  geom_density(alpha = .5) +
  scale_color_ptol(NULL, labels = 'Total Indirect Effect',
                   guide = guide_legend(label.hjust = 0)) +
  scale_fill_ptol(NULL, labels = 'Total Indirect Effect',
                  guide = guide_legend(label.hjust = 0)) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = "Total Indirect Effect",
       x = NULL) +
  theme_minimal()


# Get c and c_prime -------------------------------------------------------
draws <- 
  draws %>% 
  mutate(c             = b_mcarmtotal_mios_total + total_indirect_effect,
         c_prime       = b_mcarmtotal_mios_total,
         diff_c_cprime = c - c_prime)

draws %>% 
  pivot_longer(c(c_prime, c)) %>% 
  group_by(name) %>% 
  summarize(mean = mean(value), 
            ll   = quantile(value, probs = .025),
            ul   = quantile(value, probs = .975)) %>% 
  mutate_if(is_double, round, digits = 3)


# Plot c-prime and c
draws %>% 
  pivot_longer(c(c_prime, c)) %>% 
  
  # plot!
  ggplot(aes(x = value, fill = name, color = name)) +
  geom_density(alpha = .5) +
  scale_color_ptol(NULL, labels = c('c-prime', 'c'),
                   guide = guide_legend(label.hjust = 0)) +
  scale_fill_ptol(NULL, labels = c('c-prime', 'c'),
                  guide = guide_legend(label.hjust = 0)) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = "Direct and Mediated Direct Effect",
       x = NULL) +
  theme_minimal()


# Plot the difference between c and c prime
draws %>% 
  pivot_longer(diff_c_cprime) %>% 
  
  # plot!
  ggplot(aes(x = value, fill = name, color = name)) +
  geom_density(alpha = .5) +
  scale_color_ptol(NULL, labels = 'difference',
                   guide = guide_legend(label.hjust = 0)) +
  scale_fill_ptol(NULL, labels = 'difference',
                  guide = guide_legend(label.hjust = 0)) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = "Differece between C and C-prime",
       x = NULL) +
  theme_minimal()



# -------------------------------------------------------------------------



# Really seems like all the mediator variables wash each other out
# may be worth using cluster analysis with the WIS subscales
# although it is designed so that each is a separate variable

## One straightforward test is that identity regard decreases.
## Here the idea is that private regard influences public regard

# Private regard causes Public regard

model_multi_mediation <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(mcarm_total ~ 
               1 + 
               wis_private_regard_total + 
               wis_public_regard_total +
               mios_total + 
               mios_ptsd_symptoms_total +
               military_family_total +
               years_separation +
               years_service + 
               highest_rank +
               unmet_needs_total) +
      brms::bf(wis_private_regard_total ~
                 1 + 
                 wis_public_regard_total +
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      brms::bf(wis_public_regard_total ~
                 1 + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 military_family_total +
                 years_separation + 
                 years_service + 
                 highest_rank +
                 unmet_needs_total
      ) +
      set_rescor(FALSE),
    cores = 4)

model_multi_mediation %>% print(digits = 3)

model_multi_mediation %>% bayes_R2() %>% round(digits = 3)


# Plot R-squared for each regression in the model
bayes_R2(model_multi_mediation, summary = F) %>% 
  data.frame() %>% 
  pivot_longer(everything()) %>% 
  mutate(name = str_remove(name, "R2")) %>% 
  
  ggplot(aes(x = value, color = name, fill = name)) +
  geom_density(alpha = .5) +
  scale_color_ptol() +
  scale_fill_ptol() +
  scale_x_continuous(NULL, limits = 0:1) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = expression(The~italic(R)^2*" distributions for model_multi_mediation, the serial multiple mediator model"),
       subtitle = "") +
  theme_minimal() +
  theme(legend.title = element_blank())


# Get draws and rename with common mediation path names
draws <- 
  model_multi_mediation %>% 
  as_draws_df() %>% 
  mutate(a1 = b_wisprivateregardtotal_mios_total,
         a2 = b_wispublicregardtotal_mios_total,
         b1 = b_mcarmtotal_wis_private_regard_total,
         b2 = b_mcarmtotal_wis_public_regard_total,
         c_prime = b_mcarmtotal_mios_total,
         d21 = b_wisprivateregardtotal_wis_public_regard_total,
         im1 = b_wisprivateregardtotal_Intercept,
         im2 = b_wispublicregardtotal_Intercept,
         iy  = b_mcarmtotal_Intercept
  )

# parameter estimates on the paths
draws %>% 
  pivot_longer(a1:iy) %>% 
  group_by(name) %>% 
  tidybayes::mean_qi(value) %>% 
  mutate_if(is_double, round, digits = 3)

# Calculate indirect effects
draws <- draws %>%  
  mutate(a1b1    = a1 * b1,
         a2b2    = a2 * b2,
         a1d21b2 = a1 * d21 * b2) %>% 
  mutate(total_indirect_effect = a1b1 + a2b2 + a1d21b2)

# summarize posterior distributions of indirect effects
draws %>% 
  pivot_longer(a1b1:total_indirect_effect) %>% 
  group_by(name) %>% 
  tidybayes::median_qi(value) %>% 
  bind_rows(
    draws %>% 
      pivot_longer(a1b1:total_indirect_effect) %>% 
      group_by(name) %>% 
      tidybayes::mean_qi(value)
  ) %>% 
  mutate_if(is_double, round, digits = 3) %>% arrange(name)

# contrasts
draws %>%  
  mutate(c1 = a1b1 - a2b2,
         c2 = a1b1 - a1d21b2,
         c3 = a2b2 - a1d21b2) %>% 
  pivot_longer(c1:c3) %>% 
  group_by(name) %>% 
  tidybayes::median_qi(value) %>% 
  mutate_if(is_double, round, digits = 3)


# Plot indirect effects
# this will help us save a little space with the plot code
my_labels <- c(expression(italic(a)[1]*italic(b)[1]),
               expression(italic(a)[1]*italic(d)[21]*italic(b)[1]),
               expression(italic(a)[2]*italic(b)[2]),
               "total indirect effect")
# wrangle
draws %>% 
  pivot_longer(a1b1:total_indirect_effect) %>% 
  
  # plot!
  ggplot(aes(x = value, fill = name, color = name)) +
  geom_density(alpha = .5) +
  scale_color_ptol(NULL, labels = my_labels,
                   guide = guide_legend(label.hjust = 0)) +
  scale_fill_ptol(NULL, labels = my_labels,
                  guide = guide_legend(label.hjust = 0)) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = "The four indirect effects of the serial multiple mediator model",
       x = NULL) +
  theme_minimal()

## So these are not 0, they are close to -.1.
## Are they practically significant?
### Looks like no: the MCARM ranges in this sample from 28 to 101
### The WIS Private from 8 to 28
### so 20 * -.1 = -2. 
## A drop of 2 when the range is 101 - 28 is practically insignificant.
## The main problem seems to be the a paths. The d21 path is strong.
## The b1 and b2 paths have better coefficients, especially b2
## well, see what happens when the data set is finalized.  

data %>%
  summarise(mean_mcarm = mean(mcarm_total), 
            sd_mcarm = sd(mcarm_total),
            max_mcarm = max(mcarm_total), 
            min_mcarm = min(mcarm_total), 
            mean_mios = mean(mios_total), 
            sd_mios = sd(mios_total),
            max_mios = max(mios_total), 
            min_mios = min(mios_total),
            mean_public = mean(wis_public_regard_total), 
            sd_public = sd(wis_public_regard_total),
            max_public = max(wis_public_regard_total), 
            min_public = min(wis_public_regard_total),
            mean_private = mean(wis_private_regard_total), 
            sd_private = sd(wis_private_regard_total),
            max_private = max(wis_private_regard_total), 
            min_private = min(wis_private_regard_total)) %>% glimpse()

## well, see what happens when the data set is finalized. 
## I might also try the identity cluster analysis variable



# -------------------------------------------------------------------------
