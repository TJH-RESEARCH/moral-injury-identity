

library(tidyverse)
library(mediation)

model_outcome <- 
  data %>% 
     lm(
        # Outcome:
        mcarm_total ~ 
          
        # Treatment:
        mios_total + 
          
        # Mediators:
        wis_private_regard_total +
        wis_interdependent_total + 
        wis_connection_total +
        wis_skills_total +
        wis_centrality_total +
        wis_public_regard_total +
        wis_family_total + 
            
        # Adjusted for:
        unmet_needs_total +
        mios_ptsd_symptoms_total + 
        military_family_total + 
        years_separation +
        years_service +
        highest_rank, 
      .)


model_outcome %>% summary()

# -------------------------------------------------------------------------







library(bayestestR)
library(broom)
library(brms)
library(rstanarm)
library(bayestestR)
library(insight)

# Read the data ------------------------------------------------------------
#data <- readr::read_csv(here::here('data/processed/data-cleaned.csv'))


# Specify the Mediation Model ---------------------------------------------

model_mediator_1 <- 
  data %>% 
    lm(wis_public_regard_total ~ 
         mios_total + 
         years_separation + 
         mios_ptsd_symptoms_total, 
       data = .)

model_outcome <- 
  data %>% 
    lm(mcarm_total ~ 
         wis_public_regard_total + 
         mios_total + 
         mios_ptsd_symptoms_total +
         years_separation,
       data = .)

output_mediation <- 
  mediation::mediate(model_mediator_1, 
                      model_outcome, 
                      treat = "mios_total", 
                      mediator = "wis_public_regard_total", 
                      robustSE = TRUE,
                      boot = TRUE,
                      sims = 1000)

tidy(output_mediation)
output_mediation %>% summary() %>% broom::tidy()
output_mediation %>% plot()


# Specify the Moderated Mediation Model ---------------------------------------------

model_mediator_1 <- 
  data %>% 
  lm(wis_public_regard_total ~ 
       mios_total * 
       mios_ptsd_symptoms_total + 
       years_separation, 
     data = .)

model_outcome <- 
  data %>% 
  lm(mcarm_total ~ 
       wis_public_regard_total + 
       mios_total * 
       mios_ptsd_symptoms_total +
       years_separation,
     data = .)

output_mediation <- 
  mediation::mediate(model_mediator_1, 
                     model_outcome, 
                     treat = "mios_total", 
                     mediator = "wis_public_regard_total", 
                     covariates = "mios_ptsd_symptoms_total",
                     boot = TRUE,
                     sims = 1000)


mediation::test.modmed(output_mediation, 
                       covariates.1 = list(mios_ptsd_symptoms_total = 0),
                       covariates.2 = list(mios_ptsd_symptoms_total = 7), 
                       sims = 1000)


output_mediation %>% summary()
output_mediation %>% plot()


# Event model -------------------------------------------------------------



model_mediator_1 <- 
  data %>% 
  lm(wis_public_regard_total ~ 
       mios_total * 
       mios_ptsd_symptoms_total + 
       years_separation, 
     data = .)

model_outcome <- 
  data %>% 
  lm(mcarm_total ~ 
       wis_public_regard_total + 
       mios_total * 
       mios_ptsd_symptoms_total +
       years_separation,
     data = .)

output_mediation <- 
  mediation::mediate(model_mediator_1, 
                     model_outcome, 
                     treat = "mios_total", 
                     mediator = "wis_public_regard_total", 
                     covariates = "mios_ptsd_symptoms_total",
                     boot = TRUE,
                     sims = 1000)


# lavaan ------------------------------------------------------------------



model <- ' # direct effect
             mcarm_total ~ c * mios_total
           # mediator
             wis_public_regard_total ~ a * mios_total
             mcarm_total ~ b * wis_public_regard_total
           # indirect effect (a*b)
             ab := a * b
           # total effect
             total := c + (a * b)
         '
sem(model, data) %>% summary()



# Bayesian ----------------------------------------------------------------

# Fit Bayesian mediation model in brms
f1 <- brms::bf(wis_public_regard_total ~ 
                 mios_total + 
                 years_separation + 
                 mios_ptsd_symptoms_total)
f2 <- brms::bf(mcarm_total ~ 
                 wis_public_regard_total + 
                 mios_total + 
                 mios_ptsd_symptoms_total +
                 years_separation)
m2 <- brms::brm(f1 + f2 + set_rescor(FALSE), data = data, cores = 4)
mediation(m2)



# Bayes -------------------------------------------------------------------


model_outcome <- 
  data %>% 
  lm(mcarm_total ~ 
       wis_public_regard_total + 
       mios_total + 
       mios_ptsd_symptoms_total +
       years_separation,
     data = .)


model <-
  data %>% 
    rstanarm::stan_glm(
      mcarm_total ~ 
       wis_public_regard_total + 
       mios_total + 
       mios_ptsd_symptoms_total +
       years_separation, data = .)

posteriors <- insight::get_parameters(model)

ggplot(posteriors, aes(x = mios_total)) +
  geom_density(fill = "orange")

mean(posteriors$mios_total)
median(posteriors$mios_total)
map_estimate(posteriors$mios_total)
range(posteriors$mios_total)
hdi(posteriors$mios_total, ci = .89)
rope_value <- 0.1 * sd(data$mios_total)
rope_range <- c(-rope_value, rope_value)
rope_range
rope(posteriors$mios_total, range = rope_range, ci = 0.89)
describe_posterior(model, test = c("p_direction", "rope", "bayesfactor"))


ggplot(posteriors, aes(x = mios_total)) +
  geom_density(fill = "orange") +
  # The mean in blue
  geom_vline(xintercept = mean(posteriors$mios_total), color = "blue", size = 1) +
  # The median in red
  geom_vline(xintercept = median(posteriors$mios_total), color = "red", size = 1) +
  # The MAP in purple
  geom_vline(xintercept = map_estimate(posteriors$mios_total), color = "purple", size = 1)


# Complex Treatment -------------------------------------------------------

data %>% names()

model_outcome <- 
  lm(mcarm_total ~ 
       trauma_type + 
       unmet_needs_total + 
       bipf_total +
       disability,
       #military_family_none,
     data = data
     )
summary(model_outcome)


# Use the Cluster Variable  -------------------------------------------------------

## The cluster is one possibility for the dependent variable. There are others. 
## 

model_mediator_1 <- 
  lm(biis_total ~
       mios_cluster + 
       unmet_needs_total + 
       disability, 
     data = data)

model_outcome <- 
  lm(mcarm_total ~ 
       biis_total +
       mios_cluster + 
       unmet_needs_total + 
       disability,
     data = data
  )

summary(model_outcome)

output_mediation <- 
  mediation::mediate(model_mediator_1, 
                     model_outcome, 
                     treat = "mios_cluster", 
                     mediator = "biis_total", 
                     boot = TRUE,
                     sims = 1000)


output_mediation %>% summary()
output_mediation %>% plot()
