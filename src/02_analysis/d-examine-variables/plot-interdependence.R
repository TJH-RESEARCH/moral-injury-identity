# HISTOGRAM MORAL INJURY SYMPTOMS


ifelse(!exists('theme_fonts'), source(here::here('src/01_config/themes.R')), library(ggplot2))


plot_identity_interdependence <-
  data %>% 
  ggplot(aes(wis_interdependent_total)) +
  geom_density(
      fill = 'grey',
      color = 'black',
      linewidth = .3,
      alpha = .2
      ) +
  theme_classic() +
  theme_fonts +
  theme(
    legend.position = c(.95, 1), 
    legend.justification = c(1, 1),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black")) +
  labs(x = 'Interdependence',
       y = 'Density', 
       title = 'Military Identity Interdependence',
       subtitle = "",
       caption = 
         "Assessed with the Warrior Identity Scale Interdependence subscale.")

plot_identity_interdependence %>% print()

ggsave(filename = 
      here::here('output/figures/interdependence-density.jpg'),
      plot_identity_interdependence,
       device = 'jpeg', 
       units = 'px', 
       height = 564, 
       width = 800,
       scale = 3)




