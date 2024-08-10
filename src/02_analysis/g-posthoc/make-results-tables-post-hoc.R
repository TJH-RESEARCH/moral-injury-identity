
# -------------------------------------------------------------------------
source(here::here('src/01_config/functions/function-append-results.R'))


table <- 
  texreg::texreg(
    list(
      coeftest_self_multi,
      coeftest_other_multi,
      coeftest_betrayal_multi,
      coeftest_multiple_multi
    ), 
    ci.force = T,
    ci.force.level = .95,
    ci.test = NA,
    sideways = F,
    custom.model.names = c('Self', 'Other', 'Betrayal', 'Multiple'),
    custom.coef.names = c('(Intercept)', #1
                          'Moral Injury Self',
                          'Probable PTSD',
                          'White (Race)',
                          'Black (Race)',
                          'Male (Gender)',
                          'Post-9/11 Era', 
                          'Vietnam Era',
                          'Persian Gulf Era',
                          'Deployments',
                          'Years of Service',
                          'Air Force',
                          'Marines',
                          'Navy',
                          'Moral Injury Other',
                          'Moral Injury Betrayal',
                          'Moral Injury Multiple'),
    caption = paste("Regressions on Military Identity Attachment"), 
    caption.above = T
  )


# Grab the Goodness of Fit Statistics -------------------------------------

gof_stats <- texreg::texreg(
  list(
    model_self_multi,
    model_other_multi,
    model_betrayal_multi,
    model_multiple_multi
    
  ), 
  stars = numeric(0),
  custom.note = 'Unstandardized coefficients and 95\\% Confidence Intervals',
  caption = "Regressions on Military Identity Attachment", 
  caption.above = T
)


results_table <- c(read_lines(table)[1:42], read_lines(gof_stats, skip = 42))
results_table %>% print()


# Write -------------------------------------------------------------------
write_lines(x = results_table,
            file = paste0(here::here(), '/output/tables/regression-table-posthoc.txt'))

rm(results_table)
