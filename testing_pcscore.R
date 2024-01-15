

  ifelse(data$mios_criterion_a == 1 &
           sum(data$pc_ptsd_symptoms_avoid +
           data$pc_ptsd_symptoms_guilty +
           data$pc_ptsd_symptoms_nightmares +
           data$pc_ptsd_symptoms_numb +
           data$pc_ptsd_symptoms_vigilant >= 3, na.rm = T), 1, 0) %>% sum()

  
  ifelse(data$mios_criterion_a == 1 &
           data$pc_ptsd_symptoms_avoid +
           data$pc_ptsd_symptoms_guilty +
           data$pc_ptsd_symptoms_nightmares +
           data$pc_ptsd_symptoms_numb +
           data$pc_ptsd_symptoms_vigilant >= 3, 1, 0)
  