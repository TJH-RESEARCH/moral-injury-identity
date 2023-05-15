
# I need to make some combined variables out of those that are currently split 
## e.g., employment, officer, race



# Active Duty -------------------------------------------------------------

data %>% 
  ggplot(aes(x = mios_total, group = active_duty)) +
  geom_boxplot() +
  theme_bw()

# Branch -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = branch)) +
  geom_boxplot() +
  theme_bw()


# Discharge Reason --------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = discharge_reason)) +
  geom_boxplot() +
  theme_bw()


# Employment --------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = employment)) +
  geom_boxplot() +
  theme_bw()


# Marital Status ---------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = marital)) +
  geom_boxplot() +
  theme_bw()


# Military Family ---------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = military_family_none)) +
  geom_boxplot() +
  theme_bw()


# Military Experience: Combat -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = military_exp_combat)) +
  geom_boxplot() +
  theme_bw()

# MIOS Screener -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = mios_screener)) +
  geom_boxplot() +
  theme_bw()

data %>% 
  ggplot(aes(x = wis_private_regard_total, group = mios_screener)) +
  geom_boxplot() +
  theme_bw()


# MIOS Event Type ---------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = mios_event_type)) +
  geom_boxplot() +
  theme_bw()


# Religious ---------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = religious)) +
  geom_boxplot() +
  theme_bw()


# Sex ---------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = sex)) +
  geom_boxplot() +
  theme_bw()

# Sexual Orientation ------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = sexual_orientation)) +
  geom_boxplot() +
  theme_bw()



