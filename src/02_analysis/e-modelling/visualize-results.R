


library(ggsci)
library(patchwork)

plot_boot_inter<-
  result_indirect_all_coefs %>% 
  filter(mediation == 'inter') %>% 
  ggplot(aes(ab)) +
  geom_histogram(bins = 20, color = 'black', fill = '#31B7BCFF', alpha = .8) +
  geom_vline(aes(xintercept = 
                   result_indirect %>% 
                   filter(mediation == 'inter') %>% 
                   select(pci_upper_95) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  geom_vline(aes(xintercept = 
                   result_indirect %>% 
                   filter(mediation == 'inter') %>% 
                   select(pci_lower_95) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  labs(x = '',
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


plot_boot_regard <-
  result_indirect_all_coefs %>% 
  filter(mediation == 'regard') %>% 
  ggplot(aes(ab)) +
  geom_histogram(bins = 20, color = 'black', fill = '#31B7BCFF', alpha = .8) +
  geom_vline(aes(xintercept = 
                   result_indirect %>% 
                   filter(mediation == 'regard') %>% 
                   select(pci_upper_95) %>%
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  geom_vline(aes(xintercept = 
                   result_indirect %>% 
                   filter(mediation == 'regard') %>% 
                   select(pci_lower_95) %>% 
                   as.numeric()),
             color = '#D51317FF',
             alpha = .6,
             linewidth = 1.75,
             linetype = 5
  ) +
  labs(
       x = 'Indirect Effect',
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
  title = 'Bootstrap Distributions and 95% Percential Intervals') +
patchwork::plot_layout(axes = 'collect')



## Save
ggsave(filename = 'plot-bootstrap.jpg', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)



