

# Select WIS Data ---------------------------------------------------------
data_cluster_wis <- 
  data %>% 
    select(starts_with('wis') & ends_with('total') & !wis_total) %>% 

  # Normalize each variable. Some have more items than others,
  # thus different scales,
  # and the number is somewhat arbitrary anyways.:
      mutate(across(everything(), ~scale(.x)))



# Decide on number, model for clustering ----------------------------------

# Internal Validity Test ----------------------------------------------------------------
results_cluster_valid_wis_internal <- clValid::clValid(as.matrix(data_cluster_wis), 
                nClust = 2:10, 
                clMethods= c("hierarchical",
                              "kmeans",
                              "diana",
                              "fanny",
                              "pam",
                              "sota",
                              "som",
                              "clara"),
                validation = "internal")

results_cluster_valid_wis_internal %>% summary()

## Suggests two clusters using hierarchical clustering


# Stability Validity Test ---------------------------------------------------------------
results_cluster_valid_wis_stability <- clValid::clValid(as.matrix(data_cluster_wis), 
                nClust =  2:10, 
                clMethods = c("hierarchical",
                              "kmeans",
                              "diana",
                              "fanny",
                              "pam",
                              "sota",
                              "som",
                              "clara"),
                validation = "stability")

results_cluster_valid_wis_stability %>% summary()




# Hierarchical Clustering: 2 Groups -----------------------------------------

clusters <- hclust(dist(data_cluster_wis, method = "euclidean"))
plot(clusters)

clusterCut2 <- cutree(clusters, 2)



# Save the WIS Cluster ----------------------------------------------------

data <-
  data %>% 
  mutate(wis_cluster = clusterCut2,
         wis_cluster = factor(wis_cluster,
                                levels = c(1,2),
                                labels =  c('High Military Identity', 'Low Military Identity'),
                                ordered = F
                                  ),
        wis_cluster_lower = ifelse(wis_cluster == 'lower', 1, 0),
        wis_cluster_higher = ifelse(wis_cluster == 'higher', 1, 0))
         
data %>% count(wis_cluster)



# Plot differences in Clusters: Bar --------------------------------------------------------------------
figure_wis_cluster_scaled_means  <-
  data %>% 
  select(starts_with('wis') & ends_with('total') & !wis_total | wis_cluster) %>% 
  mutate(across(!wis_cluster, ~ scale(.x))) %>%
  group_by(wis_cluster) %>% 
  rename(Skills = wis_skills_total, 
         `Public Regard` = wis_public_regard_total, 
         `Private Regard` = wis_private_regard_total, 
         Interdependence =  wis_interdependent_total,
         Family = wis_family_total,
         Connection = wis_connection_total,
         Centrality = wis_centrality_total) %>% 
  summarise(across(everything(), ~ mean(.x))) %>% 
  pivot_longer(cols = !wis_cluster) %>%
  ggplot(aes(name, value, fill = value)) + 
  geom_bar(stat="identity") + #make the bars
  facet_wrap(~ wis_cluster, nrow=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() + 
  theme_fonts +
  ylab('Standardized Mean') + xlab('Facet of Military Identity') +
  labs(title = 'Military Identity Clusters', 
       subtitle = 'Scaled Means of Warrior Identity Subscales') +
  theme(legend.position = 'none')

## Print::
figure_wis_cluster_scaled_means

## Save::
ggsave(plot = figure_wis_cluster_scaled_means, 
       filename = 'output/figures/figure-wis-cluster-scaled-means.png',
         device = 'png')



# Table: Cluster Differences ------------------------------------------
table_wis_cluster <-
  
  data %>% 
    select(starts_with('wis') & ends_with('total') | wis_cluster) %>% 
    group_by(wis_cluster) %>% 
    summarise(n = n(), across(everything(), ~ mean(.x))) %>% 
    
    right_join(
  
  data %>% 
    select(starts_with('wis') & ends_with('total') | wis_cluster) %>% 
    group_by(wis_cluster) %>% 
    summarise(across(everything(), ~ sd(.x))),
  
  by = c('wis_cluster' = 'wis_cluster')
  ) %>% 
    rename(
      Centrality = wis_centrality_total.x,
      Connection = wis_connection_total.x,
      Family = wis_family_total.x,
      Interdependence =  wis_interdependent_total.x,
      `Private Regard` = wis_private_regard_total.x, 
      `Public Regard` = wis_public_regard_total.x, 
      Skills = wis_skills_total.x,
      Centrality_sd = wis_centrality_total.y,
      Connection_sd = wis_connection_total.y,
      Family_sd = wis_family_total.y,
      Interdependence_sd =  wis_interdependent_total.y,
      `Private Regard_sd` = wis_private_regard_total.y, 
      `Public Regard_sd` = wis_public_regard_total.y, 
      Skills_sd = wis_skills_total.y)

## Print
table_wis_cluster

## Save
table_wis_cluster %>% write_csv('output/tables/table-wis-cluster.csv')
rm(table_wis_cluster)