
# I need to make some combined variables out of those that are currently split 
## e.g., employment, officer, race



# Active Duty -------------------------------------------------------------

data %>% 
  ggplot(aes(x = mios_total, color = active_duty)) +
  geom_boxplot() +
  theme_bw()

# Branch -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = branch)) +
  geom_boxplot() +
  theme_bw()


# Discharge Reason --------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = as.factor(discharge_reason))) +
  geom_boxplot() +
  theme_bw()


# Employment --------------------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_total, color = employment)) +
  geom_boxplot() +
  theme_bw()


# Marital Status ---------------------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_total, color = marital)) +
  geom_boxplot() +
  theme_bw()


# Military Family ---------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = as.factor(military_family_none))) +
  geom_boxplot() +
  theme_bw()


# Military Experience: Combat -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = as.factor(military_exp_combat))) +
  geom_boxplot() +
  theme_bw()

# MIOS Screener -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = as.factor(mios_screener))) +
  geom_boxplot() +
  theme_bw()

data %>% 
  ggplot(aes(x = wis_private_regard_total, color = as.factor(mios_screener))) +
  geom_boxplot() +
  theme_bw()


# MIOS Event Type ---------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = mios_event_type)) +
  geom_boxplot() +
  theme_bw()


# Religious ---------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = as.factor(religious))) +
  geom_boxplot() +
  theme_bw()


# Sex ---------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = sex)) +
  geom_boxplot() +
  theme_bw()

# Sexual Orientation ------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, color = sexual_orientation)) +
  geom_boxplot() +
  theme_bw()



