


# A manova tells us if the groups
# in this case discretized levels of MI symptoms
# can predict a set of identity factors. 
# In other words, the hypothesis is that
# MI symptoms predict difference in identity as a whole.
# If my hypotheses are about the effect of MI on 
# specific identity variables, then anova or regression
# works.

# My reason for preferring a Manova in the first place
# is the potential for association between the different
# identity variables. Testing them as a set of DVs
# captures some of this association.

# Since I am discretizing the IV, it might be better
# just to use linear regression. 

# If I want to hypothesize about an overall change in 
# identity, I can sum the WIS subscales together. 
# The overall scale had strong internal consistency. 

# If I use linear regression, then the question of how
# to capture the association between identity variables returns.

# presumably I enter all of them as covariates, but this
# will likely reduce the overall impact of the IV on the DV.

# An SEM? 
# SEM will model the relationship between DVs
# Most people use SEM to look at overall model fit. 
# I would want to emphasize the coefficients on the IV-DV paths
# Not sure if this produces a p-value that could be used
# to reject or fail to the null hypo. 





# Hypotheses --------------------------------------------------------------

## 
# 1. Moral injury symptoms predict lower levels of private regard for the military.
# 2. Moral injury symptoms predict lower levels of public regard for the military.
# 3. Moral injury symptoms predict lower levels of connection to the military. 

## Different types of moral injury events have different effects on other facets of military identity. 
# 4. Moral injury events other predict lower levels of military interdependence than other types of moral injuries.
# 5. Moral injury events other predict lower levels of military as family than other types of moral injuries. 
# 6. Moral injuries events self predict lower levels of military centrality than other moral injury events



# Analysis Steps ----------------------------------------------------------

# 1. Check assumptions

# GENERAL

# ANOVA

## DVs normally distributed
## DVs normally distributed within groups
## Equivariance across groups?
## If no equivariance, balance of group size?


# Statistical hypotheses
### H0: Group mean vectors are equal across groups.
### H1: One or more group mean vectors differs from the group mean vectors of the other groups.

# MANOVA Assumptiosn (Tabachnick & Fidell, 2013) --------------- 
## Adequate sample size...   
### "More cases than DVs in every cell" (p. 250)
### ...Missingness - none
### ...Power -   

## DVs are multivariate normal

## Check for univariate and multivariate outliers across all variables
### "Change, transform, or eliminate them. Report the change" (Tabachnick & Fidell, 2013, p. 251)

## Equality of covariance matrices - Box's M - if group sizes are equal, you can ignore the result (Tabachnick & Fidell, 2013, p. 252)

## Linearity between all pairs of variables

## Homogeneity of Regression (if Roy_Bargmann stepdown analysis is used)

## Measures are reliable
### Internal consistency

## No multicolinearity or singularity
### Correlations between DVs

# 2. Visualize

# 3. MANOVA

# 4. Diagnostics

# 4. Post-Hoc Test: Stepdown Analysis or Linear Disciminat Analysis

# 5. Model 2: "A 2 x 2 between-subjects multivariate analysis of variance" (MANOVA)

# Report



# Compute MIOS Levels ------------------------------------------------------
data <- 
  data %>% 
  mutate(mios_level = 
           case_when(
             mios_total == 0 ~ 'No symptoms',
             mios_total > mean(data$mios_total) + .75 * sd(data$mios_total) ~ 'High',
             mios_total >= mean(data$mios_total)  ~ 'Above Average',
             mios_total < mean(data$mios_total) - .75 * sd(data$mios_total) ~ 'Low',
             mios_total < mean(data$mios_total)  ~ 'Below Average'),
         
         mios_level = factor(mios_level,
                             levels = c('No symptoms', 
                                        'Low', 
                                        'Below Average',
                                        'Above Average',
                                        'High'),
                             ordered = T))
data %>% select(mios_level)



# 1. Check Assumptions of MANOVA -------------------------------------------------------


