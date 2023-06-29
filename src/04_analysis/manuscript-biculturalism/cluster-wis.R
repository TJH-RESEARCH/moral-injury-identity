


# Select WIS Data ---------------------------------------------------------
data_cluster_wis <- 
  data %>% 
    select(starts_with('wis') & ends_with('total') & !wis_total)



# Decide on number, model for clustering ----------------------------------
library(clValid)

intern <- clValid::clValid(as.matrix(data_cluster_wis), 
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
warnings()
summary(intern)


stab <- clValid(as.matrix(data_cluster_wis), 
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
warnings()
summary(stab)





# Hierarchical Clustering: 3 -----------------------------------------

clusters <- hclust(dist(data_cluster_wis, method = "euclidean"))
plot(clusters)

clusterCut2 <- cutree(clusters, 2)
clusterCut3 <- cutree(clusters, 3)



# Save the WIS Cluster ----------------------------------------------------

data <-
  data %>% 
  mutate(wis_cluster = clusterCut3,
         wis_cluster = factor(wis_cluster,
                                levels = c(3,1,2),
                                labels =  c('low', 'medium', 'high'),
                                ordered = T
                                  ),
        wis_cluster_low = ifelse(wis_cluster == 'low', 1, 0),
        wis_cluster_mid = ifelse(wis_cluster == 'medium', 1, 0),
        wis_cluster_high = ifelse(wis_cluster == 'high', 1, 0))
         
data %>% count(wis_cluster)

## The 2-cluster combines medium and high before incorporating low
## It becomes a very unbalanced group in size

# What comprises these clusters? ------------------------------------------
data %>% 
  select(starts_with('wis') & ends_with('total') | wis_cluster) %>% 
  group_by(wis_cluster) %>% 
  summarise(n = n(), across(everything(), ~ mean(.x)))

data %>% 
  select(starts_with('wis') & ends_with('total') | wis_cluster) %>% 
  group_by(wis_cluster) %>% 
  summarise(across(everything(), ~ sd(.x)))




# Plot: Bar --------------------------------------------------------------------
data %>% 
  select(starts_with('wis') & ends_with('total') | wis_cluster) %>% 
  group_by(wis_cluster) %>% 
  summarise(across(everything(), ~ mean(.x))) %>% 
  mutate(across(!wis_cluster, ~ scale(.x))) %>%
  pivot_longer(cols = !wis_cluster) %>%
  ggplot(aes(name, value, fill = value)) + 
  geom_bar(stat="identity") + #make the bars
  facet_wrap(~ wis_cluster, nrow=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() +
  labs(title = 'Warrior Identity', 
       subtitle = 'Scaled means for WIS subscales by cluster')
 

# Plot: Box --------------------------------------------------------------------
data %>% 
  select(starts_with('wis') & ends_with('total') & !wis_total | wis_cluster) %>% 
  group_by(wis_cluster) %>% 
  #summarise(across(everything(), ~ mean(.x))) %>% 
  #mutate(across(!wis_cluster, ~ scale(.x))) %>%
  pivot_longer(cols = !wis_cluster) %>%
  ggplot(aes(name, value)) + 
  geom_boxplot() +
  facet_wrap(~ wis_cluster, ncol=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() +
  labs(title = 'Warrior Identity', 
       subtitle = 'Scaled means for WIS subscales by cluster')








