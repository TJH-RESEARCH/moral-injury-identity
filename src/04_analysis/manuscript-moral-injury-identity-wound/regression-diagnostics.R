
# Analyze regression diagnostics



# Diagnostics -------------------------------------------------------------

plot_lm(data, DV = 'wis_centrality_total', 
        IVs = c(IV_treatment, IV_adjustment_set_1, IV_neutral_controls, IV_improve_precision))

### Residuals vs Fitted. 
### QQ Plot:
###
###

plot_lm(data, DV = 'wis_connection_total', 
        IVs = c(IV_treatment, IV_adjustment_set_1, IV_neutral_controls, IV_improve_precision))

## Residuals vs Fitted: 
### Fine. Some shift toward linearity of variance on the right.
### small slope, but one possible outlier
### QQ Plot: Good. Step pattern indicates integer DV. 
### Left and right censoring where data is truncated.
## Scale location: More sensitive red line than Res Vs. Fitted plot.
## The increase in slope toward the left again points to an outlier or two. Still not extreme. 
### Residuals vs. Leverage: Here again, things look fine. 
### Maybe a datum or two outlying, but not skewing the results too badly.


plot_lm(data, DV = 'wis_family_total', 
        IVs = c(IV_treatment, IV_adjustment_set_1, IV_neutral_controls, IV_improve_precision))

### Everything looks VERY good. 

plot_lm(data, DV = 'wis_interdependent_total', 
        IVs = c(IV_treatment, IV_adjustment_set_1, IV_neutral_controls, IV_improve_precision))

### Good.



# Private Regard ----------------------------------------------------------

plot_lm(data, DV = 'wis_private_regard_total', 
        IVs = c(IV_treatment, IV_adjustment_set_1, IV_neutral_controls, IV_improve_precision))

hist(data$wis_private_regard_total)
### These are the wonkiest so far. 
### Likely indicative of the long left tail of the DV

# Histogram of Residuals
fit_set_1_cntrl_prec_trans[[6]]$summary$residuals %>% hist()

#perform Breusch-Pagan Test
lmtest::bptest(fit_set_1_cntrl_prec_trans[[1]]$summary)
## Null Hypothesis (H0): The residuals are homoscedastic (i.e. evenly spread)
## Alternative Hypothesis (HA): The residuals are heteroscedastic (i.e. not evenly spread)

#Private regard
#-	Residuals followed a linear pattern
#-	No data points were overly influential
#-	The distribution of residuals was skewed right but otherwise appeared normal.
#-	Graphs indicating heteroscedasticity were inconclusive, so a Breusch-Pagan Test was performed which indicated the residuals were not homoscedastic. 


# Public Regard -----------------------------------------------------------

plot_lm(data, DV = 'wis_public_regard_total', 
        IVs = c(IV_treatment, IV_adjustment_set_1, IV_neutral_controls, IV_improve_precision))
hist(data$wis_public_regard_total)

### The plots were again a little wonky. The distribution
### of the DV is highly kurtotic. 

fit_set_1_cntrl_prec_trans[[7]]$summary$residuals %>% hist()


# Skills ------------------------------------------------------------------



plot_lm(data, DV = 'wis_skills_total', 
        IVs = c(IV_treatment, IV_adjustment_set_1, IV_neutral_controls, IV_improve_precision))

## That one is good!

