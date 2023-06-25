
data_cluster_wisid <- 
  data %>% 
  select(wis_cluster_h_1, wis_cluster_h_2, civilian_commit_total
  ) %>% 
  transmute(across(everything(), ~ scale(.x)))


# Decide on number, model for clustering ----------------------------------
library(clValid)

intern <- clValid::clValid(as.matrix(data_cluster_wisid), 
                           nClust =  2:6, 
                           clMethods= c("hierarchical",
                                        "kmeans",
                                        "diana",
                                        "fanny",
                                        "pam",
                                        "sota",
                                        "som",
                                        "clara"),
                           validation = "internal")

summary(intern)


stab <- clValid(as.matrix(data_cluster_wisid), 
                nClust =  2:6, 
                clMethods = c("hierarchical",
                              "kmeans",
                              "diana",
                              "fanny",
                              "pam",
                              "sota",
                              "som",
                              "clara"),
                validation = "stability")

summary(stab)


# Hierarchical Clustering: 4 -----------------------------------------

clusters <- hclust(dist(data_cluster_wisid, method = "euclidean"))
plot(clusters)

clusterCut2 <- cutree(clusters, 4)



# Save the WIS Cluster ----------------------------------------------------

data <-
  data %>% 
  mutate(cluster_h_wisid = clusterCut2,
         cluster_h_wisid = factor(cluster_h_wisid),
         id_cluster_wish_1 = ifelse(cluster_h_wisid == 1, 1, 0),
         id_cluster_wish_2 = ifelse(cluster_h_wisid == 2, 1, 0),
         id_cluster_wish_3 = ifelse(cluster_h_wisid == 3, 1, 0),
         id_cluster_wish_4 = ifelse(cluster_h_wisid == 4, 1, 0)
  )

data %>% count(cluster_h_wisid)



# What comprises these clusters? ------------------------------------------
data %>% 
  select(starts_with('wis') & ends_with('total') | 
           cluster_h_id | civilian_commit_total) %>% 
  group_by(cluster_h_id) %>% 
  summarise(n = n(), across(everything(), ~ mean(.x)))

data %>% 
  select(starts_with('wis') & ends_with('total') | cluster_h_id |
           civilian_commit_total) %>% 
  group_by(cluster_h_id) %>% 
  summarise(across(everything(), ~ sd(.x)))




# Plot: Bar --------------------------------------------------------------------
data %>% 
  select(starts_with('wis') & ends_with('total')  & !wis_total | cluster_h_id | civilian_commit_total) %>% 
  group_by(cluster_h_id) %>% 
  mutate(across(everything(), ~ scale(.x))) %>%
  summarise(across(everything(), ~ mean(.x))) %>% 
  pivot_longer(cols = !cluster_h_id) %>%
  ggplot(aes(name, value, fill = value)) + 
  geom_bar(stat="identity") + #make the bars
  facet_wrap(~ cluster_h_id, nrow=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() +
  labs(title = 'Warrior Identity', 
       subtitle = 'Scaled means for WIS subscales by cluster')


# Plot: Box --------------------------------------------------------------------
data %>% 
  select(starts_with('wis') & ends_with('total') & !wis_total| cluster_h_id | civilian_commit_total) %>% 
  group_by(cluster_h_id) %>% 
  #summarise(across(everything(), ~ mean(.x))) %>% 
  mutate(across(everything(), ~ .x - min(.x))) %>%
  pivot_longer(cols = !cluster_h_id) %>%
  ggplot(aes(name, value)) + 
  geom_boxplot() +
  facet_wrap(~ cluster_h_id, nrow=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() +
  labs(title = 'Warrior Identity', 
       subtitle = 'Scaled means for WIS subscales by cluster')










