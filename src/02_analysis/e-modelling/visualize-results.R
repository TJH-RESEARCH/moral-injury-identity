


library(ggsci)


ab %>% 
  filter(mediation == 'inter') %>% 
  ggplot(aes(estimate_ab)) +
  geom_histogram(bins = 20, color = 'black', fill = '#31B7BCFF') +
  geom_vline(aes(xintercept = 
                   ab %>% 
                   filter(mediation == 'inter' & pci_upper_95 == 1) %>% 
                   ungroup() %>% 
                   select(estimate_ab) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  geom_vline(aes(xintercept = 
                   ab %>% 
                   filter(mediation == 'inter' & pci_lower_95 ==1) %>% 
                   ungroup() %>% 
                   select(estimate_ab) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  labs(x = 'Indirect Effect',
       y = 'Count',
       title = 'Mediation Model: Interdependence') +
  theme(
    panel.grid.major.x = element_line(color = '#CBCCCB'),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = '#CBCCCB'),
    panel.background = element_rect(fill = 'white'),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = '#CBCCCB')
  )



ab %>% 
  filter(mediation == 'regard') %>% 
  ggplot(aes(estimate_ab)) +
  geom_histogram(bins = 20, color = 'black', fill = '#31B7BCFF') +
  geom_vline(aes(xintercept = 
                   ab %>% 
                   filter(mediation == 'regard' & pci_upper_95 == 1) %>% 
                   ungroup() %>% 
                   select(estimate_ab) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  geom_vline(aes(xintercept = 
                   ab %>% 
                   filter(mediation == 'regard' & pci_lower_95 == 1) %>% 
                   ungroup() %>% 
                   select(estimate_ab) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  labs(x = 'Indirect Effect',
       y = 'Count',
       title = 'Mediation Model: Private Regard') +
  theme(
    panel.grid.major.x = element_line(color = '#CBCCCB'),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = '#CBCCCB'),
    panel.background = element_rect(fill = 'white'),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = '#CBCCCB')
  )




## Print
plot_coefs %>% print()

## Save
ggsave(filename = 'plot-coefs.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)
