
# Assumptions are:
## 1. Linearity
## 2. Normality
## 3. Homoscedascticity




# 1. Linearity ---------------------------------------------------------------

## Paired scatter plots, density plots
data %>%
  select(civilian_commit_total,
         wis_total,
         mios_total,
         biis_blendedness,
         biis_harmony,
         mcarm_total) %>%
  GGally::ggpairs()
