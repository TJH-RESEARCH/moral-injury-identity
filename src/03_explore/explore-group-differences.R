
# I need to make some combined variables out of those that are currently split 
## e.g., employment, officer, race



# Active Duty -------------------------------------------------------------



# Branch -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total, group = branch)) +
  geom_boxplot() +
  theme_bw()


# Discharge Reason --------------------------------------------------------


# Employment --------------------------------------------------------------




# Marital Status ---------------------------------------------------------------



# Military Family ---------------------------------------------------------
##military_family_none

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


# Religious ---------------------------------------------------------------




# Sex ---------------------------------------------------------------------


# Sexual Orientation ------------------------------------------------------




