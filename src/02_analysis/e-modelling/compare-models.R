
# MI event predicting Interdependence
model_interdependence <- boot_fits_aparent$fits[[1]]

# Interdependence predicting Moral Injury Symptoms
model_mios_interdependence <- boot_fits_aparent$fits[[2]]

# MI event predicting Regard
model_regard <- boot_fits_aparent$fits[[3]]

# Regard predicting Moral Injury Symptoms
model_mios_regard <- boot_fits_aparent$fits[[4]]



anova(model_mios_interdependence, model_mios_regard)
AIC(model_mios_interdependence, model_mios_regard)
BIC(model_mios_interdependence, model_mios_regard)

summary(model_mios_interdependence)$r.squared
summary(model_mios_regard)$r.squared


anova(model_interdependence, model_regard)
AIC(model_interdependence, model_regard)
BIC(model_interdependence, model_regard)

summary(model_interdependence)$r.squared
summary(model_regard)$r.squared
