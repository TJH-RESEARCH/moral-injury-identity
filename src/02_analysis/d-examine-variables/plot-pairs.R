


# Main Variables: Pair Plots --------------------------------------------------------------


plot_pairs <-
  data %>% 
  select(mios_total, 
         wis_interdependent_total,
         wis_private_regard_total,
         mios_screener,
         mios_criterion_a,
         pc_ptsd_positive_screen) %>% 
  mutate(pc_ptsd_positive_screen = factor(pc_ptsd_positive_screen),
         mios_criterion_a = factor(mios_criterion_a),
         mios_screener = factor(mios_screener)) %>% 
  rename(
    `Moral Injury Symptoms` = mios_total, 
    `Interdependence` = wis_interdependent_total,
    `Private Regard` = wis_private_regard_total,
    `Moral Injury Event` = mios_screener,
    `Criterion A Event` = mios_criterion_a,
    `Probable PTSD` = pc_ptsd_positive_screen
  ) %>% 
  GGally::ggpairs(
    title = 'Pair Plots')

plot_pairs %>% print()

ggsave(plot = plot_pairs,
       filename = here::here('output/figures/pairs-main.jpg'))

