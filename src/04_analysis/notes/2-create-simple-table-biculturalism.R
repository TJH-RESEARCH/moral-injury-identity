### Military-Civilian Biculturalism?: 
### Bicultural Identity and the Adjustment of Separated Service Members

# Make some simple tables and graphs


# Average MI symptom score by MI event yes/no screener

## Centrality
data %>% 
  mutate(wis_centrality_high = ifelse(wis_centrality_total > mean(wis_centrality_total), 1, 0)) %>% 
   group_by(wis_centrality_high) %>% 
  summarise(wis_centrality_high = mean(wis_centrality_high),
            blendedness_mean = mean(biis_blendedness),
            harmony_mean = mean(biis_harmony),
            blendedness_sd = sd(biis_blendedness),
            harmony_sd = sd(biis_harmony)) %>% 
  pivot_longer(wis_centrality_high) %>% 
  bind_rows(
 
## Connection
data %>% 
  mutate(wis_connection_high = ifelse(wis_connection_total > mean(wis_connection_total), 1, 0)) %>% 
  group_by(wis_connection_high) %>% 
  summarise(wis_connection_high = mean(wis_connection_high),
            blendedness_mean = mean(biis_blendedness),
            harmony_mean = mean(biis_harmony),
            blendedness_sd = sd(biis_blendedness),
            harmony_sd = sd(biis_harmony)) %>% 
  pivot_longer(wis_connection_high)
) %>% bind_rows(


## Family
data %>% 
  mutate(wis_family_high = ifelse(wis_family_total > mean(wis_family_total), 1, 0)) %>% 
  group_by(wis_family_high) %>% 
  summarise(wis_family_high = mean(wis_family_high),
            blendedness_mean = mean(biis_blendedness),
            harmony_mean = mean(biis_harmony),
            blendedness_sd = sd(biis_blendedness),
            harmony_sd = sd(biis_harmony)) %>% 
  pivot_longer(wis_family_high)
) %>% bind_rows(
  
## Interdependent
data %>% 
  mutate(wis_interdependent_high = ifelse(wis_interdependent_total > mean(wis_interdependent_total), 1, 0)) %>% 
  group_by(wis_interdependent_high) %>% 
  summarise(wis_interdependent_high = mean(wis_interdependent_high),
            blendedness_mean = mean(biis_blendedness),
            harmony_mean = mean(biis_harmony),
            blendedness_sd = sd(biis_blendedness),
            harmony_sd = sd(biis_harmony)) %>% 
  pivot_longer(wis_interdependent_high)
) %>% bind_rows(
  
## Private
data %>% 
  mutate(wis_private_high = ifelse(wis_private_regard_total > mean(wis_private_regard_total), 1, 0)) %>%
  group_by(wis_private_high) %>% 
  summarise(wis_private_high = mean(wis_private_high),
            blendedness_mean = mean(biis_blendedness),
            harmony_mean = mean(biis_harmony),
            blendedness_sd = sd(biis_blendedness),
            harmony_sd = sd(biis_harmony)) %>% 
  pivot_longer(wis_private_high)
) %>% bind_rows(

## Public
data %>% 
  mutate(wis_public_high = ifelse(wis_public_regard_total > mean(wis_public_regard_total), 1, 0)) %>%
  group_by(wis_public_high) %>% 
  summarise(wis_public_high = mean(wis_public_high),
            blendedness_mean = mean(biis_blendedness),
            harmony_mean = mean(biis_harmony),
            blendedness_sd = sd(biis_blendedness),
            harmony_sd = sd(biis_harmony)) %>% 
  pivot_longer(wis_public_high)
) %>% bind_rows(

##  Skills
data %>% 
  mutate(wis_skills_high = ifelse(wis_private_regard_total > mean(wis_private_regard_total), 1, 0)) %>% 
  group_by(wis_skills_high) %>% 
  summarise(wis_skills_high = mean(wis_skills_high),
            blendedness_mean = mean(biis_blendedness),
            harmony_mean = mean(biis_harmony),
            blendedness_sd = sd(biis_blendedness),
            harmony_sd = sd(biis_harmony)) %>% 
  pivot_longer(wis_skills_high)
) %>% bind_rows(

## Civilian
data %>% 
  mutate(civ_high = ifelse(wis_skills_total > mean(wis_skills_total), 1, 0)) %>% 
  group_by(civ_high) %>% 
  summarise(civ_high = mean(civ_high),
            blendedness_mean = mean(biis_blendedness),
            harmony_mean = mean(biis_harmony),
            blendedness_sd = sd(biis_blendedness),
            harmony_sd = sd(biis_harmony)) %>% 
  pivot_longer(civ_high)

) %>% 
 select(name, value, everything()) %>% 
  rename(variable = name,
         var_yes = value)


            
         


