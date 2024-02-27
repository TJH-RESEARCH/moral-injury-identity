# HISTOGRAM MORAL INJURY SYMPTOMS




quantiles <- as.numeric(quantile(data$mios_total, c(0, .25,
                                                    .5, .75, .95, 1)))

ifelse(!exists('theme_fonts'),
       source(here::here('src/01_config/themes.R')),
       library(ggplot2)
)

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


data %>% count(mios_category) %>% mutate(perc = n / sum(n) * 100)
data %>% count(ptsd_positive_screen) %>% mutate(perc = n / sum(n) * 100)

data %>% 
  mutate(mios_under = mios_total < 14) %>% 
  count(mios_under) %>% 
  mutate(perc = n / sum(n) * 100)

plot_mios_categories <-
  data %>% 
  ggplot(aes(mios_total)) +
  labs(x = 'Moral Injury Symptoms',
       y = 'Count', 
       fill = 'Symptoms',
       title = 'Moral Injury in Veterans',
       subtitle = "What is the distribution of moral injury symptoms?",
       caption = 
         "212 veterans were surveyed using the 14-item Moral Injury Outcomes Scale assessing guilt- and trust-violation-related symptoms.") +
  geom_histogram(aes(fill = mios_category),
                 bins = 64, 
                 color = 'black',
                 linewidth = .5,
                 alpha = .5,
                 binwidth = 1,
                 center = 1) +
  annotate('text', 
           x = 5, y = 17.5, 
           family = "Arial Bold",
           label = '7.5% have no symptoms.') +
  annotate('text', 
           x = 33, y = 14, 
           family = "Arial Bold",
           label = 'The median score is 14, low for a scale that ranges from 0 to 64.') +
  annotate('text', 
           x = 40, y = 9, 
           family = "Arial Bold",
           label = 'About a quarter of cases were moderate.') +
  annotate('text', 
           x = 47, y = 4, 
           family = "Arial Bold",
           label = 'Less than 5% have high or very high symptoms.') +
  geom_vline(xintercept = quantiles[3], 
             alpha = .8, 
             size = 1.25,
             linetype = 2,
             color = '#FDE725') +
  theme_classic() +
  scale_x_continuous(breaks = seq(0, 64, 7),limits = c(-2,66)) +
  theme_fonts +
  theme(
    legend.position = c(.95, 1), 
    legend.justification = c(1, 1),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"))

plot_mios_categories

ggsave(filename = 
         here::here('output/figures/moral-injury-histogram.jpg'),
       plot_mios_categories,
       device = 'jpeg', 
       units = 'px', 
       height = 564, 
       width = 800,
       scale = 3.5)


rm(plot_mios_categories, 
   quantiles)
