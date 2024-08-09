

#Bayesian MANOVA

library(brms)
options(brms.backend = "cmdstanr")

#install.packages("cmdstanr", repos = c("https://stan-dev.r-universe.dev", getOption("repos")))

library(cmdstanr)
cmdstanr::set_cmdstan_path('~/cmdstan/')
library(tidybayes)



# Correlation ---------------------------------------------------------------
model_correlation <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      brms::mvbind(biis_conflict,
                   mios_total
                   )  ~ 1
    ) + set_rescor(TRUE),
    cores = 4)

model_correlation %>% print(digits = 3)
model_correlation %>% posterior_summary()


# Model Bivariate ---------------------------------------------------------

model_bivariate_1 <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      biis_conflict ~ 1 + mios_total
    ),
    cores = 4)

model_bivariate_1 %>% print(digits = 3)
model_bivariate_1 %>% posterior_summary()



# Model Bivariate ---------------------------------------------------------
## Super-vague but proper prior: normal(0, 1e6)
model_bivariate_2 <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      biis_conflict ~ 1 + mios_total
    ), set_prior("normal(0,1e6)", class = "b", coef = "mios_total"),
    cores = 4)

model_bivariate_2 %>% print(digits = 3)
model_bivariate_2 %>% posterior_summary()



# Model Bivariate ---------------------------------------------------------
## Weakly informative prior, very weak: normal(0, 10);
model_bivariate_3 <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      biis_conflict ~ 1 + mios_total
    ), set_prior("normal(0,10)", class = "b", coef = "mios_total"),
    cores = 4)

model_bivariate_3 %>% print(digits = 3)
model_bivariate_3 %>% posterior_summary()




# Model Bivariate ---------------------------------------------------------
## Generic weakly informative prior: normal(0, 1);
model_bivariate_4 <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      biis_conflict ~ 1 + mios_total
    ), set_prior("normal(0,1)", class = "b", coef = "mios_total"),
    cores = 4)

model_bivariate_4 %>% print(digits = 3)
model_bivariate_4 %>% posterior_summary()



# SCALE -------------------------------------------------------------------
data <-
  data %>% mutate(mios_total_z = scale(mios_total)[,1],
                biis_conflict_z = scale(biis_conflict)[,1])

## Generic weakly informative prior: normal(0, 1);
model_bivariate_z <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      biis_conflict_z ~ 1 + mios_total_z
    ), set_prior("normal(0,1)", class = "b", coef = "mios_total_z"),
    cores = 4)

model_bivariate_z %>% print(digits = 3)
model_bivariate_z %>% posterior_summary()
model_bivariate_z %>% plot()
model_bivariate_z %>% brms::conditional_effects()
pp_check(model_bivariate_z, resp = "mios_total_z", ndraws = 100)
model_bivariate_z %>% brms::bayes_R2()


draws <- model_bivariate_z %>% brms::as_draws() %>% tidybayes::tidy_draws()

# View the R-squared
model_bivariate_z %>% 
  bayes_R2(summary = F) %>% 
  data.frame() %>% 
  pivot_longer(everything()) %>% 
  mutate(name = str_remove(name, "R2")) %>% 
  
  ggplot(aes(x = value, color = name, fill = name)) +
  geom_density(alpha = .5) +
  ggthemes::scale_color_ptol() +
  ggthemes::scale_fill_ptol() +
  scale_x_continuous(NULL, limits = 0:1) +
  scale_y_continuous(NULL, breaks = NULL) +
  labs(title = expression(The~italic(R)^2*" distribution"),
       subtitle = "") +
  theme_minimal() +
  theme(legend.title = element_blank())

# Half Eye Plot
draws %>% 
  ggplot(aes(x = b_mios_total_z)) +
  ylab('beta') +
  stat_halfeye()

# Point summaries and intervals of the posterior
## highest posterior density interval (HPDI). the narrowest interval containing the specified probability mass 

bind_rows(
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::mean_qi(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::median_qi(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::mode_qi(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::mean_hdi(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::median_hdi(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::mode_hdi(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::mean_hdci(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::median_hdci(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::mode_hdci(value),
  
  draws %>% 
    pivot_longer(b_mios_total_z) %>% 
    group_by(name) %>% 
    tidybayes::mean_hd(value),
  
  
)

    





# Model Bivariate ---------------------------------------------------------
## Strong prior toward null hypo
model_bivariate_null <- 
  brms::brm(
    data = data, 
    family = gaussian,
    brms::bf(
      biis_conflict ~ 1 + mios_total
    ), set_prior("normal(0,.1)", class = "b", coef = "mio_total"),
    cores = 4)

model_bivariate_null %>% print(digits = 3)
model_bivariate_null %>% posterior_summary()
