
# Library -----------------------------------------------------------------
library(ggfortify)
if(!exists('theme_fonts')) source(here::here('src/01_config/themes.R'))

# Create a custom plot function -------------------------------------------
## Take an lm object
plot_lm <- function(lm){

  autoplot(lm, 
           which = c(1:6),
           label.size = 3) + 
    theme_bw() +
    theme_fonts
}

