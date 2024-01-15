# HISTOGRAM MORAL INJURY SYMPTOMS


ifelse(!exists('theme_fonts'),
       source(here::here('src/01_config/themes.R')),
       library(ggplot2)
)

data <- 
  data %>% 
  mutate(m2cq_category = 
           factor(
             case_when(m2cq_mean == 0 ~ 0,
                       m2cq_mean < .5 & m2cq_mean != 0 ~ 1,
                       m2cq_mean >= .5 & m2cq_mean < 1.5 ~ 2,
                       m2cq_mean >= 1.5 & m2cq_mean < 2.5 ~ 3,
                       m2cq_mean >= 2.5 & m2cq_mean < 3.5 ~ 4,
                       m2cq_mean >= 3.5 ~ 5),
             ordered = T,
             labels = c('No difficulty (0)', 
                        'Little to no difficulty (0-.5)',
                        'A little difficulty (0.5 to 1.5)', 
                        'Some difficulty (1.5 to 2.5)', 
                        'A lot of difficulty (2.5 to 3.5)', 
                        'Extreme difficulty (3.5 to 4.0)')
                        
             )
         )


data %>% count(m2cq_category) %>% mutate(perc = n / sum(n) * 100)


plot_m2cq_categories <-
  data %>% 
  ggplot(aes(m2cq_mean)) +
  labs(x = 'Difficulty Reintegrating',
       y = 'Count', 
       fill = 'Reintegration (M2C-Q)',
       title = 'Reintegration',
       subtitle = "What is the distribution of veterans reporting difficulties in the past 30 days?",
       caption = 
         "212 veterans were surveyed using the 16-item Military-to-Civilian Questionnaire (M2C-Q; Sayer et al., 2011) assessing difficulties reintegrating.") +
  geom_histogram(aes(fill = m2cq_category),
                 binwidth = .1,
                 bins = 40,
                 color = 'black',
                 linewidth = .5,
                 alpha = .5,
                 center = .5) +
  annotate('text', 
           x = 1.13, y = 40, 
           family = "Arial Bold",
           label = '23% had no difficulty at all.') +
  annotate('text', 
           x = 1.5, y = 20, 
           family = "Arial Bold",
           label = 'Half the sample had little to no difficulty.') +
  annotate('text', 
           x = 2.5, y = 10, 
           family = "Arial Bold",
           label = '38 of 212 (18%) had a lot of difficulty to extreme difficulty.') +
  geom_vline(xintercept = median(data$m2cq_mean), 
             alpha = .8, 
             size = 1.25,
             linetype = 2,
             color = '#FDE725') +
  theme_classic() +
  scale_x_continuous(breaks = seq(0, 4, .5),limits = c(-.5,4.5)) +
  theme_fonts +
  theme(
    legend.position = c(.95, 1), 
    legend.justification = c(1, 1),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"))

plot_m2cq_categories

ggsave(filename = 
         here::here('output/figures/reintegration-histogram.jpg'),
       plot_m2cq_categories,
       device = 'jpg', 
       units = 'px', 
       height = 564, 
       width = 800,
       scale = 3)

rm(plot_m2cq_categories)