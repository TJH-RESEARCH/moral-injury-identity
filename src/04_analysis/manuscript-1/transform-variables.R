

## Plot Pairs
data %>% 
  mutate(highest_rank = as.numeric(highest_rank),
         sex = as.numeric(sex),
         bipf_total_sq = sqrt(bipf_total),
         bipf_total_2 = bipf_total^2,
         bipf_total_inv = exp(bipf_total),
         mios_total_sq = sqrt(mios_total),
         mios_total_log2 = log((mios_total + 1), base = 2),
         mios_total_reflect_log = log((max(mios_total) + 1) - mios_total)
  )