
# Multiple Mediation



# Packages-------------------------------------------------------------------------
library(mma)



# MMA -------------------------------------------------------------

data_mma <-
  data %>% 
  select(
      # Outcome:
      mcarm_total,
      
      # Treatment:
      mios_total,
      
      # Mediators:
      wis_private_regard_total,
      wis_interdependent_total,
      wis_connection_total,
      wis_skills_total,
      wis_centrality_total,
      wis_public_regard_total,
      wis_family_total, 
      
      # Adjusted for:
      unmet_needs_total,
      mios_ptsd_symptoms_total,
      military_family_total,
      years_separation,
      years_service,
      highest_rank
      ) %>% 
  mutate(highest_rank = as.numeric(highest_rank))

glimpse(data_mma)
cor(data_mma) %>% round(2) %>% view()

x <- data_mma %>% select(!mcarm_total) # Predictor variables
y <- data_mma %>% select(mcarm_total) # Outcome variable

data.bin <- mma::data.org(x, 
                     y, 
                     pred = 1,              # Column of treatment variable in x
                     mediator = c(2:8),  # identifies all potential mediators in x.
                       jointm = list(n = 1,
                                   j1 = c('wis_private_regard_total',
                                          'wis_interdependent_total',
                                          'wis_connection_total',
                                          'wis_skills_total',
                                          'wis_centrality_total',
                                          'wis_public_regard_total',
                                          'wis_family_total')), 
                     alpha = 0.4, alpha2 = 0.4)
summary(data.bin) 
names(weight_behavior)




# Lavaan -------------------------------------------------------------------------

library(lavaan)

multipleMediation <- '
mcarm_total ~ b1 * wis_private_regard_total + 
              b2 * wis_public_regard_total + 
              c * mios_total + 
              z1 * unmet_needs_total + 
              z2 * mios_ptsd_symptoms_total +
              z3 * military_family_total +
              z4 * years_separation +
              z5 * years_service +
              z6 * highest_rank
wis_private_regard_total ~ a1 * mios_total + 
              z1 * unmet_needs_total + 
              z2 * mios_ptsd_symptoms_total +
              z3 * military_family_total +
              z4 * years_separation +
              z5 * years_service +
              z6 * highest_rank
wis_public_regard_total ~ a2 * mios_total + 
              z1 * unmet_needs_total + 
              z2 * mios_ptsd_symptoms_total +
              z3 * military_family_total +
              z4 * years_separation +
              z5 * years_service +
              z6 * highest_rank
indirect1 := a1 * b1
indirect2 := a2 * b2
total := c + (a1 * b1) + (a2 * b2)

# Covariances:
wis_private_regard_total ~~ wis_public_regard_total
'
fit <- lavaan::sem(model = multipleMediation, data = data_mma)
summary(fit)


constrainedMediation <- '
mcarm_total ~ b1 * wis_private_regard_total + 
              b2 * wis_public_regard_total + 
              c * mios_total + 
              z1 * unmet_needs_total + 
              z2 * mios_ptsd_symptoms_total +
              z3 * military_family_total +
              z4 * years_separation +
              z5 * years_service +
              z6 * highest_rank
wis_private_regard_total ~ a1 * mios_total
wis_public_regard_total ~ a2 * mios_total
indirect1 := a1 * b1
indirect2 := a2 * b2
total := c + (a1 * b1) + (a2 * b2)

# Covariances:
wis_private_regard_total ~~ wis_public_regard_total

# constrain
indirect1 == indirect2
'
noConstrFit <- lavaan::sem(model = multipleMediation, data = data_mma)
constrFit <- lavaan::sem(model = constrainedMediation, data = data_mma)
summary(constrFit)
anova(noConstrFit, constrFit)



# Pysch package -----------------------------------------------------------

library(psych)

mediation_psych = mediate(
  depress2 ~ treat + (job_seek) - econ_hard - sex - age, 
  data = jobs,
  n.iter = 500
)

mediation_psych <-
  psych::mediate(
          mcarm_total ~ 
            mios_total + 
            (wis_private_regard_total) - 
            wis_public_regard_total - 
            unmet_needs_total -
            mios_ptsd_symptoms_total -
            military_family_total - 
            years_separation - 
            years_service - 
            highest_rank,
          data = data_mma,
          n.iter = 1000
  )

mediation_psych
summary(mediation_psych)

# seems like it only handles single mediation

# brms --------------------------------------------------------------------


library(brms)
options(brms.backend = "cmdstanr")
library(cmdstanr)

cmdstanr::set_cmdstan_path('~/cmdstan/')

# to calculate bayesian correlations
model_correlation <- 
  brms::brm(
    data = data, 
    family = gaussian,
    bf(mvbind(mios_total, mcarm_total) ~ 1) +
    set_rescor(TRUE),
  cores = 4)

model_correlation
cor(data$mios_total, data$mcarm_total)

# Model mediation
y_model <- brms::bf(mcarm_total ~ 1 + 
                      wis_private_regard_total + 
                      mios_total + 
                      unmet_needs_total +
                      mios_ptsd_symptoms_total +
                      military_family_total +
                      years_separation +
                      years_service + 
                      highest_rank +
                    unmet_needs_total)
m_model <- brms::bf(wis_private_regard_total ~
                      1 + 
                      mios_total + 
                      unmet_needs_total +
                      mios_ptsd_symptoms_total +
                      military_family_total +
                      years_separation + 
                      years_service + 
                      highest_rank +
                      unmet_needs_total
                    )

model_mediation <- 
  brms::brm(
    data = data, 
    family = gaussian,
    y_model + m_model + set_rescor(FALSE),
  cores = 4)

