
# BOOTSTRAPPING

# Military-Civilian Biculturalism?: 
# Bicultural Identity and the Adjustment of Separated Service Members


# Load Package ---------------------------------------------------------------
library(lmboot)


# Bootstrap ---------------------------------------------------------------
results_boot_blendedness <- 
  lmboot::ANOVA.boot(as.vector(biis_blendedness) ~ 
                     civilian_cluster +
                     wis_cluster +
                     civilian_cluster * wis_cluster,
                   B = 1000,
                   type = 'residual',
                   wild.dist = 'normal',
                   seed = 1,
                   data = data
                    )

results_aov_blended
results_boot_blendedness$`p-values`


# Bootstrap ---------------------------------------------------------------

library(lmboot)

results_boot_harmony <- 
  lmboot::ANOVA.boot(as.vector(biis_harmony) ~ 
                       civilian_cluster +
                       wis_cluster +
                       civilian_cluster * wis_cluster,
                     B = 1000,
                     type = 'residual',
                     wild.dist = 'normal',
                     seed = 1,
                     data = data
  )

results_aov_harmony %>% summary()
results_boot_harmony$`p-values`

