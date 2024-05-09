# HISTOGRAM MORAL INJURY SYMPTOMS


ifelse(!exists('theme_fonts'), source(here::here('src/01_config/themes.R')), library(ggplot2))


plot_identity_dissonance <-
  data %>% 
  ggplot(aes(biis_conflict)) +
  labs(x = 'Identity Dissonance',
       y = 'Count', 
       title = 'Identity Dissonance in a Sample of Veterans',
       subtitle = "",
       caption = 
         "Veterans were surveyed using the 10-item Bicultural Identity Integration Scale-2.") +
  geom_histogram(
    fill = 'grey',
                 bins = 18, 
                 color = 'black',
                 linewidth = .5,
                 alpha = .5
                 #binwidth = ,
                 #center = 1
               ) +
  theme_classic() +
  theme_fonts +
  theme(
    legend.position = c(.95, 1), 
    legend.justification = c(1, 1),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"))

plot_identity_dissonance

ggsave(filename = 
      here::here('output/figures/identity-dissonance-histogram.jpg'),
       plot_identity_dissonance,
       device = 'jpeg', 
       units = 'px', 
       height = 564, 
       width = 800,
       scale = 3)

rm(plot_identity_dissonance)
