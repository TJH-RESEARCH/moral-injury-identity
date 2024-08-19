
# PREDICTED VS ACTUAL OUTCOMES ---------------------------------------------------------------------
library(patchwork)
library(viridis)
library(viridisLite)

density_inter <-
  boot_preds %>% 
  filter(model == 'lm_inter', id == 'Apparent') %>%
  select(id, model, mediation, .fitted, wis_interdependent_total) %>% 
  rename(Predicted = .fitted, Observed = wis_interdependent_total) %>%
  mutate(model = ifelse(model == 'lm_inter', "Interdependence", model)) %>% 
  pivot_longer(-c(id, model, mediation)) %>% 
  ggplot(aes(value, fill = name)) +
  geom_density(alpha = .5) +
  facet_wrap(vars(model)) +
  viridis::scale_fill_viridis(discrete = TRUE) +
  labs(fill = '', y = 'Density', x = '') + 
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



density_mios_inter <-
  boot_preds %>% 
  filter(model == 'lm_mios_inter', id == 'Apparent') %>%
  select(id, model, mediation, .fitted, mios_total) %>% 
  rename(Predicted = .fitted, Observed = mios_total) %>%
  mutate(model = ifelse(model == 'lm_mios_inter', 
                        "Moral Injury ~ Interdependence", model)) %>% 
  pivot_longer(-c(id, model, mediation)) %>% 
  ggplot(aes(value, fill = name)) +
  geom_density(alpha = .5) +
  facet_wrap(vars(model)) +
  viridis::scale_fill_viridis(discrete = TRUE) +
  labs(fill = '', y = '', x = '') + 
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

density_regard <-
  boot_preds %>% 
  filter(model == 'lm_regard', id == 'Apparent') %>%
  select(id, model, mediation, .fitted, wis_private_regard_total) %>% 
  rename(Predicted = .fitted, Observed = wis_private_regard_total) %>%
  mutate(model = ifelse(model == 'lm_regard', "Regard", model)) %>% 
  pivot_longer(-c(id, model, mediation)) %>% 
  ggplot(aes(value, fill = name)) +
  geom_density(alpha = .5) +
  facet_wrap(vars(model)) +
  viridis::scale_fill_viridis(discrete = TRUE) +
  labs(fill = '', x = "Value", y = 'Density') + 
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


density_mios_regard <-
  boot_preds %>% 
  filter(model == 'lm_mios_regard', id == 'Apparent') %>%
  select(id, model, mediation, .fitted, mios_total) %>% 
  rename(Predicted = .fitted, Observed = mios_total) %>%
  mutate(
    model = ifelse(model == 'lm_mios_regard', "Moral Injury ~ Regard", model
  )) %>% 
  pivot_longer(-c(id, model, mediation)) %>% 
  ggplot(aes(value, fill = name)) +
  geom_density(alpha = .5) +
  facet_wrap(vars(model)) +
  viridis::scale_fill_viridis(discrete = TRUE) +
  labs(fill = '', y = '', x  = "Value") + 
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

(density_inter + density_mios_inter) /
  (density_regard + density_mios_regard) +
  patchwork::plot_annotation(title = 'Predicted vs. Observed Values') +
  patchwork::plot_layout(guides = 'collect') &
  theme(legend.position = 'bottom')




## Save
ggsave(filename = 'plot-predicted-vs-observed.pdf', 
       path = here::here('output/figures'),
       bg = "transparent", width = 6, height = 4, dpi = 300)




