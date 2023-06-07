

# mediation
## optional implementations packages: bmem, plspm, lavaan, mediation, mma

## draw dags

# Is moral injury's negative effect on reintegration mediated by private regard


# lavaan ------------------------------------------------------------------
data_mediation <- 
  data %>% 
  select(mios_total, mcarm_total, wis_private_regard_total)

model <- ' # direct effect
              mcarm_total ~ c*mios_total
           # mediator
             wis_private_regard_total ~ a*mios_total
             mcarm_total ~ b*wis_private_regard_total
           # indirect effect (a*b)
             ab := a*b
           # total effect
             total := c + (a*b)
         '
fit <- lavaan::sem(model, data = data_mediation)
summary(fit)



# mediate -----------------------------------------------------------------

# Example 1: Linear Outcome and Mediator Models
####################################################
b <- lm(mcarm_total ~ mios_total, data = data)
c <- lm(mcarm_total ~ mios_total + wis_private_regard_total, data = data)

# Estimation via quasi-Bayesian approximation
contcont <- mediation::mediate(b, c, sims=50, treat="mios_total", mediator="wis_private_regard_total")
summary(contcont)
plot(contcont)





# Example -------------------------------------------------------------------------

C1 <- rnorm(10000)                    # Generate first random confounder
X  <- rbinom(10000, 1, plogis(.8*C1)) # Generate random tx variable as a function of C1
C2 <- rnorm(10000, .8*X)              # Generate second confounder as function of tx
M  <- rnorm(10000, .8*X + .8*C2)      # Generate mediator as function of tx and second confounder
Y  <- rnorm(10000, .8*X + .8*M + .8*C1 + .8*C2) # Model outcome
tbl <- tibble(
  C1 = C1,
  C2 = C2,
  X = X,
  M = M,
  Y = Y) 

mod_y <- lm(Y ~ X*M + C1 + C2, data = tbl) %>% 
  broom::tidy() %>% 
  mutate_if(is.numeric, ~round(.x, 3)) %>% 
  mutate(p.value = if_else(
    p.value < 0.001,
    true  = "< 0.001", 
    false = as.character(round(p.value, 3))))

mod_m <- lm(M ~ X + C2, data = tbl) %>% 
  broom::tidy() %>% 
  mutate_if(is.numeric, ~round(.x, 3)) %>% 
  mutate(p.value = if_else(
    p.value < 0.001,
    true  = "< 0.001", 
    false = as.character(round(p.value, 3))))

mod_y
mod_m


# Mediation Model ---------------------------------------------------------
data_mediation <- 
  data %>% 
  select((ends_with('total') | ends_with('mean')) & !c('irvTotal'))




# Model -------------------------------------------------------------------



mod_y <- lm(mcarm_total ~ mios_total * wis_private_total + C1 + C2, data = tbl) %>% 
  broom::tidy() %>% 
  mutate_if(is.numeric, ~round(.x, 3)) %>% 
  mutate(p.value = if_else(
    p.value < 0.001,
    true  = "< 0.001", 
    false = as.character(round(p.value, 3))))

mod_m <- lm(wis_private_total ~ mios_total + C2, data = tbl) %>% 
  broom::tidy() %>% 
  mutate_if(is.numeric, ~round(.x, 3)) %>% 
  mutate(p.value = if_else(
    p.value < 0.001,
    true  = "< 0.001", 
    false = as.character(round(p.value, 3))))

mod_y
mod_m








# -------------------------------------------------------------------------

x <- rnorm(n = 1e5, mean = 3, sd = .5)
y <- rnorm(n = 1e5, mean = 150, sd = 10) + .2 * x

cor.test(x, y, method = 'pearson')

lm(y ~ 1 + x) %>% 
  summary() %>% 
  broom::tidy()








