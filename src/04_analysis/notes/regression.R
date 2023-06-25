


# Hierarchical Regression -------------------------------------------------


lm1 <-
  data %>% 
    lm(
      formula = mcarm_total ~ mios_screener,
      data = .
    ) 

lm2 <-
  data %>% 
  lm(
    formula = mcarm_total ~ mios_screener + mios_total,
    data = .
  ) 

lm3 <-
  data %>% 
  lm(
    formula = mcarm_total ~ mios_screener + 
                            mios_total + 
                            wis_public_regard_total,
    data = .
  ) 

anova(lm1, lm2, lm3)

lm1 %>% summary()
lm2 %>% summary()
lm3 %>% summary()
