

# How are identity loss and identity dissonance realted?

## Loess Line
data %>% 
  ggplot(aes(
    wis_interdependent_total, 
    biis_conflict
  )) + geom_point() +
  geom_smooth()

## OLS Line
data %>% 
  ggplot(aes(
    wis_interdependent_total, 
    biis_conflict
  )) + geom_point() +
  geom_smooth(method = 'lm')


# Add moral injury in the 3rd dimension (color, size)
data %>% 
  ggplot(aes(
    wis_interdependent_total, 
    biis_conflict, 
    color = mios_total,
    size = mios_total
  )) + geom_point()

## interesting. hard to see, 
## but MI and greater Identity Dissonance seem related.
## Not as obviously for Identity Loss
