 # population data



data_population <- readxl::read_xlsx(here::here('data/processed/acs2021-demographics.xlsx'))


population_demographics <-

  bind_rows(

# Population Data ---------------------------------------------------------

  data_population %>% 
  filter(variable == 'population') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, source)) %>% 
  filter(veteran == 1) %>% 
  select(!veteran),

## Service Period
  data_population %>% 
  filter(variable == 'period_of_service') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, veteran, source)),

## Income
  data_population %>% 
  filter(variable == 'income') %>% 
  mutate(percent = NA) %>% 
  select(!c(margin_error, veteran, source)),

## Poverty
  data_population %>% 
  filter(variable == 'poverty') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, veteran, source)),

## Education
  data_population %>% 
  filter(variable == 'education') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, veteran, source)),

## Sex
  data_population %>% 
  filter(variable == 'sex') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, veteran, source)),

## Race
  data_population %>%   
  filter(variable == 'race' & category != 'White alone') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, source)) %>% 
  filter(category != 'Native Hawaiian and Other Pacific Islander alone') %>%
  arrange(desc(percent)) %>% 
  select(!veteran),

## Disability
  data_population %>%   
  filter(variable == 'disability') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, veteran, source)) %>% 
  arrange(desc(percent)) %>% 
  select(category, everything()),

## Age
  data_population %>%   
  filter(variable == 'age') %>% 
  mutate(percent = population_estimate / sum(population_estimate) * 100) %>% 
  select(!c(margin_error, veteran, source))

) %>% 
  arrange(variable) %>% 
  mutate(percent = round(percent, digits = 2))


## Print
population_demographics %>% print(n = 50)

## Save
population_demographics %>% 
  write_csv(here::here('output/tables/population-demographics.csv'))
