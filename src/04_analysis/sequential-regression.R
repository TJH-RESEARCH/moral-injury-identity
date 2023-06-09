# Hierarchical Regression


# Calculate WIS Total -----------------------------------------------------
data <-
  data %>% 
  mutate(wis_total =
           wis_private_regard_total +
           wis_public_regard_total +
           wis_connection_total +
           wis_family_total +
           wis_interdependent_total +
           wis_centrality_total + 
           wis_skills_total)

data <-
  data %>% 
  mutate(military_family = (military_family_none - 1) * -1)


# Correlation 1 -------------------------------------------------------------

data %>% 
  select((starts_with('wis') & ends_with('total')) | mios_total) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)



# Test Regression Assumptions ---------------------------------------------

data %>% ggplot(aes(x = mios_total, y = wis_total)) + geom_point() + ggtitle('Check for Non-Normality') + labs(x = 'Moral Injury Symptoms', y = 'Military Identity: Total') + theme_classic()
data %>% ggplot(aes(x = mios_total, y = wis_centrality_total)) + geom_point() + ggtitle('Check for Non-Normality: Military Identity Centrality') + labs(x = 'Moral Injury Symptoms', y = 'Military Identity: Total') + theme_classic()
data %>% ggplot(aes(x = mios_total, y = wis_connection_total)) + geom_point() + ggtitle('Check for Non-Normality: Military Identity Centrality') + labs(x = 'Moral Injury Symptoms', y = 'Military Identity: Total') + theme_classic()
data %>% ggplot(aes(x = mios_total, y = wis_family_total)) + geom_point() + ggtitle('Check for Non-Normality: Military Identity Centrality') + labs(x = 'Moral Injury Symptoms', y = 'Military Identity: Total') + theme_classic()
data %>% ggplot(aes(x = mios_total, y = wis_interdependent_total)) + geom_point() + ggtitle('Check for Non-Normality: Military Identity Centrality') + labs(x = 'Moral Injury Symptoms', y = 'Military Identity: Total') + theme_classic()
data %>% ggplot(aes(x = mios_total, y = wis_private_regard_total)) + geom_point() + ggtitle('Check for Non-Normality: Military Identity Centrality') + labs(x = 'Moral Injury Symptoms', y = 'Military Identity: Total') + theme_classic()
data %>% ggplot(aes(x = mios_total, y = wis_public_regard_total)) + geom_point() + ggtitle('Check for Non-Normality: Public Regard for the Military') + labs(x = 'Moral Injury Symptoms', y = 'Military Identity: Total') + theme_classic()
data %>% ggplot(aes(x = mios_total, y = wis_skills_total)) + geom_point() + ggtitle('Check for Non-Normality: Military Skills') + labs(x = 'Moral Injury Symptoms', y = 'Military Identity: Total') + theme_classic()

## Descriptive Statistics 
data %>% 
  select(mios_total | starts_with('wis') & ends_with('total')) %>% 
  psych::describe()

## Plots Pairs
data %>% 
  select(mios_total | starts_with('wis') & ends_with('total')) %>% 
  GGally::ggpairs()

### Scatter Plots: No non-linearity detected
### Density Plots: Most of the distributions are approximately normal
### However:
### MIOS Total and Private Regard are the most suspicious
# Private regard is skewed left and truncated at 28
# MIOS is right skewed and truncated at 0 


## Q-Q Plot: MIOS Total is a truncated normal distribution bounded by zero:
data %>% 
  ggplot(aes(sample = mios_total)) +
  ggplot2::stat_qq() + ggplot2::stat_qq_line() +
  ylab("MIOS Total") + xlab("Z-Score") + # Labels
  ggtitle("Q-Q Plot: Moral Injury Symptoms Scale") + theme_bw() # Theme
  
data %>% ggplot(aes(x = mios_total)) + geom_density()
data %>% ggplot(aes(x = mios_total)) + geom_histogram()


# Second implementation: `nortest` package
nortest::lillie.test(data$mios_total)# We can reject the null hypo that the data are normally distributive

## Cramer-von Mises Test for Normality
nortest::cvm.test(data$mios_total)# We can reject the null hypo that the data are normally distributive

