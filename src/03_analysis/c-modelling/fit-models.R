


#0. Null
#1. Bivariate
#2a. Adjust for Combat and PTSD
#3b1. Critical Incidents as the explanatory instead of Moral Injury symptoms. Control for combat. 
#3b2. Critical Incidents as instrumental variable for Moral Injury symptoms. Control for combat. 
#3c1. Military Family + Combat + PSTD

#4b1. Combat + ID1u/Military Family + Officer + PTSD + Race + Sex + Yrs_Service

#That's 10 models, not counting the null. And if the analysis is done for Dissonance and Loss, 
# then that's 20 models. 3 have alternative adjustment sets (2, 3c, 4b), 
# so I can choose one or the other (probable PTSD and Combat instead of critical incidents). 
# That leaves 7/14 models. Better. 4b1 is basically the same as 4a but with an extra variable, I will drop 4a.





# Military Identity --------------------------------------------------------------
model_wis_0 <- data %>% lm(wis_interdependent_total ~ 1, .)

model_wis_1_bivariate   <- data %>% lm(wis_interdependent_total ~ mios_total, .)

model_wis_2_adjust   <- data %>% 
  lm(wis_interdependent_total ~ 
       mios_total + military_exp_combat + pc_ptsd_positive_screen, .)

model_wis_3b1_crit   <- data %>% 
  lm(wis_interdependent_total ~ 
       mios_screener + military_exp_combat + pc_ptsd_positive_screen, .)

model_wis_3b2_instrument <-
  ivreg::ivreg(wis_interdependent_total ~ 
                 mios_total + military_exp_combat | mios_screener + military_exp_combat, 
               data = data)

model_wis_3c1_proxy   <- data %>% 
  lm(wis_interdependent_total ~ 
       mios_total + military_exp_combat + pc_ptsd_positive_screen + military_family_parents, .)

model_wis_4b1_controls   <- data %>% 
  lm(wis_interdependent_total ~ 
       mios_total +
       military_exp_combat + 
       pc_ptsd_positive_screen + 
       military_family_parents +
       officer + 
       race_white + 
       race_black + 
       sex_male + 
       years_service
     , .)


# Identity Dissonance -----------------------------------------------------
model_biis_0 <- data %>% lm(biis_conflict ~ 1, .)

model_biis_1_bivariate   <- data %>% lm(biis_conflict ~ mios_total, .)

model_biis_2_adjust   <- data %>% 
  lm(biis_conflict ~ 
       mios_total + military_exp_combat + pc_ptsd_positive_screen, .)

model_biis_3b1_crit   <- data %>% 
  lm(biis_conflict ~ 
       mios_screener + military_exp_combat + pc_ptsd_positive_screen, .)

model_biis_3b2_instrument <-
  ivreg::ivreg(biis_conflict ~ 
                 mios_total + military_exp_combat | mios_screener + military_exp_combat, 
               data = data)

model_biis_3c1_proxy   <- data %>% 
  lm(biis_conflict ~ 
       mios_total + military_exp_combat + pc_ptsd_positive_screen + military_family_parents, .)

model_biis_4b1_controls   <- data %>% 
  lm(biis_conflict ~ 
       mios_total +
       military_exp_combat + 
       pc_ptsd_positive_screen + 
       military_family_parents +
       officer + 
       race_white + 
       race_black + 
       sex_male + 
       years_service
     , .)


