 # population data



data_population <- readxl::read_xlsx(here::here('data/processed/acs2021-demographics.xlsx'))


# Population Data ---------------------------------------------------------
veteran_status_population = 
  data_population %>% 
  filter(variable == 'population') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, source))

service_period_population = 
  data_population %>% 
  filter(variable == 'period_of_service') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, veteran, source))

income_population = 
  data_population %>% 
  filter(variable == 'income') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, veteran, source))

poverty_population = 
  data_population %>% 
  filter(variable == 'poverty') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, veteran, source))

education_population =
  data_population %>% 
  filter(variable == 'education') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, veteran, source))

data_population %>% 
  filter(variable == 'sex') %>% 
  mutate(population_percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, veteran, source)) %>% select(!c(category, population_estimate))

data_population %>% 
  filter(variable == 'race' & category != 'White alone') %>% 
  mutate(population_percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, source)) %>% 
  filter(category != 'Native Hawaiian and Other Pacific Islander alone') %>%
  arrange(desc(population_percent)) %>% select(!c(category, population_estimate, veteran))

data_population %>% 
  filter(variable == 'disability') %>% 
  mutate(population_percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, veteran, source, population_estimate)) %>% 
  arrange(desc(population_percent)) %>% 
  select(category, everything(), !disability)


data_population %>% 
  filter(variable == 'age') %>% 
  mutate(population_percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, variable, veteran, source)) %>% 
  select(category, !c(group, population_estimate))

