# ANOVA


# Hypotheses --------------------------------------------------------------

## H3: Veterans with both high military identity and high 
## civilian identity have higher levels of
## bicultural identity integration than others. 

## H4: Veterans with both low military identity and 
## low civilian identity have higher levels of 
## bicultural identity integration than others. 


# Analysis ----------------------------------------------------------------

## First, simulate the clusters to blind myself to the results
## while I code up the ANOVA and finish writing the manuscript.

data <-
  data %>% 
  mutate(cluster_sim = sample(4, nrow(data), replace = T))


### Be sure to rename the clusters for ease of interpretation
## i.e., high-high, low-high, high-low, low-low


# Check ANOVA assumptions -------------------------------------------------

## Independent Observations ------------------------------------------------

### yes. 

## Equivariance -----------------------------------------------------------

data %>% 
  group_by(cluster_sim) %>% 
  summarise(mean_biis = mean(biis_total), 
            sd_biis = sd(biis_total), 
            n = n(), 
            mean_wis = mean(wis_total),
            mean_civ = mean(civilian_commit_total))

data %>% 
  ggplot(aes(biis_total, factor(cluster_sim))) +
  geom_boxplot()


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
### What p-value to use?

TukeyHSD(fit_anova)
plot(TukeyHSD(fit_anova))
