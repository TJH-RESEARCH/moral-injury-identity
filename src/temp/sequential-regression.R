# Hierarchical Regression


# Calculate WIS Total -----------------------------------------------------
data <-
  data %>% 
  mutate(wis_total =
           wis_centrality_total + 
           wis_connection_total +
           wis_family_total +
           wis_interdependent_total +
           wis_private_regard_total +
           wis_public_regard_total +
           wis_skills_total)

data <-
  data %>% 
  mutate(military_family = (military_family_none - 1) * -1)

data <-
  data %>% 
  mutate(bipf_none = if_else(bipf_total == 0, 1, 0))


# Correlation 1 -------------------------------------------------------------

data %>% 
  select((starts_with('wis') & ends_with('total')) | mios_total) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)

data %>% 
  select((starts_with('wis') & ends_with('total')) | mios_total) %>% 
  psych::corr.test()

data %>% 
  select(
    wis_centrality_total,
    wis_connection_total,
    wis_family_total,
    wis_interdependent_total,
    wis_private_regard_total,
    wis_public_regard_total,
    wis_skills_total,
    wis_total,
    mios_total
  ) %>% 
  cor() %>% 
  broom::tidy() %>% 
  round(2) %>% 
  view()


# Correlation 2 -----------------------------------------------------------

data %>% 
  mutate(highest_rank = as.numeric(highest_rank),
         sex = as.numeric(sex)) %>% 
  select(wis_total, 
  mios_total, 
  mios_ptsd_symptoms_total,
  bipf_total,
  sex,
  branch_air_force, branch_army, branch_marines, branch_navy, branch_multiple, branch_public_health,
  race_asian, race_native, race_black, race_latino, race_white,
  service_era_vietnam, service_era_persian_gulf, service_era_post_911, 
  disability,
  n_deploy,
  reserve,
  highest_rank,
  years_separation,
  years_service,
  military_family) %>%
  cor() %>% 
  corrplot::corrplot(method="shade", type = 'lower', diag = F)

## Plot Pairs
data <- data %>% 
  mutate(highest_rank = as.numeric(highest_rank),
         sex = as.numeric(sex),
         bipf_total_sq = sqrt(bipf_total),
         bipf_total_2 = bipf_total^2,
         bipf_total_inv = exp(bipf_total),
         mios_total_sq = sqrt(mios_total),
         mios_total_log2 = log((mios_total + 1), base = 2),
         mios_total_reflect_log = log((max(mios_total) + 1) - mios_total)
         )
data %>% 
  select(wis_total, 
         mios_total, 
         mios_total_sq,
         mios_ptsd_symptoms_total,
         #bipf_total,
         #sex,
         #branch_air_force, branch_army, branch_marines, branch_navy, branch_multiple, branch_public_health,
         #race_asian, race_native, race_black, race_latino, race_white,
         #service_era_vietnam, service_era_persian_gulf, service_era_post_911, 
         #disability,
         #n_deploy,
         #reserve,
         #highest_rank,
         #years_separation,
         #years_service,
         #military_family
         ) %>%
GGally::ggpairs()



## suggests I should include 
## highest rank, service era, branch

## race should have no effect
## but not years of service is correlated with rank and separation
## separation is correlated with service era

# BIPF Total is basically a count? Or a binomial distribution?
## Result of 7 yes/no questions added together
## bipf total has the same distribution as n_deply
## bipf basically the number of issues, so it is a poisson


lm(
  wis_total ~ 
    #mios_screener +
    mios_total +
    mios_ptsd_symptoms_total +
    #mios_criterion_a +
    #mios_total * mios_ptsd_symptoms_total +
    #mios_total * mios_criterion_a +
    #exp(bipf_total) +
    #bipf_none +
    bipf_total +
    sex +
    race_asian + race_native + race_black + race_latino + race_white +
    branch_army + branch_air_force + branch_marines + branch_navy +
    highest_rank +
    years_separation +
    service_era_vietnam + service_era_persian_gulf + service_era_post_911,
  data
) %>% #summary()
  plot()
lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3)) %>% print(n = 100)

psych::describe(data$mios_total)
psych::describe(data$mios_total_sq)
psych::describe(data$mios_total_log2)
psych::describe(data$wis_total)
hist(data$mios_total_log2)
# Squaring the MIOS reduces the magnitude of the skew
# and kurtosis, but in the opposite direction. 
# other transformations don't work so well


# best to dichotomize BIPF

# Test Regression Assumptions ---------------------------------------------

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

model_2_total <-   
  lm(wis_total ~ 
        mios_total + 
        mios_ptsd_symptoms_total +
        bipf_total,
     data = data)
model_2_total %>% summary()
model_2_total %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))


model_3_total <-   
  lm(wis_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       military_family,
     data = data)