## Anderson-Darling Test
nortest::ad.test(x = data$mios_total) # We can reject the null hypo that the data are normally distributive


## Public Regard
data %>% 
  ggplot(aes(sample = wis_public_regard_total)) +
  ggplot2::stat_qq() + ggplot2::stat_qq_line() +
  ylab("WIS Public Regard") + xlab("Z-Score") + # Labels
  ggtitle("Q-Q Plot: Public Regard for the Military") + theme_bw() # Theme

data %>% ggplot(aes(x = wis_private_regard_total)) + geom_density()
data %>% ggplot(aes(x = wis_private_regard_total)) + geom_histogram()

# Second implementation: `nortest` package
nortest::lillie.test(data$wis_private_regard_total)# We can reject the null hypo that the data are normally distributive

## Cramer-von Mises Test for Normality
nortest::cvm.test(data$wis_private_regard_total) # We can reject the null hypo that the data are normally distributive

## Anderson-Darling Test
nortest::ad.test(x = data$wis_private_regard_total) # We can reject the null hypo that the data are normally distributive

# The diagnostic plots for the regression
# of public regard on MIOS look good.
# The Scale-Location is a little wonky
# but the others are good. 

### Homoscedascticity 

nortest::ad.test(x = rnorm(1000, 1, 1))


# Total ----------------------------------------------------------------
model_0_total <- 
  lm(wis_total ~ 
       1,
     data = data)

model_1_total <- 
  lm(wis_total ~ 
       mios_total,
     data = data)

glm_1_total <- glm(wis_total ~ mios_total, 
                   family = Gamma(link = "inverse"),
                   data)

model_2_total <-   
  lm(wis_total ~ 
        mios_total + 
        mios_ptsd_symptoms_total +
        bipf_total,
     data = data)


model_3_total <-   
  lm(wis_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       military_family + 
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       service_era_vietnam +
       service_era_post_911,
     data = data)

glm_3_total <- glm(wis_total ~ 
                     mios_total + 
                     mios_ptsd_symptoms_total +
                     bipf_total +
                     sex +
                     race_asian + race_native + race_black + race_latino + race_other +
                     military_family + 
                     as.numeric(highest_rank) +
                     years_separation +
                     years_service +
                     service_era_vietnam +
                     service_era_post_911,
                   family = Gamma(link = "inverse"),
                   data)


# Centrality ----------------------------------------------------------------
model_1_centrality <- 
  lm(wis_centrality_total ~ 
       mios_total,
     data = data)

model_2_centrality <-   
  lm(wis_centrality_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       as.numeric(highest_rank) +
       military_family + 
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       years_separation +
       years_service,
     data = data)


# Connection --------------------------------------------------------------
model_1_connection <- 
  lm(wis_connection_total ~ 
       mios_total,
     data = data)

model_2_connection <-   
  lm(wis_connection_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       as.numeric(highest_rank) +
       military_family + 
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       years_separation +
       years_service,
     data = data)


# Family ------------------------------------------------------------------
model_1_family <- 
  lm(wis_family_total ~ 
       mios_total,
     data = data)

model_2_family <-   
  lm(wis_family_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       as.numeric(highest_rank) +
       military_family + 
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       years_separation +
       years_service,
     data = data)


# Interdependent ----------------------------------------------------------
model_1_interdependent <- 
  lm(wis_interdependent_total ~ 
       mios_total,
     data = data)

model_2_interdependent <-   
  lm(wis_interdependent_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       as.numeric(highest_rank) +
       military_family + 
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       years_separation +
       years_service,
     data = data)


# Skills ------------------------------------------------------------------
model_1_skills <- 
  lm(wis_skills_total ~ 
       mios_total,
     data = data)

model_2_skills <-   
  lm(wis_skills_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total,
     data = data)

model_3_skills <-   
  lm(wis_skills_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       military_family + 
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service,
     data = data)

# Private Regard ----------------------------------------------------------------
model_1_private <- 
  lm(wis_private_regard_total ~ 
       mios_total,
     data = data)

model_2_private <-   
  lm(wis_private_regard_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       as.numeric(highest_rank) +
       military_family + 
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       years_separation +
       years_service,
     data = data)



