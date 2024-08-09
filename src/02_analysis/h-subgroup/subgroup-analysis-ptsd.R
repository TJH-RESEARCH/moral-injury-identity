
data %>% count(pc_ptsd_positive_screen)

# MODELS
# model_biis_1               <- lm(biis_conflict ~ mios_total, data)
# model_biis_interact_1      <- lm(biis_conflict ~ mios_total * wis_public_regard_total, data)
# model_wis_interdependent_1 <- lm(wis_interdependent_total ~ mios_total, data)

# ---------------------------------------------------------------ee----------
data %>% 
  filter(pc_ptsd_positive_screen == 1) %>% 
  lm(biis_conflict ~ mios_total, .) %>% 
  summary()

data %>% 
  filter(pc_ptsd_positive_screen == 0) %>% 
  lm(biis_conflict ~ mios_total, .) %>% 
  summary()


data %>% 
  ggplot(
    aes(
      x = mios_total, 
      y = biis_conflict, 
      group = factor(pc_ptsd_positive_screen), 
      color = factor(pc_ptsd_positive_screen)
      )
    ) +
  geom_smooth(formula = 'y ~ x', 
              se = F, 
              method = 'lm')


# -------------------------------------------------------------------------
data %>% 
  filter(pc_ptsd_positive_screen == 1) %>% 
  lm(biis_conflict ~ mios_total * wis_public_regard_total, .) %>% 
  summary()

data %>% 
  filter(pc_ptsd_positive_screen == 0) %>% 
  lm(biis_conflict ~ mios_total * wis_public_regard_total, .) %>% 
  summary()

data %>% 
  ggplot(
    aes(
      x = (mios_total * wis_public_regard_total), 
      y = biis_conflict, 
      group = factor(pc_ptsd_positive_screen), 
      color = factor(pc_ptsd_positive_screen)
      )
    ) +
  geom_smooth(formula = 'y ~ x', 
              se = F, 
              method = 'lm')



# -------------------------------------------------------------------------
data %>% 
  filter(pc_ptsd_positive_screen == 1) %>% 
  lm(wis_interdependent_total ~ mios_total, .) %>% 
  summary()

data %>% 
  filter(pc_ptsd_positive_screen == 0) %>% 
  lm(wis_interdependent_total ~ mios_total, .) %>% 
  summary()

data %>% 
  ggplot(
    aes(x = mios_total, 
        y = wis_interdependent_total, 
        group = factor(pc_ptsd_positive_screen), 
        color = factor(pc_ptsd_positive_screen)
        )
    ) +
  geom_smooth(formula = 'y ~ x', 
              se = F, 
              method = 'lm')


# Investigate: Why Combat and Identity Attachment? ------------------------
data %>% 
  group_by(pc_ptsd_positive_screen) %>% 
  summarize(mean_attachment = mean(wis_interdependent_total), 
            sd_attachment = sd(wis_interdependent_total))

## Density
data %>% 
  ggplot(
    aes(x = wis_interdependent_total, 
        group = factor(pc_ptsd_positive_screen),
        fill = factor(pc_ptsd_positive_screen)
        )
    ) +
  geom_density(alpha = .4)

## Histogram
data %>% 
  ggplot(
    aes(x = wis_interdependent_total, 
        group = factor(pc_ptsd_positive_screen),
        fill = factor(pc_ptsd_positive_screen)
        )
    ) +
  facet_wrap(~factor(pc_ptsd_positive_screen)) +
  geom_histogram(alpha = .4, bins = 10)



