


library(ggsci)
library(patchwork)

plot_boot_regard <-
  results_boot %>% 
  filter(mediation == 'inter') %>% 
  ggplot(aes(ab)) +
  geom_histogram(bins = 20, color = 'black', fill = '#31B7BCFF', alpha = .8) +
  geom_vline(aes(xintercept = 
                   results_boot %>% 
                   filter(mediation == 'inter' & pci_upper_95 == 1) %>% 
                   ungroup() %>% 
                   select(ab) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  geom_vline(aes(xintercept = 
                   results_boot %>% 
                   filter(mediation == 'inter' & pci_lower_95 ==1) %>% 
                   ungroup() %>% 
                   select(ab) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  labs(x = 'Indirect Effect',
       y = 'Count',
       title = 'Interdependence',
       #subtitle = 'Bootstrapped 95% Percentile Confidence Intervals'
       ) +
  theme(
    panel.grid.major.x = element_line(color = '#CBCCCB'),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = '#CBCCCB'),
    panel.background = element_rect(fill = 'white'),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = '#CBCCCB')
  )


plot_boot_inter <-
  results_boot %>% 
  filter(mediation == 'regard') %>% 
  ggplot(aes(ab)) +
  geom_histogram(bins = 20, color = 'black', fill = '#31B7BCFF', alpha = .8) +
  geom_vline(aes(xintercept = 
                   results_boot %>% 
                   filter(mediation == 'regard' & pci_upper_95 == 1) %>% 
                   ungroup() %>% 
                   select(ab) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  geom_vline(aes(xintercept = 
                   results_boot %>% 
                   filter(mediation == 'regard' & pci_lower_95 == 1) %>% 
                   ungroup() %>% 
                   select(ab) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  labs(
       x = '',
       y = 'Count',
       title = 'Regard',
       #subtitle = 'Bootstrapped 95% Percentile Confidence Intervals'
       ) +
  theme(
    panel.grid.major.x = element_line(color = '#CBCCCB'),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = '#CBCCCB'),
    panel.background = element_rect(fill = 'white'),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = '#CBCCCB')
  )



plot_boot_inter / plot_boot_regard + 
patchwork::plot_annotation(
  title = 'Bootstrap Distributions and 95% Percential Intervals')


## Save
ggsave(filename = 'plot-bootstrap.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)
