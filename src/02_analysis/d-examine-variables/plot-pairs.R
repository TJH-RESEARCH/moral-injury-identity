


# Main Variables: Pair Plots --------------------------------------------------------------


plot_pairs <-
  data %>% 
  select(mios_total, 
         wis_interdependent_total,
         wis_public_regard_total,
         biis_conflict) %>% 
  GGally::ggpairs(title = 'Pair Plots: Moral Injury, Connection, Dissonance')

plot_pairs %>% print()

ggsave(plot = plot_pairs,
       filename = here::here('output/figures/pairs-main.jpg'))