# Descriptive Statistics --------------------------------------------------
data %>% 
  select(mios_level | starts_with('wis') & ends_with('total')) %>% 
  psych::describe()

# DVs are multivariate normal
multivariate_normal <- with(data, QuantPsyc::mult.norm(cbind(wis_private_regard_total, 
                           wis_public_regard_total,
                           wis_interdependent_total, 
                           wis_connection_total,
                           wis_family_total,
                           wis_centrality_total,
                           wis_skills_total),
                           chicrit = .005))

## Print Test Results
multivariate_normal$mult.test

## Plot D-squared:
hist(multivariate_normal$Dsq)
hist(multivariate_normal$Dsq / mean(multivariate_normal$Dsq))

## Number of multivariate outliers:
sum(multivariate_normal$Dsq > multivariate_normal$CriticalDsq)


# Equivariance and Group Size ---------------------------------------------
## ratio of least/greatest variance should be within .5 to 2
data %>% 
  group_by(mios_level) %>% 
  summarise(n = n(), across(starts_with('wis') & ends_with('total'), 
                   list(#mean = mean, 
                        sd = sd), 
                   .names = "{.col}.{.fn}"))
## The only issue is with wis_private_regard_total.sd 2.09 / 6.11


# Adequate Sample Size

pwr::pwr.f2.test(
  
  # degrees of freedom for numerator:
  u = length(levels(data$mios_level)) - 1,
  
  # degrees of freedom for denominator:
  v = nrow(data) - length(levels(data$mios_level)),
  
  # effect size
  f2 = 0.055 / (1 - 0.055),
  
  # Significance Level:
  sig.level = 0.05,  
  power = NULL)


# Linearity between covariate pairs ---------------------------------------
data %>% 
  select(mios_level | starts_with('wis') & ends_with('total')) %>% 
  GGally::ggpairs()


# Check Correlation between DVs -------------------------------------------
## Corr Plot: WIS Subscales
data %>% 
  select(starts_with('wis') & ends_with('total')) %>% 
  cor() %>% 
  corrplot::corrplot(method="number", type = 'lower', diag = F)


# Box M Test --------------------------------------------------------------
## Equality of covariance matrix
heplots::boxM(cbind(wis_private_regard_total, 
                    wis_public_regard_total,
                    wis_interdependent_total, 
                    wis_connection_total,
                    wis_family_total,
                    wis_centrality_total,
                    wis_skills_total) ~
                mios_level, data)


## Homogeneity of Regression (if Roy_Bargmann stepdown analysis is used)



# 2. Visualize ------------------------------------------------------------------
# Box Plots
data %>% ggplot(aes(wis_centrality_total, mios_level, fill = mios_level)) + geom_boxplot() + theme_classic()
data %>% ggplot(aes(wis_connection_total, mios_level, fill = mios_level)) + geom_boxplot() + theme_classic()
data %>% ggplot(aes(wis_interdependent_total, mios_level, fill = mios_level)) + geom_boxplot() + theme_classic()
data %>% ggplot(aes(wis_family_total, mios_level, fill = mios_level)) + geom_boxplot() + theme_classic()
data %>% ggplot(aes(wis_public_regard_total, mios_level, fill = mios_level)) + geom_boxplot() + theme_classic()
data %>% ggplot(aes(wis_private_regard_total, mios_level, fill = mios_level)) + geom_boxplot() + theme_classic()
data %>% ggplot(aes(wis_skills_total, mios_level, fill = mios_level)) + geom_boxplot() + theme_classic()


# 3. MANOVA ------------------------------------------------------------------


# MANOVA
model_manova_1 <- lm(
  cbind(wis_private_regard_total, 
        wis_public_regard_total,
        wis_interdependent_total, 
        wis_connection_total,
        wis_family_total,
        wis_centrality_total) ~ 
    mios_level, data = data
)

fit_1 <- manova(model_manova_1) 

# Effect size - partial eta squared
effectsize::eta_squared(fit_1, alternative = 'two.sided')

# Path diagram:
semPlot::semPaths(model_manova_1)

