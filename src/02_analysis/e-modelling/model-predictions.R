
# PREDICTED VS ACTUAL OUTCOMES ---------------------------------------------------------------------
library(patchwork)

boot_preds %>% 
  filter(model == 'lm_inter') %>%
  select(id, model, mediation, .fitted, wis_interdependent_total) %>% 
  pivot_longer(-c(id, model, mediation)) %>% 
  ggplot(aes(value, fill = name)) +
  geom_density(alpha = .25) +
  facet_wrap(vars(model)) +
  ggsci::scale_color_tron() +
  theme(
    legend.position = 'bottom',
    panel.grid.major.x = element_line(color = '#CBCCCB'),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = '#CBCCCB'),
    panel.background = element_rect(fill = 'white'),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = '#CBCCCB')
  )




boot_preds %>% 
  filter(model == 'lm_mios_regard') %>%
  select(id, model, mediation, .fitted, mios_total) %>% 
  pivot_longer(-c(id, model, mediation)) %>% 
  ggplot(aes(value, fill = name)) +
  geom_density(alpha = .25) +
  facet_wrap(vars(model)) +
  ggsci::scale_color_tron() +
  theme(
    legend.position = 'bottom',
    panel.grid.major.x = element_line(color = '#CBCCCB'),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = '#CBCCCB'),
    panel.background = element_rect(fill = 'white'),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = '#CBCCCB')
  )


boot_preds %>% 
  filter(model == 'lm_regard') %>%
  select(id, model, mediation, .fitted, wis_private_regard_total) %>% 
  pivot_longer(-c(id, model, mediation)) %>% 
  ggplot(aes(value, fill = name)) +
  geom_density(alpha = .25) +
  facet_wrap(vars(model)) +
  ggsci::scale_color_tron() +
  theme(
    legend.position = 'bottom',
    panel.grid.major.x = element_line(color = '#CBCCCB'),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = '#CBCCCB'),
    panel.background = element_rect(fill = 'white'),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = '#CBCCCB')
  )



boot_preds %>% 
  filter(model == 'lm_mios_regard') %>%
  select(id, model, mediation, .fitted, wis_private_regard_total) %>% 
  pivot_longer(-c(id, model, mediation)) %>% 
  ggplot(aes(value, fill = name)) +
  geom_density(alpha = .25) +
  facet_wrap(vars(model)) +
  ggsci::scale_color_tron() +
  theme(
    legend.position = 'bottom',
    panel.grid.major.x = element_line(color = '#CBCCCB'),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = '#CBCCCB'),
    panel.background = element_rect(fill = 'white'),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = '#CBCCCB')
  )

(density_mios_regard + density_mios_inter) /
  (density_regard + density_inter) +
  patchwork::plot_annotation(title = 'Predicted vs. Observed Values')

