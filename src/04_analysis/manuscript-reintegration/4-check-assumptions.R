
# Assumptions are:
## 1. Linearity
## 2. Normality
## 3. Homoscedascticity


# Paired scatter plots, density plots, box plots -----------------------------
data %>%
  select(civilian_commit_total,
         wis_total,
         mios_total,
         biis_blendedness,
         biis_harmony,
         mcarm_total) %>%
  GGally::ggpairs()



# Regression 1 ------------------------------------------------------------
data %>%
  select(mcarm_total,
         mios_total, 
         mios_ptsd_symptoms,
         service_era_persian_gulf,
         service_era_post_911,
         service_era_vietnam,
         sex_male,
         disability) %>%
  GGally::ggpairs()


# Regression 2 ------------------------------------------------------------
data %>%
  mutate(mios_ptsd_symptoms = factor(mios_ptsd_symptoms),
         service_era_persian_gulf = factor(service_era_persian_gulf),
         service_era_post_911 = factor(service_era_post_911),
         service_era_vietnam = factor(service_era_vietnam),
         sex_male = factor(sex_male),
         branch_air_force = factor(branch_air_force),
         branch_marines = factor(branch_marines),
         branch_navy = factor(branch_navy),
         race_white = factor(race_white),
         military_family = factor(military_family),
         rank_e1_e3 = factor(rank_e1_e3),
         rank_e7_e9 = factor(rank_e7_e9),
         nonenlisted = factor(nonenlisted)
         ) %>% 
  select(wis_total,
         mios_total,
         mios_ptsd_symptoms,
         service_era_persian_gulf,
         service_era_post_911,
         service_era_vietnam,
         sex_male,
         branch_air_force,
         branch_marines,
         branch_navy,
         race_white,
         military_family,
         years_service,
         years_separation,
         rank_e1_e3,
         rank_e7_e9,
         nonenlisted) %>%
  GGally::ggpairs()

