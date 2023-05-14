


# Helper Functions --------------------------------------------------------

histogram <- geom_histogram(aes(y = ..density..),# Set Y to density. 
                            fill = '#0c2a50ff',               # Color fill of bars.
                            color = "#efe350ff",              # Color of bar outline.
                            bins = 15)


normal_curve <- function(x){
  stat_function(                                # Draw normal line...
    fun = dnorm,                                # with dnorm.
    color = "#f68f46ff",                        # Line color.
    size = 1.5,                                 # Line thickness.
    args = with(data,                           # For the normal line...
                c(mean = mean(x),      # Set mean and...
                  sd = sd(x)))         # standard deviation.
  )
}

poisson_curve <- function(x){
  stat_function(                                # Draw normal line...
    fun = dpois,                                # with dnorm.
    color = "#f68f46ff",                        # Line color.
    size = 1.5,                                 # Line thickness.
    args = with(data,                           # For the normal line...
                c(lambda = var(x)))             # Set lambda
  )
}


# BIIS Total: Histogram ---------------------------------------------------

data %>% 
  ggplot(aes(x = biis_total)) +
  histogram +
  normal_curve(data$biis_total)


# BIIS Total: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = biis_total)) +
  geom_boxplot()


# BIIS Harmony: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = biis_harmony)) +
  histogram +
  normal_curve(data$biis_harmony)

# BIIS Harmony: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = biis_harmony)) +
  geom_boxplot() +
  theme_bw()


# BIIS Blendedness: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = biis_blendedness)) +
  histogram +
  normal_curve(data$biis_blendedness)

# BIIS Blendedness: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = biis_blendedness)) +
  geom_boxplot() +
  theme_bw()


# bIPF: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = bipf_total)) +
  histogram +
  normal_curve(data$bipf_total)

# bIPF: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = bipf_total)) +
  geom_boxplot() +
  theme_bw()


# Civilian Identity Commitment: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = civilian_commit_total)) +
  histogram +
  normal_curve(data$civilian_commit_total)

# Civilian Identity Commitment: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = civilian_commit_total)) +
  geom_boxplot() +
  theme_bw()


# DIFI Distance: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = difi_distance)) +
  histogram +
  normal_curve(data$difi_distance)

# DIFI Distance: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = difi_distance)) +
  geom_boxplot() +
  theme_bw()


# DIFI Overlap: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = difi_overlap)) +
  histogram +
  normal_curve(data$difi_overlap)

# DIFI Overlap: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = difi_overlap)) +
  geom_boxplot() +
  theme_bw()


# M2C-Q Mean: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = m2cq_mean)) +
  histogram +
  normal_curve(data$m2cq_mean)

# M2C-Q Total: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = m2cq_mean)) +
  geom_boxplot() +
  theme_bw()


# M-CARM Total: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_total)) +
  histogram +
  normal_curve(data$mcarm_total)

# M-CARM Total: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_total)) +
  geom_boxplot() +
  theme_bw()


# M-CARM Beliefs About Civilians: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_beliefs_about_civilians)) +
  histogram +
  normal_curve(data$mcarm_beliefs_about_civilians)

# M-CARM Beliefs About Civilians: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_beliefs_about_civilians)) +
  geom_boxplot() +
  theme_bw()


# M-CARM Help Seeking: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_help_seeking)) +
  histogram + 
  normal_curve(data$mcarm_help_seeking)

# M-CARM Help Seeking: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_help_seeking)) +
  geom_boxplot() +
  theme_bw()


# M-CARM Purpose & Connection: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_purpose_connection)) +
  histogram +
  normal_curve(data$mcarm_purpose_connection)

# M-CARM Purpose & Connection: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_purpose_connection)) +
  geom_boxplot() +
  theme_bw()


# M-CARM Resentment and Regret: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_resentment_regret)) +
  histogram +
  normal_curve(data$mcarm_resentment_regret)

# M-CARM Resentment and Regret: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_resentment_regret)) +
  geom_boxplot() +
  theme_bw()


# M-CARM Regimentation: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_regimentation)) +
  histogram +
  normal_curve(data$mcarm_regimentation)

# M-CARM Regimentation: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mcarm_regimentation)) +
  geom_boxplot() +
  theme_bw()


# MIOS Total: Histogram ------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total)) +
  histogram +
  normal_curve(data$mios_total)

# MIOS Total: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_total)) +
  geom_boxplot() +
  theme_bw()


# MIOS Trust: Histogram  --------------------------------------------------
data %>% 
  ggplot(aes(x = mios_trust)) +
  histogram +
  normal_curve(data$mios_trust)


# MIOS Trust: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = mios_trust)) +
  geom_boxplot() +
  theme_bw()


# MIOS Shame: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = mios_shame)) +
  histogram +
  normal_curve(data$mios_shame)

# MIOS Shame: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = scc_total)) +
  geom_boxplot() +
  theme_bw()


# SCC Total: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = scc_total)) +
  histogram +
  normal_curve(data$scc_total)

# SCC Total: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = scc_total)) +
  geom_boxplot() +
  theme_bw()



# Unmet Needs Total: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = unmet_needs_total)) +
  histogram +
  normal_curve(data$unmet_needs_total)

# Unmet Needs Total: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = unmet_needs_total)) +
  geom_boxplot() +
  theme_bw()


# WIS Centrality: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = wis_centrality_total)) +
  histogram +
  normal_curve(data$wis_centrality_total)

# WIS Centrality: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = wis_centrality_total)) +
  geom_boxplot() +
  theme_bw()


# WIS Connection: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = wis_connection_total)) +
  histogram +
  normal_curve(data$wis_connection_total)

# WIS Commitment: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = wis_connection_total)) +
  geom_boxplot() +
  theme_bw()


# WIS Family: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = wis_family_total)) +
  histogram +
  normal_curve(data$wis_family_total)

# WIS Family: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = wis_family_total)) +
  geom_boxplot() +
  theme_bw()


# WIS Interdependent: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = wis_interdependent_total)) +
  histogram +
  normal_curve(data$wis_interdependent_total)

# WIS Interdependent: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = wis_interdependent_total)) +
  geom_boxplot() +
  theme_bw()


# WIS Private Regard: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = wis_private_regard_total)) +
  histogram +
  normal_curve(data$wis_private_regard_total)

# WIS Private Regard: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = wis_private_regard_total)) +
  geom_boxplot() +
  theme_bw()


# WIS Public Regard: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = wis_public_regard_total)) +
  histogram +
  normal_curve(data$wis_public_regard_total)

# WIS Public Regard: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = wis_public_regard_total)) +
  geom_boxplot() +
  theme_bw()


# WIS Skills: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = wis_skills_total)) +
  histogram +
  normal_curve(data$wis_skills_total)

# WIS Skills: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = wis_skills_total)) +
  geom_boxplot() +
  theme_bw()


# Years of Age: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = as.numeric(years_of_age))) +
  histogram

# Years of Age: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = as.numeric(years_of_age))) +
  geom_boxplot() +
  theme_bw()


# Years of Separation: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = as.numeric(years_separation))) +
  histogram

# Years of Separation: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = as.numeric(years_separation))) +
  geom_boxplot() +
  theme_bw()


# Years of Service: Histogram ---------------------------------------------------
data %>% 
  ggplot(aes(x = as.numeric(years_service))) +
  histogram

# Years of Service: Box Plot -------------------------------------------------------------------------
data %>% 
  ggplot(aes(x = as.numeric(years_service))) +
  geom_boxplot() +
  theme_bw()