# Public ------------------------------------------------------------------
model_1_public <- 
  lm(wis_public_regard_total ~ 
       mios_total,
     data = data)

model_2_public <-   
  lm(wis_public_regard_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       as.numeric(highest_rank) +
       military_family + 
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       years_separation +
       years_service,
     data = data)


# Results: Total  -----------------------------------------------------------------
x <- model_1_total %>% summary()
model_1_total %>% summary()
model_2_total %>% summary()
model_3_total %>% summary()
model_1_total %>% plot()
model_2_total %>% plot()
model_3_total %>% plot()

## Delta R-squared
round(summary(model_2_total)$adj.r.squared[[1]] - summary(model_1_total)$adj.r.squared[[1]], 3)
round(summary(model_3_total)$adj.r.squared[[1]] - summary(model_2_total)$adj.r.squared[[1]], 3)

## F-Statistic
round(summary(model_1_total)$fstatistic, 3)
round(summary(model_2_total)$fstatistic, 3)
round(summary(model_3_total)$fstatistic, 3)

# DO I want to include interaction between MIOS and PTSD?

model_1_total %>% broom::tidy() %>% 
  mutate(p.value = round(p.value, 3))

model_2_total %>% broom::tidy() %>% 
  mutate(p.value = round(p.value, 3))

model_3_total %>% broom::tidy() %>% 
  mutate(p.value = round(p.value, 3),
         std.error = round(std.error, 3),
         estimate = round(estimate, 3))



# Results: Centrality -----------------------------------------------------
model_1_centrality %>% summary()
model_2_centrality %>% summary()


# Results: Connection ----------------------------------------------------
model_1_connection %>% summary()
model_2_connection %>% summary()


# Results: Family ---------------------------------------------------------
model_1_family %>% summary()
model_2_family %>% summary()


# Results: Interdependent -------------------------------------------------
model_1_interdependent %>% summary()
model_2_interdependent %>% summary()


# Results: Private Regard -------------------------------------------------
model_1_private %>% summary()
model_2_private %>% summary()


# Results: Public Regard --------------------------------------------------
model_1_public %>% summary()
model_2_public %>% summary()
model_2_public %>% plot()


# Results: Skills -----------------------------------------------------------------
model_1_skills %>% summary()
model_2_skills %>% summary()


# Replication with Bayes -------------------------------------------------------------------
library(brms)
options(brms.backend = "cmdstanr")
library(cmdstanr)
cmdstanr::set_cmdstan_path('~/cmdstan/')
library(tidybayes)


f1 <- brms::bf(wis_centrality_total ~ 1 + mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family)
f2 <- brms::bf(wis_private_regard_total ~ 1 + mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family)
f3 <- brms::bf(wis_public_regard_total ~ 1 + mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family)
f4 <- brms::bf(wis_family_total ~ 1 + mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family)
f5 <- brms::bf(wis_interdependent_total ~ 1 + mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family)
f6 <- brms::bf(wis_connection_total ~ 1 + mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family)
f7 <- brms::bf(wis_skills_total ~ 1+ mios_total + mios_ptsd_symptoms_total + bipf_total + years_separation + years_service +  highest_rank + military_family)


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
  mutate(
         b1 = b_wiscentralitytotal_mios_total,
         b2 = b_wisconnectiontotal_mios_total,
         b3 = b_wisfamilytotal_mios_total,
         b4 = b_wisinterdependenttotal_mios_total,
         b5 = b_wisprivateregardtotal_mios_total,
         b6 = b_wispublicregardtotal_mios_total,
         b7 = b_wisskillstotal_mios_total,
         iy1 = b_wiscentralitytotal_Intercept,
         iy2 = b_wisconnectiontotal_Intercept,
         iy3 = b_wisfamilytotal_Intercept,
         iy4 = b_wisinterdependenttotal_Intercept,
         iy5 = b_wisprivateregardtotal_Intercept,
         iy6 = b_wispublicregardtotal_Intercept,
         iy7 = b_wisskillstotal_Intercept
  )


# parameter estimates on the paths
draws %>% 
  pivot_longer(b1:iy7) %>% 
  group_by(name) %>% 
  tidybayes::mean_qi(value) %>% 
  mutate_if(is_double, round, digits = 3) %>% print(n = 50)
