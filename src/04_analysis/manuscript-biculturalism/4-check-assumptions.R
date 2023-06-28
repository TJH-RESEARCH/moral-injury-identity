### Military-Civilian Biculturalism?: 
### Bicultural Identity and the Adjustment of Separated Service Members

# Assumptions are:
## 1. Linearity
## 2. Normality
## 3. Homoscedascticity



# 1. Linearity ---------------------------------------------------------------

data %>%
  select(
    wis_centrality_total,
    wis_connection_total,
    wis_family_total,
    wis_interdependent_total,
    wis_private_regard_total,
    wis_public_regard_total,
    wis_skills_total,
    biis_blendedness,
    biis_harmony,
    civilian_commit_total) %>%
  GGally::ggpairs()

## 1. Linearity
### Nothing looks curvilinear

## 2. Normality
### Civilian Commitment is somewhat bimodal
### An overreporting of all 3s or all 4s on the 4-question scale
### As noted at length in the file for Chapter 2,
###   several of the WIS variables are skewed.

## 3. Homoscedascticity: 


#### Unlike with chapter 2, there are no demographic variables
#### in this model, so no need to remove demographic outliers. 

### Check the diagnostic plots for the 
###  normality and linearity of errors. 

### No transformations. 