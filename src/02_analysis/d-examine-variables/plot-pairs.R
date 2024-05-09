


# Main Variables: Pair Plots --------------------------------------------------------------


plot_pairs <-
  data %>% 
  select(mios_total, 
         wis_interdependent_total,
         wis_public_regard_total,
         wis_private_regard_total, 
         biis_conflict) %>% 
  GGally::ggpairs(title = 'Pair Plots: Moral Injury, Connection, Dissonance')

plot_pairs %>% print()

ggsave(plot = plot_pairs,
       filename = here::here('output/figures/pairs-main.jpg'))


# Trauma  ----------------------------------------------
plot_pairs_trauma <- 
  data %>% 
  mutate(mios_screener = as.factor(mios_screener), 
         pc_ptsd_positive_screen = as.factor(pc_ptsd_positive_screen)) %>% 
  select(mios_total, mios_screener, pc_ptsd_positive_screen) %>% 
  GGally::ggpairs(title = 'Pair Plots: Moral Injury, PTSD, and Traumatic Experiences')

plot_pairs_trauma %>% print()

ggsave(plot = plot_pairs_trauma,
       filename = here::here('output/figures/pairs-trauma.jpg'))


rm(plot_pairs_trauma, plot_pairs_outcomes)


