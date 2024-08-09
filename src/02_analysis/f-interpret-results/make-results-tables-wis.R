
# -----------1--------------------------------------------------------------
source(here::here('src/01_config/functions/function-append-results.R'))


table <- 
  texreg::texreg(
    list(
      coeftest_wis_interdependent_1,
      coeftest_wis_interdependent_2
    ), 
    ci.force = T,
    ci.force.level = .95,
    ci.test = NA,
    sideways = F,
    custom.model.names = c('Bivariate', 'Adjusted'),
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
                          'Navy'),
    caption = paste("Regressions on Military Identity Attachment"), 
    caption.above = T
  )


# Grab the Goodness of Fit Statistics -------------------------------------

gof_stats <- texreg::texreg(
  list(
    model_wis_interdependent_1,
    model_wis_interdependent_2
  ), 
  stars = numeric(0),
  custom.note = 'Unstandardized coefficients and 95\\% Confidence Intervals',
  caption = "Regressions on Military Identity Attachment", 
  caption.above = T
)


results_table <- c(read_lines(table)[1:38], read_lines(gof_stats, skip = 38))
results_table %>% print()


# Write -------------------------------------------------------------------
write_lines(x = results_table,
            file = paste0(here::here(), '/output/tables/regression-table-wis.txt'))

rm(results_table)
