

# Self --------------------------------------------------------------------
model_self_bi <- lm(wis_interdependent_total ~ 1 + mios_event_type_self, data) 
model_self_multi <- lm(wis_interdependent_total ~ 1 + mios_event_type_self + pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data_moral_injury) 

# Other Person ------------------------------------------------------------
model_other_bi <- lm(wis_interdependent_total ~ 1 + mios_event_type_other, data) 
model_other_multi <- lm(wis_interdependent_total ~ 1 + mios_event_type_other + pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data_moral_injury) 

# Betrayal ----------------------------------------------------------------
model_betrayal_bi <- lm(wis_interdependent_total ~ 1 + mios_event_type_betrayal, data) 
model_betrayal_multi <- lm(wis_interdependent_total ~ 1 + mios_event_type_betrayal + pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data_moral_injury)

# Multiple Types of Moral Injury -----------------------------------
model_multiple_bi <- lm(wis_interdependent_total ~ 1 + mios_event_type_multiple, data) 
model_multiple_multi <- lm(wis_interdependent_total ~ 1 + mios_event_type_multiple + pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data_moral_injury) 



# Various --------------------------------------------------------------------
model_types <- 
  lm(wis_interdependent_total ~ 1 + 
        mios_event_type_self +
        mios_event_type_other +
        mios_event_type_betrayal,
      data) 
model_types %>% summary()
model_types %>% aov() %>% summary()


model_types_multi <- 
  lm(wis_interdependent_total ~ 1 + 
        mios_event_type_self +
        mios_event_type_other +
        mios_event_type_betrayal +
        pc_ptsd_positive_screen + 
        race_white + race_black + 
        sex_male + 
        service_era_post_911 + service_era_vietnam + service_era_persian_gulf + 
        n_deploy + 
        years_service + 
        branch_air_force + branch_marines + branch_navy,
      data) 
model_types_multi %>% summary()
model_types_multi %>% aov() %>% summary()






# -------------------------------------------------------------------------



# Self --------------------------------------------------------------------
model_self_bi <- lm(wis_interdependent_total ~ 1 + mios_total * mios_event_type_self, data) 
model_self_bi %>% summary()

model_self_bi_mi <- lm(wis_interdependent_total ~ 1 + mios_total * mios_event_type_self, data_moral_injury) 
model_self_bi_mi %>% summary()

model_self_multi <- lm(wis_interdependent_total ~ 1 + mios_total * mios_event_type_self + 
                         pc_ptsd_positive_screen + race_white + race_black + sex_male + 
                         service_era_post_911 + service_era_vietnam + service_era_persian_gulf + 
                         n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data) 
model_self_multi_mi <- lm(wis_interdependent_total ~ 1 + mios_total * mios_event_type_self + 
                            pc_ptsd_positive_screen + race_white + race_black + sex_male + 
                            service_era_post_911 + service_era_vietnam + service_era_persian_gulf + 
                            n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data_moral_injury) 
model_self_multi %>% summary()
model_self_multi_mi %>% summary()


# Other --------------------------------------------------------------------
model_other_bi <- lm(wis_interdependent_total ~ 1 + mios_total * mios_event_type_other, data) 
model_other_multi <- lm(wis_interdependent_total ~ 1 + mios_total * mios_event_type_other + 
                          pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data) 

model_other_bi %>% summary()
model_other_multi %>% summary()


# Betrayal --------------------------------------------------------------------
model_betrayal_bi <- lm(wis_interdependent_total ~ 1 + mios_total * mios_event_type_betrayal, data) 
model_betrayal_multi <- lm(wis_interdependent_total ~ 1 + mios_total * mios_event_type_betrayal + 
                             pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data) 

model_betrayal_bi %>% summary()
model_betrayal_multi %>% summary()










model_interaction_multi <- lm(wis_interdependent_total ~ 1 + 
                                mios_event_type_self +
                                mios_event_type_other +
                                mios_event_type_betrayal +
                                pc_ptsd_positive_screen + race_white + race_black + sex_male + service_era_post_911 + service_era_vietnam + service_era_persian_gulf + n_deploy + years_service + branch_air_force + branch_marines + branch_navy, data) 
model_interaction_multi %>% summary()





