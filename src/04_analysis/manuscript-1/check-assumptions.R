
# Assumptions are:
## 1. Linearity
## 2. Normality
## 3. Homoscedascticity




# 1. Linearity ---------------------------------------------------------------

data %>% 
  select(wis_total, 
         mios_total, 
         mios_ptsd_symptoms_total,
         bipf_total,
         sex,
         branch_air_force, branch_army, branch_marines, branch_navy,
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


## Plots Pairs
data %>% 
  select(mios_total | starts_with('wis') & ends_with('total')) %>% 
  GGally::ggpairs()



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
#### Check diagnostic plots

