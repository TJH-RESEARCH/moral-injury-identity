
# Testing the Social Identity Model of Identity Change

### private regard works
data %>% lm(mios_total ~ mios_screener + wis_private_regard_total, .) %>% summary()
data %>% lm(wis_private_regard_total ~ mios_screener + mios_criterion_a, .) %>% summary()


### WIS connection and family are somewhat retrospective...
### they may work as retrospective measures of identity antecdents

### but WIS interdependence is completely present day and really capture the 
### 'I'm stuck in my military identity' mentality
data %>% lm(mios_total ~ mios_screener + wis_interdependent_total, .) %>% summary()
data %>% lm(wis_interdependent_total ~ mios_screener + mios_criterion_a, .) %>% summary()


## Skills is kind of besides the point

### centrality is a little more ambiguous but I think its present 
### (not as retrospective as family and connection) and being more central seems
### kind of positive whereas more interdependence seems a bit negative


# Private Regard ----------------------------------------------------------
model_pr <- 
  data %>% 
  lm(wis_private_regard_total ~ 
      mios_screener + 
      mios_criterion_a + 
      military_exp_combat + 
      race_black + race_white + 
      branch_air_force + branch_marines + branch_navy +
      sex_male + 
      service_era_init +
      mos_classification, 
    data = .)


model_mios_pr <-
  data %>% 
  lm(mios_total ~
       wis_private_regard_total + 
       mios_screener + 
       mios_criterion_a + 
       military_exp_combat + 
       race_black + race_white + 
       branch_air_force + branch_marines + branch_navy +
       sex_male + 
       service_era_init +
       mos_classification, 
     data = .)

# Interdeoendence ----------------------------------------------
model_int <-
  data %>% 
  lm(wis_interdependent_total ~ 
       mios_screener + 
       mios_criterion_a + 
       military_exp_combat + 
       race_black + race_white + 
       branch_air_force + branch_marines + branch_navy +
       sex_male + 
       service_era_init +
       mos_classification, 
     data = .)

model_mios_int <-
  data %>% 
  lm(mios_total ~
       wis_interdependent_total + 
       mios_screener + 
       mios_criterion_a + 
       military_exp_combat + 
       race_black + race_white + 
       branch_air_force + branch_marines + branch_navy +
       sex_male + 
       service_era_init +
       mos_classification, 
     data = .)



model_pr %>% summary()
model_mios_pr %>% summary()
model_int %>% summary()
model_mios_int %>% summary()