summary(model_mediation)

library(ggthemes)
brms::bayes_R2(model_mediation, summary = F) %>% 
  data.frame() %>% 
  pivot_longer(everything()) %>% 
  mutate(name = str_remove(name, "R2")) %>% 
  
  ggplot(aes(x = value, fill = name)) +
  geom_density(color = "transparent", alpha = .66) +
  coord_cartesian(xlim = 0:1) +
  scale_fill_colorblind(NULL) + 
  labs(title = expression(paste("The ", italic("R")^{2}, " distributions for model_mediation")),
       x = NULL) + theme_classic()
  

# isolate the a path # wisprivateregardtotal_mios_total  
fixef(model_mediation)['wisprivateregardtotal_mios_total', ]

# isolate the b path # mcarmtotal_wis_private_regard_total 
fixef(model_mediation)['mcarmtotal_wis_private_regard_total', ]

# "So the naive approach would be to just multiply them."  # https://bookdown.org/content/b472c7b3-ede5-40f0-9677-75c3704c7e5c/the-simple-mediation-model.html
(fixef(model_mediation)['wisprivateregardtotal_mios_total', ] * 
    fixef(model_mediation)['mcarmtotal_wis_private_regard_total', ]) %>% 
  round(digits = 3)

# Now, this does get us the correct ‘Estimate’ (i.e., posterior mean). However, the posterior  SD and 95% intervals are off. If you want to do this properly, you need to work with the poster samples themselves. We do that with the as_draws_df() function.
draws <- as_draws_df(model_mediation)

# these are the draws from the posterior distribution of each estimated parameter:
glimpse(draws)


# "Here we compute the indirect effect, ab."
draws <- draws %>% 
  mutate(ab = b_wisprivateregardtotal_mios_total * b_mcarmtotal_wis_private_regard_total)

# "Now we have ab as a properly computed vector, we can summarize it with the quantile() function."
quantile(draws$ab, probs = c(.5, .025, .975)) %>% 
  round(digits = 3)

# "And we can even visualize it as a density."

draws %>% 
  ggplot(aes(x = ab)) +
  geom_density(color = "transparent", 
               fill = colorblind_pal()(3)[3]) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = expression(paste("Our indirect effect, the ", italic("ab"), " pathway")),
       x = NULL) +
  theme_classic()

draws %>% 
  summarize(mean   = mean(ab),
            median = median(ab)) %>% 
  round(digits = 3)



# Attempt 2 ---------------------------------------------------------------



# Model mediation


model_mediation <- 
  brms::brm(
    data = data, 
    family = gaussian,
      brms::bf(mcarm_total ~ 
                1 + 
                wis_private_regard_total + 
                mios_total + 
                unmet_needs_total +
                mios_ptsd_symptoms_total +
                military_family_total +
                years_separation +
                years_service + 
                highest_rank +
                unmet_needs_total) +
      brms::bf(wis_private_regard_total ~
                1 + 
                mios_total + 
                unmet_needs_total +
                mios_ptsd_symptoms_total +
                military_family_total +
                years_separation + 
                years_service + 
                highest_rank +
                unmet_needs_total
    ) +
      set_rescor(FALSE),
    cores = 4)

model_mediation %>% print(digits = 3)

model_mediation %>% bayes_R2() %>% round(digits = 3)


# "Here we compute the indirect effect, ab."


draws <- as_draws_df(model_mediation)


draws <- draws %>% 
  mutate(ab = b_wisprivateregardtotal_mios_total * b_mcarmtotal_wis_private_regard_total)

# "Now we have ab as a properly computed vector, we can summarize it with the quantile() function."
quantile(draws$ab, probs = c(.5, .025, .975)) %>% 
  round(digits = 3)

# "And we can even visualize it as a density."

draws %>% 
  ggplot(aes(x = ab)) +
  geom_density(color = "transparent", 
               fill = colorblind_pal()(3)[3]) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = expression(paste("Our indirect effect, the ", italic("ab"), " pathway")),
       x = NULL) +
  theme_classic()

draws %>% 
  summarize(mean   = mean(ab),
            median = median(ab)) %>% 
  round(digits = 3)

bayes_R2(model_mediation, summary = F) %>% 
  data.frame() %>% 
  pivot_longer(everything()) %>% 
  
  ggplot(aes(x = value, fill = name)) +
  geom_density(color = "transparent", alpha = .85) +
  scale_fill_viridis_d(option = "A", begin = .33, direction = -1,
                       labels = c("affect", "withdaw"),
                       guide  = guide_legend(title.theme = element_blank())) +
  scale_x_continuous(NULL, limits = 0:1) +
  scale_y_continuous(NULL, breaks = NULL) +
  ggtitle(expression(The~italic(R)^2~distributions~"for"~model~4.2)) +
  theme(panel.grid = element_blank())


# Get c and c_prime -------------------------------------------------------

draws %>% 
  mutate(c       = b_mcarmtotal_mios_total + ab,
         c_prime = b_mcarmtotal_mios_total) %>% 
  pivot_longer(c(c_prime, c)) %>% 
  group_by(name) %>% 
  summarize(mean = mean(value), 
            ll   = quantile(value, probs = .025),
            ul   = quantile(value, probs = .975)) %>% 
  mutate_if(is_double, round, digits = 3)


# MULTIPLE MEDIATION ------------------------------------------------------

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
               unmet_needs_total +
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
                 unmet_needs_total +
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
                 unmet_needs_total +
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


# R-squared for each regression in the model
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

# indirect effects
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





# session info ------------------------------------------------------------


sessionInfo()
