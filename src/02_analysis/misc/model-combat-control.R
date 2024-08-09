

data %>% 
  lm(wis_interdependent_total ~ mios_total + military_exp_combat, .) %>% summary()

data %>% 
  lm(wis_interdependent_total ~ mios_total * wis_public_regard_total + military_exp_combat, .) %>% summary()

data %>% 
  lm(biis_conflict ~ mios_total + military_exp_combat, .) %>% summary()


