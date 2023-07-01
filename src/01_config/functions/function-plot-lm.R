
# Library -----------------------------------------------------------------
library(ggfortify)
if(!exists('theme_fonts')) source(here::here('src/01_config/themes.R'))

# Create a custom plot function -------------------------------------------
plot_lm <- function(data, DV, IVs){
 
  formula <- as.formula(paste(as.character(DV), " ~ ", IVs, sep = ""))
  x <- lm(formula = formula, data = data)

  autoplot(x, 
           which = c(1:6),
           label.size = 3) + 
    theme_bw() +
    theme_fonts
  
}

# Test:
#x <- lm_custom(data, 'wis_total', c('mios_total', 'sex'))
#x
#y <- lm(wis_total ~ mios_total + sex, data)
#plot_lm(x)
#plot(x$summary)
#x$summary$terms

#attr(x$summary$terms, "variables")
