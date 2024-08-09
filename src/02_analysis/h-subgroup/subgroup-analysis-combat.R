
data %>% count(military_exp_combat)

# MODELS
# model_biis_1               <- lm(biis_conflict ~ mios_total, data)
# model_biis_interact_1      <- lm(biis_conflict ~ mios_total * wis_public_regard_total, data)
# model_wis_interdependent_1 <- lm(wis_interdependent_total ~ mios_total, data)

# ---------------------------------------------------------------ee----------
data %>% 
  filter(military_exp_combat == 1) %>% 
  lm(biis_conflict ~ mios_total, .) %>% 
  summary()

data %>% 
  filter(military_exp_combat == 0) %>% 
  lm(biis_conflict ~ mios_total, .) %>% 
  summary()


data %>% 
  ggplot(
    aes(
      x = mios_total, 
      y = biis_conflict, 
      group = factor(military_exp_combat), 
      color = factor(military_exp_combat)
      )
    ) +
  geom_smooth(formula = 'y ~ x', 
              se = F, 
              method = 'lm')


# -------------------------------------------------------------------------
data %>% 
  filter(military_exp_combat == 1) %>% 
  lm(biis_conflict ~ mios_total * wis_public_regard_total, .) %>% 
  summary()

data %>% 
  filter(military_exp_combat == 0) %>% 
  lm(biis_conflict ~ mios_total * wis_public_regard_total, .) %>% 
  summary()

data %>% 
  ggplot(
    aes(
      x = (mios_total * wis_public_regard_total), 
      y = biis_conflict, 
      group = factor(military_exp_combat), 
      color = factor(military_exp_combat)
      )
    ) +
  geom_smooth(formula = 'y ~ x', 
              se = F, 
              method = 'lm')



# -------------------------------------------------------------------------
data %>% 
  filter(military_exp_combat == 1) %>% 
  lm(wis_interdependent_total ~ mios_total, .) %>% 
  summary()

data %>% 
  filter(military_exp_combat == 0) %>% 
  lm(wis_interdependent_total ~ mios_total, .) %>% 
  summary()

data %>% 
  ggplot(
    aes(x = mios_total, 
        y = wis_interdependent_total, 
        group = factor(military_exp_combat), 
        color = factor(military_exp_combat)
        )
    ) +
  geom_smooth(formula = 'y ~ x', 
              se = F, 
              method = 'lm')


# Investigate: Why Combat and Identity Attachment? ------------------------
data %>% 
  group_by(military_exp_combat) %>% 
  summarize(mean_attachment = mean(wis_interdependent_total), 
            sd_attachment = sd(wis_interdependent_total))

## Density
data %>% 
  ggplot(
    aes(x = wis_interdependent_total, 
        group = factor(military_exp_combat),
        fill = factor(military_exp_combat)
        )
    ) +
  geom_density(alpha = .4)

## Histogram
data %>% 
  ggplot(
    aes(x = wis_interdependent_total, 
        group = factor(military_exp_combat),
        fill = factor(military_exp_combat)
        )
    ) +
  facet_wrap(~factor(military_exp_combat)) +
  geom_histogram(alpha = .4, bins = 10)





combat_1 <- data %>% filter(military_exp_combat == 1)
combat_0 <- data %>% filter(military_exp_combat == 0)


model_ttest <- 
  t.test(combat_1$wis_interdependent_total, 
         combat_0$wis_interdependent_total,
         alternative = 'greater')



results_ttest <- tibble(
  result = c('t', 'degrees freedom', 'p', 'method', 'null value', 
             'Mean attachment (combat)',
             'Mean attachment (no combat)'
  ),
  value = c(
    round(as.numeric(model_ttest$statistic), 3),
    round(as.numeric(model_ttest$parameter), 3),
    model_ttest$p.value,
    model_ttest$method,
    round(as.numeric(model_ttest$null.value), 3),
    round(as.numeric(model_ttest$estimate)[1], 3),
    round(as.numeric(model_ttest$estimate)[2], 3)
  )
)
results_ttest %>% print()
