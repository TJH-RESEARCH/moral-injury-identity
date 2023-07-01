
# CHECK ANOVA DIAGNOSTICS


# Library -----------------------------------------------------------------
library(ggfortify)


## Blendedness
#results_aov_blended %>% plot()

autoplot(results_aov_blended, 
         which = c(1:6),
         label.size = 3) + 
  theme_bw() +
  theme_fonts


## Harmony
#results_aov_harmony %>% plot()

autoplot(results_aov_harmony, 
         which = c(1:6),
         label.size = 3) + 
  theme_bw() +
  theme_fonts