# MANOVA output
fit_1

# MANOVA Summary 
fit_1 %>% summary()

# MANOVA Coefficients
fit_1$coefficients


# Discriminate Analysis ---------------------------------------------------

## should use cross-validation (Tabachnick & Fidell, 2013, p. 405) 
## or better a train/test split



model_lda <-
  MASS::lda(
    mios_level ~  
    wis_private_regard_total + 
          wis_public_regard_total +
          wis_interdependent_total +
          wis_connection_total +
          wis_family_total +
          wis_centrality_total,
    data = data
)

predictions <- model_lda %>% predict(data)
mean(as.character(predictions$class)==as.character(data$mios_level))

# -------------------------------------------------------------------------



### Composite
model_manova_2 <- lm(
  cbind(wis_regard_score, 
        wis_memory_score,
        wis_current_score) ~ 1 + 
    mios_level, data = data
)

fit_2 <- manova(model_manova_2) 


# Path diagram:
semPlot::semPaths(model_manova_2)

# MANOVA output
fit_2

# MANOVA Summary 
fit_2 %>% summary()

# MANOVA Coefficients
fit_2$coefficients

# Step Down Procedure

## 1. 
model_stepdown_1 <- aov(wis_current_score ~ mios_level, data = data)
model_stepdown_1 %>% summary()

model_stepdown_2 <- aov(wis_memory_score ~ mios_level + wis_current_score, data = data)
model_stepdown_2 %>% summary()

model_stepdown_3 <- aov(wis_regard_score ~ mios_level + wis_current_score + wis_memory_score, data = data)
model_stepdown_3 %>% summary()



#....Now I am questioning the level of my step down. Head back to the theory
# and think through which one is most important






## 1. Centrality
model_stepdown_1 <- aov(wis_centrality_total ~ mios_level, data = data)
model_stepdown_1 %>% summary()

## 2. Connection
model_stepdown_2 <- aov(wis_connection_total ~
                          mios_level + 
                          wis_centrality_total, data = data)
model_stepdown_2 %>% summary()

## 3. Public Regard
model_stepdown_3 <- aov(wis_public_regard_total ~ 
                          mios_level + 
                          wis_centrality_total +
                          wis_connection_total, data = data)
model_stepdown_3 %>% summary()


## 3. Public Regard
model_stepdown_3 <- aov(wis_public_regard_total ~ 
                          mios_level + 
                          wis_centrality_total +
                          wis_connection_total, data = data)
model_stepdown_3 %>% summary()

## 2. Private Regard
model_stepdown_2 <- aov(wis_private_regard_total ~ mios_level + wis_connection_total, data = data)
model_stepdown_2 %>% summary()




## 5. Public Regard
model_stepdown_5 <- aov( ~ mios_level + 
                           wis_connection_total + 
                           wis_private_regard_total +
                           wis_public_regard_total, data = data)
model_stepdown_5 %>% summary()

## 6. Public Regard
model_stepdown_6 <- aov(wis_public_regard_total ~ mios_level + wis_connection_total + wis_private_regard_total, data = data)
model_stepdown_6 %>% summary()

# Individual ANOVAs -------------------------------------------------------


model_anova_connection <- aov(wis_connection_total ~ mios_level, data = data)
model_anova_private <- aov(wis_private_regard_total ~ mios_level, data = data)
model_anova_public <- aov(wis_public_regard_total ~ mios_level, data = data)
model_anova_centrality <- aov(wis_centrality_total ~ mios_level, data = data)
model_anova_interdependent <- aov(wis_interdependent_total ~ mios_level, data = data)
model_anova_family <- aov(wis_family_total ~ mios_level, data = data)
model_anova_skill <- aov(wis_skills_total ~ mios_level, data = data)
  
model_anova_private %>% summary()
model_anova_public %>% summary()
model_anova_interdependent %>% summary()
model_anova_connection %>% summary()
model_anova_family %>% summary()
model_anova_centrality %>% summary()
model_anova_skill %>% summary()

# 
