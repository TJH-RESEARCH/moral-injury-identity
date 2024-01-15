# HISTOGRAM MORAL INJURY SYMPTOMS


ifelse(!exists('theme_fonts'), source(here::here('src/01_config/themes.R')), library(ggplot2))

data <- 
  data %>% 
  mutate(mios_category = 
           factor(
             case_when(mios_total == 0 ~ 0,
                       mios_total < 7 & mios_total != 0 ~ 1,
                       mios_total >= 7 & mios_total < 21 ~ 2,
                       mios_total >= 21 & mios_total < 35 ~ 3,
                       mios_total >= 35 & mios_total < 49 ~ 4,
                       mios_total >= 49 ~ 5),
             ordered = T,
             labels = c('No symptoms (0)', 'Very low (1-6)',
                        'Low (7-20)', 'Moderate (21-34)', 'High (35-48)',
                        'Very High (49+)')))


plot_identity_dissonance <-
  data %>% 
  ggplot(aes(biis_harmony)) +
  labs(x = 'Identity Dissonance',
       y = 'Count', 
       title = 'Identity Dissonance in Veterans',
       subtitle = "What is the distribution of identity dissonance in the sample?",
       caption = 
         "212 veterans were surveyed using the 10-item Bicultural Identity Integration Scale-2.") +
  geom_histogram(fill = '#098743',
                 bins = 17, 
                 color = 'black',
                 linewidth = .5,
                 alpha = .5,
                 #binwidth = ,
                 center = 1) +
  annotate('text', 
           x = 5, y = 17, 
           family = "Arial Bold",
           label = '...') +
  theme_classic() +
  scale_x_reverse() +
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
