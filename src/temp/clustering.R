


# Moral Injury Clusters ---------------------------------------------------

# Select only the MI event and related variables

data_cluster_mios <-
  data %>% 
  dplyr::select(
    
    # PTSD
    mios_criterion_a,
    mios_ptsd_symptoms_total,
    
    # MIOS
    mios_screener,
    mios_shame,
    mios_trust,
    
    # Psychosocial Functioning
    bipf_total
  )
glimpse(data_cluster_mios)
# k-means clustering

library("factoextra")
results_kmeans <- factoextra::eclust(data_cluster_mios, 
                                     "kmeans", 
                                     nstart = 25)

# Gap statistic plot
fviz_gap_stat(results_kmeans$gap_stat)

# Add the MIOS Cluster to the Data
data <- 
  data %>% mutate(mios_cluster = results_kmeans$cluster)


data_cluster_mios %>% 
  mutate(mios_cluster = results_kmeans$cluster) %>%
  ggplot(aes(
    x = mios_trust + mios_shame,
    y = mios_ptsd_symptoms_total,
    color = as.factor(mios_screener),
    size = bipf_total,
    shape = as.factor(mios_criterion_a) 
  )) + 
  geom_point(position = 'jitter', alpha = .7) +
  facet_grid(vars(mios_cluster))
  


# Compare the Groups ------------------------------------------------------
  data %>% 
    mutate(mios_cluster = results_kmeans$cluster) %>%
    group_by(mios_cluster) %>% 
    summarise(count = n(), 
      mean_mios_shame = mean(mios_shame),
              sd_mios_shame = sd(mios_shame),
              mean_mios_trust = mean(mios_trust),
              sd_mios_trust = sd(mios_trust),
              mean_mios_total = mean(mios_total),
              sd_mios_total = sd(mios_total),
              mean_bipf = mean(bipf_total),
              sd_bipf = sd(bipf_total),
              mean_ptsd_symptoms = mean(mios_ptsd_symptoms_total),
              sd_ptsd_symptoms = sd(mios_ptsd_symptoms_total),
              perc_self = sum(mios_event_type_self) / n() * 100,
              perc_other = sum(mios_event_type_other) / n() * 100,
              perc_betrayal = sum(mios_event_type_betrayal) / n() * 100,
              perc_criterion_a = sum(mios_criterion_a) / n() * 100
              ) %>% round(2) %>% 
  mutate(mios_cluster = case_when(mios_cluster == 1 ~ 'Medium',
                                  mios_cluster == 2 ~ 'High',
                                  mios_cluster == 3 ~ 'Low',
                                  )) %>% 
  arrange(desc(mean_mios_total)) %>% glimpse()


rm(data_cluster_mios)

# Military Identity Clusters -------------------------------------------------------

data_cluster_wis <-
  data %>% 
    select(
      starts_with('wis_') & ends_with('total') 
    )

results_kmeans <- factoextra::eclust(data_cluster_wis, 
                                     "kmeans", 
                                     nstart = 25)

# Gap statistic plot
fviz_gap_stat(results_kmeans$gap_stat)

## Welp.... I guess that's why they are all different variables.
## Try it with just the regard:

data %>% 
  ggplot(aes(wis_private_regard_total,
           wis_public_regard_total))+
  geom_point()

data_cluster_wis_regard <-
  data %>% 
  select(
    wis_private_regard_total,
    wis_public_regard_total
  )

results_kmeans <- factoextra::eclust(data_cluster_wis_regard, 
                                     "kmeans", 
                                     nstart = 25)

# Gap statistic plot
fviz_gap_stat(results_kmeans$gap_stat)




# Military-Civilian-US ----------------------------------------------------

data_cluster_wis_regard <-
  data %>% 
  select(
    wis_private_regard_total,
    wis_public_regard_total,
    civilian_commit_total,
    difi_distance, 
    sex, 
    race
  ) %>% mutate(sex = as.numeric(sex), race = as.numeric(race))

data_cluster_wis_regard %>% glimpse()

data_cluster_wis_regard %>% 
  ggplot(aes(civilian_commit_total, 
             wis_public_regard_total, 
             color = difi_distance,
             shape = as.factor(sex))) +
  geom_point()

results_kmeans <- factoextra::eclust(data_cluster_wis_regard, 
                                     "kmeans", 
                                     nstart = 25)

# Gap statistic plot
fviz_gap_stat(results_kmeans$gap_stat)
