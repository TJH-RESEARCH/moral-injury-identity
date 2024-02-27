

data %>% 
  ggplot(aes(x = mios_total, 
             y = biis_conflict)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)


data %>% 
  ggplot(aes(x = mios_total, 
             y = wis_interdependent_total)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)


data %>% 
  ggplot(aes(x = wis_interdependent_total, 
             y = biis_conflict)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)



# Remove Non-MI Event Exposure -----------------------------------------------------
data %>% 
  filter(mios_screener == 1) %>% 
  ggplot(aes(x = mios_total, 
             y = biis_conflict)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)

# Just no MI events -----------------------------------------------------
data %>% 
  filter(mios_screener == 0) %>% 
  ggplot(aes(x = mios_total, 
             y = biis_conflict)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)


# Sqrt Transformation -----------------------------------------------------
data %>% 
  mutate(mios_total = sqrt(mios_total)) %>% 
  ggplot(aes(x = mios_total, 
             y = biis_conflict)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)



# Visualize Interaction -----------------------------------------------------
data %>% 
  mutate(wis_interdependent_group =
              factor(
                cut(wis_interdependent_total, breaks = c(7, 14, 21, 29)),
                ordered = T,
                labels = c('low', 'medium', 'high')
                  )
  ) %>% 
ggplot(aes(x = mios_total, 
             y = biis_conflict,
             color = wis_interdependent_group,
             shape = wis_interdependent_group)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)


# Visualize Interaction: LOESS --------------------------------------------

data %>% 
  mutate(wis_interdependent_group =
           factor(
             cut(wis_interdependent_total, breaks = c(7, 14, 21, 29)),
             ordered = T,
             labels = c('low', 'medium', 'high')
           )
  ) %>% 
  ggplot(aes(x = mios_total, 
             y = biis_conflict,
             color = wis_interdependent_group,
             shape = wis_interdependent_group)) +
  geom_point() +
  geom_smooth(method = 'loess', se = F)