model_4_total <-   
  lm(wis_total ~
       mios_total +
       mios_ptsd_symptoms_total +
       bipf_total +
       branch_marines +
       highest_rank +
       service_era_vietnam + service_era_persian_gulf + service_era_post_911,
     data)
model_4_total %>% summary()
model_4_total %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))



model_5_total <-   
  lm(wis_total ~
       mios_total +
       mios_ptsd_symptoms_total +
       mios_total * mios_ptsd_symptoms_total +
       bipf_total +
       highest_rank +
       service_era_vietnam + service_era_persian_gulf + service_era_post_911,
     data)
model_5_total %>% summary()
model_5_total %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))


model_6_total <-   
  lm(wis_total ~
       mios_total +
       mios_ptsd_symptoms_total +
       mios_total * mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_white +
       branch_marines +
       as.numeric(highest_rank) +
       service_era_vietnam + service_era_persian_gulf + service_era_post_911,
     data)
model_6_total %>% summary()
model_6_total %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))


# Centrality ----------------------------------------------------------------
model_1_centrality <- 
  lm(wis_centrality_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +                    
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       military_family,
     data = data)

# Connection --------------------------------------------------------------
model_1_connection <- 
  lm(wis_connection_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       military_family,
     data = data)

# Family ------------------------------------------------------------------
model_1_family <- 
  lm(wis_family_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       military_family,
     data = data)

# Interdependent ----------------------------------------------------------
model_1_interdependent <- 
  lm(wis_interdependent_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       military_family,
     data = data)

# Skills ------------------------------------------------------------------
model_1_skills <- 
  lm(wis_skills_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       military_family,
     data = data)

# Private Regard ----------------------------------------------------------------
model_1_private <- 
  lm(wis_private_regard_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       military_family,
     data = data)

# Public ------------------------------------------------------------------
model_1_public <- 
  lm(wis_public_regard_total ~ 
       mios_total + 
       mios_ptsd_symptoms_total +
       bipf_total +
       sex +
       race_asian + race_native + race_black + race_latino + race_other +
       service_era_vietnam +
       service_era_post_911 +
       as.numeric(highest_rank) +
       years_separation +
       years_service +
       military_family,
     data = data)



# Results: Total  -----------------------------------------------------------------
model_0_total %>% summary()
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

round(summary(model_1_centrality)$fstatistic, 3)
round(summary(model_1_connection)$fstatistic, 3)
round(summary(model_1_family)$fstatistic, 3)
round(summary(model_1_interdependent)$fstatistic, 3)
round(summary(model_1_private)$fstatistic, 3)
round(summary(model_1_public)$fstatistic, 3)
round(summary(model_1_skills)$fstatistic, 3)

## Adjusted R-Squared
round(summary(model_1_centrality)$adj.r.squared, 3)
round(summary(model_1_connection)$adj.r.squared, 3)
round(summary(model_1_family)$adj.r.squared, 3)
round(summary(model_1_interdependent)$adj.r.squared, 3)
round(summary(model_1_private)$adj.r.squared, 3)
round(summary(model_1_public)$adj.r.squared, 3)
round(summary(model_1_skills)$adj.r.squared, 3)


# DO I want to include interaction between MIOS and PTSD?
model_1_total %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_2_total %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_3_total %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_1_total %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_2_total %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_3_total %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_4_total %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
# There is good theoretical reason to interact MI and PTSD
model_4_total %>% summary()
model_4_total %>% plot()
# Years of service and separation
model_5_total %>% summary()
model_5_total %>% plot()
model_6_total %>% summary()
model_6_total %>% plot()

# Results: Centrality -----------------------------------------------------
model_1_centrality %>% summary()
model_1_centrality %>% plot()
model_1_centrality %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_1_centrality %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))

# Results: Connection ----------------------------------------------------
model_1_connection %>% summary()
model_1_connection %>% plot()
model_1_connection %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_1_connection %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))

# Results: Family ---------------------------------------------------------
model_1_family %>% summary()
model_1_family %>% plot()
model_1_family %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_1_family %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))

# Results: Interdependent -------------------------------------------------
model_1_interdependent %>% summary()
model_1_interdependent %>% plot()
model_1_interdependent %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_1_interdependent %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))

# Results: Private Regard -------------------------------------------------
model_1_private %>% summary()
model_1_private %>% plot()
model_1_private %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_1_private %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))

# Results: Public Regard --------------------------------------------------
model_1_public %>% summary()
model_1_public %>% plot()
model_1_public %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_1_public %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))

# Results: Skills -----------------------------------------------------------------
model_1_skills %>% summary()
model_1_skills %>% plot()
model_1_skills %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
model_1_skills %>% lm.beta::lm.beta() %>% broom::tidy() %>% mutate(p.value = round(p.value, 3), std_estimate = round(std_estimate, 3), std.error = round(std.error, 3), estimate = round(estimate, 3))
