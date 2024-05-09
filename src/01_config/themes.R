

# Description -------------------------------------------------------------
## Contains themes for ggplot2 graphs, maps, and other visuals. 


# Library -----------------------------------------------------------------
library(ggplot2)


# Fonts -------------------------------------------------------------------

theme_fonts <-
  ggplot2::theme(
    
    # Title font and color.:
    text = element_text(
      family = "Arial Bold",
      color = "#000000"
    ),
    
    # Title and subtitle font size.:
    plot.title = element_text(size = 16),
    plot.subtitle = element_text(size = 12),
    plot.caption = element_text(family = "Arial",
                                face = "italic",
                                size = 10,
                                hjust = 0),
    
    ) + theme_classic()
    


