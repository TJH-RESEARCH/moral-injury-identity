# HISTOGRAM MORAL INJURY SYMPTOMS


ifelse(!exists('theme_fonts'), source(here::here('src/01_config/themes.R')), library(ggplot2))


plot_identity_private_regard <-
  data %>% 
  ggplot(aes(wis_private_regard_total)) +
  labs(x = 'Military Pride',
       y = 'Count', 
       title = 'Military Pride in a Sample of Veterans',
       subtitle = "",
       caption = 
         "Veterans were surveyed using the 7-item Warrior Identity Scale Private Regard subscale.") +
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

plot_identity_private_regard %>% print()

ggsave(filename = 
      here::here('output/figures/private-regard-histogram.jpg'),
       plot_identity_private_regard,
       device = 'jpeg', 
       units = 'px', 
       height = 564, 
       width = 800,
       scale = 3)

rm(plot_identity_private_regard)




