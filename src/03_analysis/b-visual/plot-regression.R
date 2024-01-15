
source(here::here('src/01_config/themes.R'))

regression_bivariate <- lm(m2cq_mean ~ mios_total, data)
temp <- summary(regression_bivariate)
r_squared <- round(temp$r.squared, 2)
rm(temp)

library(viridis)  

set.seed(0)
plot_regression <-
  data %>%
  mutate(
    ptsd_positive_screen = 
      factor(ptsd_positive_screen, 
             label = c('Negative', 'Positive')),
    biis_conflict = (biis_harmony - (10 + 50)) * -1 # reverse code harmony so that greater score = more identity dissonance
    ) %>% 
  # ggplot(aes(biis_harmony, biis_conflict)) + geom_point() # test biis_conflict
  ggplot(aes(x = mios_total,
             y = m2cq_mean)) +
  geom_smooth(method = 'lm', 
              formula = 'y ~ x', 
              size = 1.5,
              se = FALSE, 
              color = '#7AD151FF') +
  scale_y_continuous(breaks = seq(0, 4, .5),
                     limits = c(-.05,4)) +
  scale_x_continuous(breaks = seq(0, 60, 10),
                     limits = c(-.05,64)) +
  geom_point(aes(fill = biis_conflict),
    shape = 21,
    alpha = .75,
    size = 2.5, 
    position = 'jitter') +
  scale_fill_viridis(discrete = FALSE,direction = -1) +
  theme_fonts +
  labs(x = 'Moral Injury Symptoms',
       y = 'Reintegration', 
     title = 'Does moral injury predict difficulty reintegrating?',
     #subtitle = "",
     fill = 'Identity Dissonance',
     caption = 
       "Bivariate regression of reintegration on moral injury symptoms.") +
  annotate('text', 
           x = 42.5, y = .5, 
           family = "Arial Bold",
           label = 'The regression predicts a half unit \n increase in difficulty for every \n  10 unit increase in moral injury. \n y = .05x -.10') +
  annotate('text', 
           x = 8, y = 3.5, 
           family = "Arial Bold",
           label = 'This Scatter Plot shows \n observed case with points and \n predicted values with \n the regression line') +
  annotate('text', 
           x = 6.5, y = 2.3, 
           family = "Arial Bold",
           label = 'Moral injury explains about \n half the variance in reintegration:') +
  annotate('text', 
           x = 6.25, y = 2, 
           family = "Arial Bold",
           label = paste('R-squared = ', r_squared),
           parse = TRUE) +
  annotate('text', 
           x = 43, y = 3.4, 
           family = "Arial Bold",
           label = 'The color of the points represents \n levels of identity dissonance \n which may be a way that \n moral injury affects reintegration') +
  theme_fonts +
  theme(
    legend.position = c(.95, 1), 
    legend.justification = c(1, 1),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"),
    panel.grid.major = element_line(linetype = "dotted", color = 'gray'),
    panel.grid.minor = element_blank(),
    panel.background = element_blank(),
    )

plot_regression

ggsave(filename = 
       here::here('output/figures/regression-scatter-plot.jpg'),
       plot_regression,
       device = 'jpeg', 
       units = 'px', 
       height = 564, 
       width = 800,
       scale = 3.75)

rm(plot_regression, r_squared, regression_bivariate)

