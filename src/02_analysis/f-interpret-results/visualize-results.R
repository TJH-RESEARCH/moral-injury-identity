
library(dotwhisker)

# Plot Moral Injury Coefficients -------------------------------------------------------
plot_coefs_moral_injury <-
coefs %>% 
  filter(term == 'mios_total') %>% 
  filter(model == 'wis' | model == 'biis') %>% 
  mutate(model = c('Dissonance', 'Attachment'),
         term = c('Dissonance', 'Attachment')) %>% 
  dwplot(model_name = 'model', 
         dodge_size =  0,
         dot_args = c('shape' = 18, 'size' = 5)
  ) +
  ggsci::scale_color_aaas() +
  theme(legend.position = 'none',
        plot.background = element_rect(fill = "white", colour = NA),
        panel.background = element_rect(fill = "white", colour = NA),
        panel.grid.major = element_line(colour = "grey70", linewidth = 0.2),
        panel.grid.minor = element_blank(),
        axis.ticks = element_blank(),
        legend.background = element_rect(colour="grey80")
  ) +
  #ggthemes::theme_fivethirtyeight() +
  labs(color = 'Model',
       title = 'Coefficients of Moral Injury Compared')


## Print
plot_coefs_moral_injury %>% print()

## Save
ggsave(filename = 'plot-coefs-moral-injury.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)



# Plot all Coefficients ---------------------------------------------------
plot_coefs <-
  coefs %>% #print(n = 200)
  mutate(
    term = c(
      '(Intercept)',
      'Moral Injury',
      'PTSD',
      'Combat',
      'Era: Post-9/11',
      'Era: Persian Gulf',
      'Gender: Male',
      'Race/Ethnicity: Black',
      'Race/Ethnicity: White',
      '(Intercept)',
      'Moral Injury',
      'PTSD',
      'Combat',
      'Era: Post-9/11',
      'Era: Persian Gulf',
      'Gender: Male',
      'Race/Ethnicity: Black',
      'Race/Ethnicity: White',
      '(Intercept)',
      'Moral Injury',
      'Public Regard',
      'PTSD',
      'Combat',
      'Era: Post-9/11',
      'Era: Persian Gulf',
      'Gender: Male',
      'Race/Ethnicity: Black',
      'Race/Ethnicity: White',
      'MI x Public Regard'),
    model = c(rep('Dissonance', 9), rep('Attachment', 9), rep('Interaction', 11))
    ) %>% 
  dwplot(model_name = 'model', 
         dodge_size =  .65,
         dot_args = c('shape' = 18, 'size' = 2.25)
         ) +
  ggsci::scale_color_aaas() +
  theme(legend.position = 'bottom',
        plot.background = element_rect(fill = "white", colour = NA),
        panel.background = element_rect(fill = "white", colour = NA),
        panel.grid.major = element_line(colour = "grey70", linewidth = 0.2),
        panel.grid.minor = element_blank(),
        axis.ticks = element_blank()
        ) +
  #ggthemes::theme_fivethirtyeight() +
  labs(color = 'Model',
       title = 'Model Coefficients')

## Print
plot_coefs %>% print()

## Save
ggsave(filename = 'plot-coefs.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)
