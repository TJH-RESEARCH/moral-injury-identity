
# Remove outliers


# Filter Multivariate Outliers -----------------------------------------------------

## More than four standard deviations above Mahalonbis distance mean

data <-
  data %>%
    select(civilian_commit_total,
           wis_total,
           mios_total,
           biis_blendedness,
           biis_harmony,
           mcarm_total) %>%
    psych::outlier(plot = F) %>% 
    tibble() %>% 
    rename(mahad = 1) %>% 
    bind_cols(data) %>% 
    arrange(desc(mahad)) %>% 
    filter(mahad < mean(mahad) + (4 * sd(mahad)))

