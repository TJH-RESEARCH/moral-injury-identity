### Military-Civilian Biculturalism?: 
### Bicultural Identity and the Adjustment of Separated Service Members

# Assumptions are:
## 1. Independent observations
## 2. 
## 3. Homoscedascticity



# 1. Linearity ---------------------------------------------------------------

data %>%
  select(
    biis_blendedness,
    biis_harmony,
    mil_civ_cluster) %>%
  GGally::ggpairs()

## 2. Homogeniety of Variance and Balanced Group Size ------------------------

table_homogeniety_variance <- 
  data %>%
  select(
    biis_blendedness,
    biis_harmony, 
    mil_civ_cluster) %>% 
  group_by(mil_civ_cluster) %>% 
  summarise(n = n(), 
            mean_blendedness = mean(biis_blendedness), 
            mean_harmony = mean(biis_harmony), 
            sd_blendedness = sd(biis_blendedness), 
            sd_harmony = sd(biis_harmony)) %>% 
  mutate(
            max_sd_blendedness = max(sd_blendedness), 
            max_sd_harmony = max(sd_harmony),
            min_sd_blendedness = min(sd_blendedness), 
            min_sd_harmony = min(sd_harmony),
            min_n = min(n),
            max_n = max(n),
            ratio_sd_blendedness = max_sd_blendedness / min_sd_blendedness, 
            ratio_sd_harmony = max_sd_harmony / min_sd_harmony,
            ratio_n = max_n / min_n
            
            ) %>% select(mil_civ_cluster, n, ratio_sd_blendedness, ratio_sd_harmony, ratio_n, sd_blendedness, sd_harmony)

## Print:
table_homogeniety_variance

## Save:
table_homogeniety_variance %>% 
  write_csv('output/tables/table-homogeniety-variance.csv')
rm(table_homogeniety_variance)

## 2. Normality of DV with group ----------------------------------------------

data %>%
  select(
    biis_blendedness,
    biis_harmony, 
    mil_civ_cluster) %>% 
  pivot_longer(!mil_civ_cluster) %>% 
  ggplot(aes(value, fill = name, alpha = .7)) + 
  geom_histogram(bins = 10) +
  facet_grid(~mil_civ_cluster)

## Normality
x <- data %>%
  select(
    biis_blendedness,
    biis_harmony, 
    mil_civ_cluster) %>% 
  filter(mil_civ_cluster == 'Assimilated')
nortest::cvm.test(x$biis_blendedness)   # Non-normal
shapiro.test(x$biis_blendedness)        # Non-normal
nortest::cvm.test(x$biis_harmony)
shapiro.test(x$biis_harmony)

x <- data %>%
  select(
    biis_blendedness,
    biis_harmony, 
    mil_civ_cluster) %>% 
  filter(mil_civ_cluster == 'Marginalized')
nortest::cvm.test(x$biis_blendedness)
shapiro.test(x$biis_blendedness)
nortest::cvm.test(x$biis_harmony)       # Non-normal
shapiro.test(x$biis_harmony)            # Non-normal

x <- data %>%
  select(
    biis_blendedness,
    biis_harmony, 
    mil_civ_cluster) %>% 
  filter(mil_civ_cluster == 'Integrated')
nortest::cvm.test(x$biis_blendedness)
shapiro.test(x$biis_blendedness)
nortest::cvm.test(x$biis_harmony)
shapiro.test(x$biis_harmony)

x <- data %>%
  select(
    biis_blendedness,
    biis_harmony, 
    mil_civ_cluster) %>% 
  filter(mil_civ_cluster == 'Separated')
nortest::cvm.test(x$biis_blendedness)   # Non-normal
shapiro.test(x$biis_blendedness)        # Non-normal
nortest::cvm.test(x$biis_harmony)
shapiro.test(x$biis_harmony)            # Non-normal



# Equivariance ------------------------------------------------------------
car::leveneTest(data$biis_harmony, 
                group = data$mil_civ_cluster)

car::leveneTest(data$biis_blendedness, 
                group = data$mil_civ_cluster)



