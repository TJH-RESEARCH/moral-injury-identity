


# Dichotomize PTSD Symptoms -----------------------------------------------


data <-
  data %>% 
  mutate(mios_ptsd_symptoms = (mios_ptsd_symptoms_none - 1) * -1,
         mios_total_sqrt = sqrt(mios_total))

