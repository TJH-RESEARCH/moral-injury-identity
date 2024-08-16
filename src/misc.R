


summary_paths_boot <-
  paths_boot %>% 
  select(c(id, mediation, path, estimate, std.error)) %>% 
  pivot_wider(names_from = path, values_from = c(estimate, std.error)) %>%
  group_by(mediation) %>% 
  summarise(across(where(is.numeric), ~ mean(.x))) %>% 
  mutate(
    t_a = estimate_a / std.error_a,
    t_b = estimate_b / std.error_b,
    p_z_a = pt(q = t_a, df = Inf, lower.tail = FALSE),
    p_z_b = pt(q = t_b, df = Inf, lower.tail = FALSE),
    estimate_ab = estimate_a * estimate_b,
    estimate_c = estimate_c_prime + estimate_ab,
    sobel_std.error_ab = sqrt(estimate_a ^ 2 * std.error_b ^ 2 + estimate_b ^ 2 * std.error_a ^ 2),
    sobel_t_ab = abs(estimate_ab / sobel_std.error_ab),
    sobel_p_z_ab = pt(q = sobel_t_ab, df = Inf, lower.tail = FALSE)
  )




summary_paths_boot %>% pivot_longer(-mediation) %>% print(n = 50)


summary_paths_boot %>% select(mediation, contains('_a')) %>% select(-c(estimate_ab, sobel_std.error_ab))
summary_paths_boot %>% select(mediation, contains('_b'))
summary_paths_boot %>% select(mediation, contains('_c_prime'))
summary_paths_boot %>% select(mediation, contains('_ab'))

