# ANOVA


# Hypotheses --------------------------------------------------------------


# H4: Veterans with both high military identity and high civilian identity 
#     have higher levels of bicultural blendedness than others. 

# H5: Veterans with both high military identity and high civilian identity 
#     have higher levels of bicultural harmony than others. 

# H6: Veterans with both low military identity and low civilian identity 
#     have higher levels of bicultural blendedness than others. 

# H7: Veterans with both low military identity and low civilian identity 
#     have higher levels of bicultural harmony than others. 



# Analysis ----------------------------------------------------------------

### Be sure to rename the clusters for ease of interpretation
## i.e., high-high, low-high, high-low, low-low

data %>% count(cluster_h_wis)
data %>% count(cluster_h_id)


# Check ANOVA assumptions -------------------------------------------------

## Independent Observations ------------------------------------------------

### yes. 

## Equivariance -----------------------------------------------------------


data %>% 
  group_by(cluster_h_wis, civ_high) %>% 
  summarize(n = n(),
            mean_blend = mean(biis_blendedness),
            sd_blend = sd(biis_blendedness),
            mean_harm = mean(biis_blendedness),
            sd_harm = sd(biis_harmony))


data %>% 
  group_by(cluster_h_wis) %>% 
  summarize(n = n(),
            mean_blend = mean(biis_blendedness),
            sd_blend = sd(biis_blendedness),
            mean_harm = mean(biis_blendedness),
            sd_harm = sd(biis_harmony),
            wis_mean = mean(wis_total))

data %>% 
  group_by(civ_high) %>% 
  summarize(n = n(),
            mean_blend = mean(biis_blendedness),
            sd_blend = sd(biis_blendedness),
            mean_harm = mean(biis_blendedness),
            sd_harm = sd(biis_harmony))


# Normally Distributed ----------------------------------------------------

data %>% 
  ggplot(aes(biis_total)) +
  geom_histogram() +
  facet_wrap(~cluster_sim)

## There is an outlier point with VERY low civ and mil ID.
## Besides that, there are no issues with normality 
## (in the simmed clusters.Check again with finalized clusters).



# ANOVA -------------------------------------------------------------------

fit_anova <-
  aov(formula = biis_total ~ factor(cluster_sim),
    data = data)
  
fit_anova %>% summary()



# Post Hoc ----------------------------------------------------------------

## If I reject the ANOVA null hypothesis...

### perhaps a Tukey test... there are others
### What p-value to use? Bonferroni correction?

TukeyHSD(fit_anova)
plot(TukeyHSD(fit_anova))


# ANOVA -------------------------------------------------------------------

aov(biis_harmony ~ cluster_h_wis + civ_high, data = data) %>% summary()
aov(biis_harmony ~ cluster_h_wis:civ_high, data = data) %>% summary()
aov(biis_blendedness ~ cluster_h_wis + civ_high, data = data) %>% summary()
aov(biis_blendedness ~ cluster_h_wis:civ_high, data = data) %>% summary()


# Segement data by wis cluster
wis_clust_1 <- data %>% filter(wis_cluster_h_1 == 1)
wis_clust_2 <- data %>% filter(wis_cluster_h_2 == 1)
wis_clust_3 <- data %>% filter(wis_cluster_h_3 == 1)

# WIS clusters have different means for blendedness
t.test(wis_clust_1$biis_blendedness, wis_clust_2$biis_blendedness, var.equal = T)
t.test(wis_clust_1$biis_blendedness, wis_clust_3$biis_blendedness, var.equal = T)
t.test(wis_clust_2$biis_blendedness, wis_clust_3$biis_blendedness, var.equal = T)

# But WIS clusters don't differ on mean harmony
t.test(wis_clust_1$biis_harmony, wis_clust_2$biis_harmony, var.equal = T)
t.test(wis_clust_1$biis_harmony, wis_clust_3$biis_harmony, var.equal = T)
t.test(wis_clust_2$biis_harmony, wis_clust_3$biis_harmony, var.equal = T)


## My big issue with these clusters is 
