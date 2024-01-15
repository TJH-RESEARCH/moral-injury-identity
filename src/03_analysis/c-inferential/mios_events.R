

# Model 4: Events -----------------------------------------------------------------
model_4 <-
  data %>% 
  mutate(branch == as.numeric(highest_rank)) %>% 
  lm(m2cq_mean ~ 
       mios_screener +
       ptsd_positive_screen +
       military_exp_combat +
       sex_male +
       race_white +
       branch_air_force + branch_marines + branch_navy +
       service_era_post_911 + 
       service_era_persian_gulf + 
       service_era_vietnam +
       service_era_korea + 
       highest_rank +
       years_separation +
       years_service +
       discharge_other + discharge_medical +
       unmet_needs_none, 
     .)






# Model 5: Events by Type -----------------------------------------------------------------
model_5 <-
  data %>% 
  mutate(branch == as.numeric(highest_rank)) %>% 
  lm(m2cq_mean ~ 
       mios_event_type_self +
       mios_event_type_other +
       mios_event_type_betrayal +
       ptsd_positive_screen +
       military_exp_combat +
       sex_male +
       race_white +
       branch_air_force + branch_marines + branch_navy +
       service_era_post_911 + 
       service_era_persian_gulf + 
       service_era_vietnam +
       service_era_korea + 
       highest_rank +
       years_separation +
       years_service +
       discharge_other + discharge_medical +
       unmet_needs_none, 
     .)




# Results -----------------------------------------------------------------
model_4_results <- model_4 %>% lm.beta::lm.beta() %>% summary()
model_5_results <- model_5 %>% lm.beta::lm.beta() %>% summary()

model_4_results %>% print()
model_5_results %>% print()


