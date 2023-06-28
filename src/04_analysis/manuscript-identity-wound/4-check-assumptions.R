
# Assumptions are:
## 1. Linearity
## 2. Normality
## 3. Homoscedascticity




# 1. Linearity ---------------------------------------------------------------

## Gender
data %>%
  mutate(race_white = factor(race_white),
         military_family = factor(military_family)) %>% 
  select(wis_total, 
         mios_total, 
         mios_ptsd_symptoms_total,
         sex,
         race_white,
         military_family) %>%
  GGally::ggpairs()

### Similar distributions for WIS, MIOS across gender
### PTSD is the most dissimilar across genders, although not so extreme

## Branch 
data %>%
  mutate(branch_air_force = factor(branch_air_force), 
         branch_army = factor(branch_army), 
         branch_marines = factor(branch_marines), 
         branch_navy = factor(branch_navy)) %>% 
  select(wis_total, 
         mios_total, 
         mios_ptsd_symptoms_total,
         branch_air_force, branch_army, branch_marines, branch_navy) %>%
  GGally::ggpairs()

### Similar distributions for WIS and MIOS across branch. 
### Also for PTSD, with Navy having the most difference.

# Service Era
data %>% 
  mutate(service_era_vietnam = factor(service_era_vietnam), 
         service_era_cold_war = factor(service_era_cold_war), 
         service_era_persian_gulf = factor(service_era_persian_gulf), 
         service_era_post_911 = factor(service_era_post_911)) %>% 
  select(wis_total, 
         mios_total, 
         mios_ptsd_symptoms_total,
         service_era_vietnam, service_era_cold_war, 
         service_era_persian_gulf, service_era_post_911) %>% 
  GGally::ggpairs()
### WIS is similar across service era
### MIOS has different levels, but a similarly shaped distribution
### PTSD is again the most difference between the groups, 
### although it is not too extreme.
### The Vietnam-non-Vietnam groups is the most balanced in terms of size
### The others are okay in terms of group balance
### 


## Rank, Years of Service, Years of Separation
data %>% 
  mutate(rank_e1_e3 = factor(rank_e1_e3), 
         rank_e4_e6 = factor(rank_e4_e6), 
         rank_e7_e9 = factor(rank_e7_e9), 
         nonenlisted = factor(nonenlisted)) %>% 
  select(wis_total, 
         mios_total, 
         mios_ptsd_symptoms_total,
         rank_e1_e3, rank_e4_e6, rank_e7_e9, nonenlisted,
         years_service, years_separation) %>% 
  GGally::ggpairs()

### Similar distribitions for WIS Total and MIOS Total 
### across sex, race, and coming from a military family.
### The most different is PTSD symptoms by sex and race, 
### although it is not extreme. There are more outliers
### for PTSD symptoms among males and White veterans.


## Moral Injury
data %>% 
  ggplot(aes(sqrt(mios_total))) +
  geom_histogram(bins = 20)


## Military Identity
data %>% 
  select(mios_ptsd_symptoms_total | mios_total | starts_with('wis') & ends_with('total')) %>% 
  GGally::ggpairs()

data %>% 
  mutate(wis_private_regard_total = wis_private_regard_total^3) %>% 
  ggplot(aes(wis_private_regard_total)) +
  geom_histogram()

data %>% 
  mutate(wis_public_regard_total = 
    wis_public_regard_total - median(wis_public_regard_total) ) %>% 
  ggplot(aes(wis_public_regard_total^1/3)) +
  geom_histogram(color = 'green') #+
  geom_density(aes(wis_public_regard_total ^2), color = 'red') +
  geom_density(aes(wis_public_regard_total ^1/2), color = 'orange') +
  geom_density(aes(wis_public_regard_total ^1/4), color = 'blue')

## get median
data %>% 
    select(wis_public_regard_total) %>%
    tibble::deframe() %>% median() 
  
## transform
    data %>% 
      #mutate(wis_private_regard_total_inverse = 1 / max(data$wis_private_regard_total + 1) - wis_private_regard_total) %>% 
      mutate(wis_private_regard_total_log = log10(1 / max(data$wis_private_regard_total + 1) - data$wis_private_regard_total) ) %>% 
    ggplot(aes(wis_private_regard_total_inverse)) +
    geom_histogram()
  

### Similar distributions for WIS Total, MIOS Total, and PTSD across branch

#### Across all plots:
# PTSD symptoms are approximated by a Poisson distribution
# WIS Total is skewed
# MIOS Total 



# What to do about PTSD symptoms? -----------------------------------------

data %>% 
  count(mios_ptsd_symptoms_total) %>% 
  mutate(perc = n / nrow(data) * 100)

### Probably best to dichotomize this. 

# -------------------------------------------------------------------------




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

