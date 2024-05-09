# HISTOGRAM MORAL INJURY SYMPTOMS


ifelse(!exists('theme_fonts'), source(here::here('src/01_config/themes.R')), library(ggplot2))


plot_identity_public_regard <-
  data %>% 
  ggplot(aes(wis_public_regard_total)) +
  labs(x = 'Military Pride',
       y = 'Count', 
       title = 'Perceived Public Regard for the Military in a Sample of Veterans',
       subtitle = "",
       caption = 
         "Veterans were surveyed using the 4-item Warrior Identity Scale Public Regard subscale.") +
  geom_histogram(
    fill = 'grey',
                 bins = 18, 
                 color = 'black',
                 linewidth = .3,
                 alpha = .2
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

plot_identity_public_regard %>% print()

ggsave(filename = 
      here::here('output/figures/public-regard-histogram.jpg'),
       plot_identity_public_regard,
       device = 'jpeg', 
       units = 'px', 
       height = 564, 
       width = 800,
       scale = 3)

rm(plot_identity_public_regard)




