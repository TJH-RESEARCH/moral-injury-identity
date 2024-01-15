
model_1_ptsd <- 
  data %>% 
  filter(ptsd_positive_screen == 1) %>% 
  lm(m2cq_mean ~ 
       mios_total +
       #military_exp_combat +
       #officer +
       sex_male +
       race_white +
       years_separation +
       years_service, .
  )

model_ptsd_1_results <- model_1_ptsd %>% lm.beta::lm.beta() %>% summary()
model_ptsd_1_results



model_0_ptsd <- 
  data %>% 
  filter(ptsd_positive_screen == 0) %>% 
  lm(m2cq_mean ~ 
       mios_total +
       #military_exp_combat +
       #officer +
       sex_male +
       race_white +
       years_separation +
       years_service, .
  )

model_ptsd_0_results <- model_0_ptsd %>% lm.beta::lm.beta() %>% summary()
model_ptsd_0_results

