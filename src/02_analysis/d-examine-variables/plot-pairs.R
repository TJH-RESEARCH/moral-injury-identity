


# Main Variables: Pair Plots --------------------------------------------------------------


plot_pairs <-
  data %>% 
  select(mios_total, 
         wis_interdependent_total,
         wis_public_regard_total,
         biis_conflict) %>% 
  rename(
    `Moral Injury` = mios_total, 
    `Attachment` = wis_interdependent_total,
    `Public Regard` = wis_public_regard_total,
    `Identity Dissonance` = biis_conflict
  ) %>% 
  GGally::ggpairs(
    title = 'Pair Plots: Moral Injury, Attachment, Identity Dissonance')

plot_pairs %>% print()

ggsave(plot = plot_pairs,
       filename = here::here('output/figures/pairs-main.jpg'))

