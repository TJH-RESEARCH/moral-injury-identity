# HISTOGRAM MORAL INJURY SYMPTOMS


ifelse(!exists('theme_fonts'), source(here::here('src/01_config/themes.R')), library(ggplot2))

data %>% 
  mutate(mios_screener = factor(mios_screener)) %>% 
  ggplot(aes(mios_screener, mios_total)) + 
  geom_violin(fill = "#999999", alpha = .2, linewidth = .2) +
  labs(title = 'Severity of Moral Injury Symptoms',
       subtitle = 'The impact of Experiencing a Moral Injury Event',
       caption = 'Mean symptoms for veterans who experience a moral injury are extreme for non-endorsers') +
  xlab('Experienced a Potentially Morally Injurious Event') +
  ylab('Moral Injury Symptoms') +
  geom_hline(aes(yintercept = 
                   data %>% 
                   filter(mios_screener == 1) %>% 
                   summarize(mean(mios_total)) %>% as.numeric()),
             linetype = 2
             ) + 
  theme_classic() +
  theme_fonts


ggsave(here::here('output/figures/mios-violin.jpg'))


# Histogram ---------------------------------------------------------------
data %>% 
  ggplot(aes(mios_total)) +
  labs(x = 'Moral Injury Symptoms',
       y = 'Number of Veterans', 
       title = 'Moral Injury in a Sample of Veterans',
       subtitle = "",
       caption = 
         "Veterans were surveyed using the 14-item Moral Injury Outcome Scale.") +
  geom_histogram(
    fill = "#999999",
                 bins = 18, 
                 color = 'black',
                 linewidth = .2,
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

ggsave(filename = here::here('output/figures/mios-histogram.jpg'))


