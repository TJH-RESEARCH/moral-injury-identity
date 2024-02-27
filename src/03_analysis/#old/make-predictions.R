
if(!exists('model_1')) source(here::here('src/03_analysis/4-hypothesis-1.R'))

mios_quantiles <- as.numeric(quantile(data$mios_total))

percentile_m2cq <- function(x){
  x = as.numeric(x)
  data %>% select(m2cq_mean) %>% arrange(m2cq_mean) %>% 
    mutate(count = row_number(), percentile = count / nrow(.)) %>% 
    filter(m2cq_mean >= x) %>% 
    head(n = 1) %>% 
    select(percentile) %>% 
    mutate(percentile = round(percentile * 100, 0))
}

data %>% 
  select(m2cq_mean) %>% 
  arrange(m2cq_mean) %>% 
  mutate(count = row_number(), 
         percentile = count / nrow(.)) %>% 
  print(n = 212)

predictions <- 
  tribble(
  ~name,              ~predicted_m2cq, 
  'no_symptoms',        coef(model_3)[1] + (mios_quantiles[1] * coef(model_3)[2]),
  'low_symptoms',       coef(model_3)[1] + (mios_quantiles[2] * coef(model_3)[2]),
  'medium_symptoms',    coef(model_3)[1] + (mios_quantiles[3] * coef(model_3)[2]),
  'high_symptoms',      coef(model_3)[1] + (mios_quantiles[4] * coef(model_3)[2]),
  'very_high_symptoms', coef(model_3)[1] + (mios_quantiles[5] * coef(model_3)[2])
) 

predictions <-
  predictions %>% 
  mutate(
    percentile_mios = c(18, 25, 50, 75, 100),
    ratio_no_symptoms = predicted_m2cq / c(.455),
    percentile_m2cq = 
           c(as.numeric(percentile_m2cq(predictions[1,2])),
             as.numeric(percentile_m2cq(predictions[2,2])), 
             as.numeric(percentile_m2cq(predictions[3,2])),
             as.numeric(percentile_m2cq(predictions[4,2])),
             as.numeric(percentile_m2cq(predictions[5,2]))
           ),
     m2cq_category = 
      case_when(
                predicted_m2cq >= 4 ~ 'Extreme difficulty',
                predicted_m2cq >= 3 ~ 'A lot of difficulty',
                predicted_m2cq >= 2 ~ 'Some difficulty',
                predicted_m2cq >= 1 ~ 'A little difficulty',
                predicted_m2cq <  1 ~ 'No difficulty')
) %>% 
  select(name, percentile_mios, percentile_m2cq, predicted_m2cq, everything())

## Print
predictions %>% print()

## Clean up
rm(predictions)