# Centrality --------------------------------------------------------------
  data %>% 
    mutate(wis_centrality_high = ifelse(wis_connection_total > mean(wis_connection_total), 1, 0)) %>% 
    select(wis_centrality_high, biis_blendedness, biis_harmony) %>%
    pivot_longer(!wis_centrality_high) %>% 
    group_by(name) %>% 
    ggplot(aes(x = value, 
               group = factor(wis_centrality_high), 
               color = factor(wis_centrality_high))) + 
    geom_density() +
    facet_grid(~factor(name))
  

# Connection --------------------------------------------------------------
data %>% 
  mutate(wis_connection_high = ifelse(wis_connection_total > mean(wis_connection_total), 1, 0)) %>% 
  select(wis_connection_high, biis_blendedness, biis_harmony) %>%
  pivot_longer(!wis_connection_high) %>% 
  group_by(name) %>% 
  ggplot(aes(x = value, 
             group = factor(wis_connection_high), 
             color = factor(wis_connection_high))) + 
  geom_density() +
  facet_grid(~factor(name))
  
  
# Family --------------------------------------------------------------
data %>% 
  mutate(wis_family_high = ifelse(wis_family_total > mean(wis_family_total), 1, 0)) %>% 
  select(wis_family_high, biis_blendedness, biis_harmony) %>%
  pivot_longer(!wis_family_high) %>% 
  group_by(name) %>% 
  ggplot(aes(x = value, 
             group = factor(wis_family_high), 
             color = factor(wis_family_high))) + 
  geom_density() +
  facet_grid(~factor(name))
  
# Interdependent --------------------------------------------------------------
data %>% 
  `mutate(wis_interdependent_high = ifelse(wis_interdependent_total > mean(wis_interdependent_total), 1, 0)) %>% 
  select(wis_interdependent_high, biis_blendedness, biis_harmony) %>%
  pivot_longer(!wis_interdependent_high) %>% 
  group_by(name) %>% 
  ggplot(aes(x = value, 
             group = factor(wis_interdependent_high), 
             color = factor(wis_interdependent_high))) + 
  geom_density() +
  facet_grid(~factor(name))

# Private Regard --------------------------------------------------------------
data %>% 
  mutate(wis_private_high = ifelse(wis_private_regard_total > mean(wis_private_regard_total), 1, 0)) %>% 
  select(wis_private_high, biis_blendedness, biis_harmony) %>%
  pivot_longer(!wis_private_high) %>% 
  group_by(name) %>% 
  ggplot(aes(x = value, 
             group = factor(wis_private_high), 
             color = factor(wis_private_high))) + 
  geom_density() +
  facet_grid(~factor(name))

# Public Regard --------------------------------------------------------------
data %>% 
  mutate(wis_public_high = ifelse(wis_public_regard_total > mean(wis_public_regard_total), 1, 0)) %>% 
  select(wis_public_high, biis_blendedness, biis_harmony) %>%
  pivot_longer(!wis_public_high) %>% 
  group_by(name) %>% 
  ggplot(aes(x = value, 
             group = factor(wis_public_high), 
             color = factor(wis_public_high))) + 
  geom_density() +
  facet_grid(~factor(name))
  
  
# Skills --------------------------------------------------------------
data %>% 
  mutate(wis_skills_high = ifelse(wis_private_regard_total > mean(wis_private_regard_total), 1, 0)) %>% 
  select(wis_skills_high, biis_blendedness, biis_harmony) %>%
  pivot_longer(!wis_skills_high) %>% 
  group_by(name) %>% 
  ggplot(aes(x = value, 
             group = factor(wis_skills_high), 
             color = factor(wis_skills_high))) + 
  geom_density() +
  facet_grid(~factor(name))

  
# Civilian ID --------------------------------------------------------------
data %>% 
  mutate(civ_high = ifelse(wis_skills_total > mean(wis_skills_total), 1, 0)) %>% 
  select(civ_high, biis_blendedness, biiSet down at 8 AM. Careful careful careful.s_harmony) %>%
  pivot_longer(!civ_high) %>% 
  group_by(name) %>% 
  ggplot(aes(x = value, 
             group = factor(civ_high), 
             color = factor(civ_high))) + 
  geom_density() +
  facet_grid(~factor(name))
