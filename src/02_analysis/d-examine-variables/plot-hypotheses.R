

plot_regression_dissonance <-
  data %>% 
    ggplot(aes(x = mios_total, 
               y = biis_conflict)) +
    geom_point(alpha = .5, size = 2) +
    scale_color_continuous(type = 'viridis') +
    geom_smooth(method = 'lm', se = F, color = 'black') +
    labs(title = 'Moral Injury and Identity Dissonance',
         subtitle = 'Bivariate Regression Line') +
    xlab('Moral Injury Symptoms') +
    ylab('Identity Dissonance') +
    theme_classic()

plot_regression_dissonance %>% print()

ggsave(plot = plot_regression_dissonance,
       filename = here::here('output/figures/regression-dissonance.jpg'))


# -------------------------------------------------------------------------
plot_regression_attachment <-
  data %>% 
    ggplot(aes(x = mios_total, 
               y = wis_interdependent_total)) +
    geom_point(alpha = .5, size = 2) +
    scale_color_continuous(type = 'viridis') +
    geom_smooth(method = 'lm', se = F, color = 'black') +
    labs(title = 'Moral Injury and Identity Attachment',
         subtitle = 'Bivariate Regression Line') +
    xlab('Moral Injury Symptoms') +
    ylab('Identity Attachment') +
    theme_classic()

plot_regression_attachment %>% print()

ggsave(plot = plot_regression_attachment,
       filename = here::here('output/figures/regression-attachment.jpg'))
