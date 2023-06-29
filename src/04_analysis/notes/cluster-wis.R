


# Select WIS Data ---------------------------------------------------------
data_cluster_wis <- 
  data %>% 
    select(starts_with('wis') & ends_with('total') & !wis_total) %>% 

  # Normalize each variable. Some have more items than others,
  # thus different scales,
  # and the number is somewhat arbitrary anyways.:
      mutate(across(everything(), ~scale(.x)))



# Decide on number, model for clustering ----------------------------------
library(clValid)


# Internal ----------------------------------------------------------------
intern <- clValid::clValid(as.matrix(data_cluster_wis), 
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
warnings()
summary(intern)

## Suggests two clusters using hierarchical clustering


# Stability ---------------------------------------------------------------
stab <- clValid(as.matrix(data_cluster_wis), 
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
warnings()
summary(stab)





# Hierarchical Clustering: 2 -----------------------------------------

clusters <- hclust(dist(data_cluster_wis, method = "euclidean"))
plot(clusters)

clusterCut2 <- cutree(clusters, 2)



# Save the WIS Cluster ----------------------------------------------------

data <-
  data %>% 
  mutate(wis_cluster = clusterCut2,
         wis_cluster = factor(wis_cluster,
                                levels = c(1,2),
                                labels =  c('high_mil', 'low_mil'),
                                ordered = F
                                  ),
        wis_cluster_lower = ifelse(wis_cluster == 'lower', 1, 0),
        wis_cluster_higher = ifelse(wis_cluster == 'higher', 1, 0))
         
data %>% count(wis_cluster)



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
  select(starts_with('wis') & ends_with('total') & !wis_total | wis_cluster) %>% 
  mutate(across(!wis_cluster, ~ scale(.x))) %>%
  group_by(wis_cluster) %>% 
  summarise(across(everything(), ~ mean(.x))) %>% 
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

data %>% 
  ggplot(aes(x = wis_total, 
             y = civilian_commit_total,
             color = wis_cluster)) +
  geom_point(position = 'jitter')



# Cluster with Civilian Identity -------------------------------------------------------------------

## Visually, you can see some above 12, some at 12, some below
data <- 
  data %>% 
  mutate(civilian_cluster = 
           case_when(
             civilian_commit_total > 12 ~ 'high_civ',
             civilian_commit_total == 12 ~ 'med_civ',
             .default = 'low_civ'
           ),
         civilian_cluster = factor(civilian_cluster)
         )

  
## But it is more precise to use K means clusters
civ_kmeans <- kmeans(data$civilian_commit_total, 3)
civ_kmeans$cluster


data <- 
  data %>% 
  mutate(civilian_cluster = civ_kmeans$cluster,
         civilian_cluster = factor(civilian_cluster,
                                   levels = c(1,2,3),
                                   labels = c('low_civ', 'med_civ', 'high_civ')
         )
  )

data %>% 
  select(civilian_commit_total | starts_with('wis') & ends_with('total') | wis_cluster | civilian_cluster) %>% 
  group_by(civilian_cluster, wis_cluster) %>% 
  summarise(n = n(), across(everything(), ~ mean(.x)))

data %>% 
  ggplot(aes(x = civilian_commit_total, y = 0, color = civilian_cluster)) +
  geom_point(position = 'jitter')

# Plot: Bar --------------------------------------------------------------------

data %>% 
  select(civilian_commit_total | starts_with('wis') & ends_with('total') & !wis_total | wis_cluster | civilian_cluster) %>% 
  group_by(civilian_cluster, wis_cluster) %>% 
  summarise(across(everything(), ~ mean(.x))) %>% 
  #mutate(across(!wis_cluster, ~ scale(.x))) %>%
  ungroup() %>% 
  pivot_longer(cols = !c(wis_cluster, civilian_cluster)) %>%
  ggplot(aes(name, value, fill = value)) + 
  geom_bar(stat="identity") + #make the bars
  facet_wrap(~ wis_cluster * civilian_cluster, nrow=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() +
  labs(title = 'Warrior Identity', 
       subtitle = 'Scaled means for WIS subscales by cluster')



# -------------------------------------------------------------------------

data <-
  data %>% 
  mutate(mil_civ_cluster = 
           paste(wis_cluster, civilian_cluster),
         mil_civ_cluster = factor(mil_civ_cluster))

data %>% count(mil_civ_cluster)

## groups are unbalanced in size
## lump high-med with high-high, low-med with low-high

data <-
  data %>% 
  mutate(mil_civ_cluster = 
           case_when(
              mil_civ_cluster == 'low_mil med_civ' ~ 'low_mil high_civ',
              mil_civ_cluster == 'high_mil med_civ' ~ 'high_mil high_civ',
              .default = mil_civ_cluster
           )
  )



data %>% 
  ggplot(aes(biis_blendedness, mil_civ_cluster)) +
  geom_boxplot()

data %>% 
  ggplot(aes(wis_total, civilian_commit_total, 
             color = biis_harmony, size = biis_harmony)) +
  geom_point(alpha = .5, position = 'jitter')

data %>% 
  ggplot(aes(wis_total, civilian_commit_total, 
             color = biis_blendedness, size = biis_blendedness)) +
  geom_point(alpha = .5, position = 'jitter')

  
aov(biis_blendedness ~ mil_civ_cluster, data) %>% summary()
aov(biis_harmony ~ mil_civ_cluster, data) %>% summary()

## This may be a more faithful interpretation of the
## "bidemensional" argument in acculturation theory. 



pair_rest_blend <-
  pairwise.t.test(data$biis_blendedness, 
                  data$mil_civ_cluster,
                  paired = F,
                  p.adj = "bonf",
                  pool.sd = F,
                  alternative = 'two.sided'
              )

pair_rest_blend$p.value %>% round(digits = 3)
# if you have a low military identity, your level of civ id
#   doesn't impact identity blendedness
# if you have a high military identity, your level of civ id
#   doesn't impact identity blendedness
# there is a clear differenence between high and low military id
#   when it comes to blendedness, but not civilian id. 


pair_rest_harm <-
  pairwise.t.test(data$biis_harmony, 
                  data$mil_civ_cluster,
                  paired = F,
                  p.adj = "bonf",
                  pool.sd = F,
                  alternative = 'two.sided'
)

pair_rest_harm$p.value %>% round(digits = 3)

data %>% 
  ggplot(aes(biis_harmony, mil_civ_cluster)) +
  geom_boxplot()

# low-low is diff from high-high -- but opposite from predictions
# low-high and high-low don't differ


# low-low is diff from lowmil-highciv


# low-low is not diff from highmil-lowciv
# high mil-high-civ is different from, high-mil-low-civ
# 
  
TukeyHSD(aov(biis_blendedness ~ mil_civ_cluster, data))
TukeyHSD(aov(biis_harmony ~ mil_civ_cluster, data))  
