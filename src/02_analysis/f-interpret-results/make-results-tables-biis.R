
# -----------1--------------------------------------------------------------
source(here::here('src/01_config/functions/function-append-results.R'))


table <- 
  texreg::texreg(
    list(
      coeftest_biis_1,
      coeftest_biis_2,
      coeftest_biis_interact_1,
      coeftest_biis_interact_2
    ), 
    ci.force = T,
    ci.force.level = .95,
    ci.test = NA,
    sideways = F,
    custom.model.names = c('Dissonance', 'Adjusted', 'Interaction', 'Adjusted'),
    custom.coef.names = c('(Intercept)', #1
                          'Moral Injury Symptoms',
                          'Probable PTSD',
                          'White (Race)',
                          'Black (Race)',
                          'Male (Gender)',
                          'Post-9/11 Era', 
                          'Vietnam Era',
                          'Persian Gulf Era',
                          'Years of Service',
                          'Deployments',
                          'Air Force',
                          'Marines',
                          'Navy',
                          'Public Regard',
                          'MI * Public Regard'),
    caption = paste("Regressions on Identity Dissonance"), 
    caption.above = T
  )


# Grab the Goodness of Fit Statistics -------------------------------------

gof_stats <- texreg::texreg(
  list(
    model_biis_1,
    model_biis_2,
    model_biis_interact_1,
    model_biis_interact_2
  ), 
  stars = numeric(0),
  custom.note = 'Unstandardized coefficients and 95\\% Confidence Intervals',
  caption = "Regressions on Identity Dissonance", 
  caption.above = T
)


results_table <- c(read_lines(table)[1:40], read_lines(gof_stats, skip = 40))
results_table %>% print()


# Write -------------------------------------------------------------------
write_lines(x = results_table,
            file = paste0(here::here(), '/output/tables/regression-table-biis.txt'))


rm(results_table)



