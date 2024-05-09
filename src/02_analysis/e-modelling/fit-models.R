# Model 1 -----------------------------------------------------------------
model_biis_1               <- lm(biis_conflict ~ mios_total, data)
model_biis_interact_1      <- lm(biis_conflict ~ mios_total * wis_public_regard_total, data)
model_wis_private_regard_1 <- lm(wis_private_regard_total ~ mios_total, data)
model_wis_interdependent_1 <- lm(wis_interdependent_total ~ mios_total, data)


# Model 2 -----------------------------------------------------------------
model_biis_2  <-
  lm(biis_conflict ~ 
       mios_total + 
       pc_ptsd_positive_screen +
       race_white + 
       race_black + 
       sex_male +
       service_era_post_911 + 
       service_era_vietnam + 
       service_era_persian_gulf +
       years_service + 
       n_deploy +
       branch_air_force +
       branch_marines +
       branch_navy,
     data)

model_wis_private_regard_2     <- lm(wis_private_regard_total     ~ mios_total + pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data)
model_wis_interdependent_2 <- lm(wis_interdependent_total ~ mios_total + pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data)
model_biis_interact_2      <- lm(biis_conflict ~ mios_total + pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + years_service + n_deploy + branch_air_force + branch_marines + branch_navy + wis_public_regard_total + mios_total * wis_public_regard_total, data)

