library(sandwich)
library(lmtest)
library(texreg)



coeftest_wis_0 <-
  lmtest::coeftest(model_wis_0, sandwich::vcovHC(model_wis_0))

coeftest_wis_1_bivariate <-
  lmtest::coeftest(model_wis_1_bivariate, sandwich::vcovHC(model_wis_1_bivariate))

coeftest_wis_2_adjust <-
  lmtest::coeftest(model_wis_2_adjust, sandwich::vcovHC(model_wis_2_adjust))

coeftest_wis_3b1_crit <-
  lmtest::coeftest(model_wis_3b1_crit, sandwich::vcovHC(model_wis_3b1_crit))

# sandwich::vcovHC(model_wis_3b2_instrument)

coeftest_wis_3c1_proxy <-
  lmtest::coeftest(model_wis_3c1_proxy, sandwich::vcovHC(model_wis_3c1_proxy))

coeftest_wis_4b1_controls <-
  lmtest::coeftest(model_wis_4b1_controls, sandwich::vcovHC(model_wis_4b1_controls))

coeftest_biis_0 <-
  lmtest::coeftest(model_biis_0, sandwich::vcovHC(model_biis_0))

coeftest_biis_1_bivariate <-
  lmtest::coeftest(model_biis_1_bivariate, sandwich::vcovHC(model_biis_1_bivariate))

coeftest_biis_2_adjust <-
  lmtest::coeftest(model_biis_2_adjust, sandwich::vcovHC(model_biis_2_adjust))

coeftest_biis_3b1_crit <-
  lmtest::coeftest(model_biis_3b1_crit, sandwich::vcovHC(model_biis_3b1_crit))
# sandwich::vcovHC(model_biis_3b2_instrument)

coeftest_biis_3c1_proxy <-
  lmtest::coeftest(model_biis_3c1_proxy, sandwich::vcovHC(model_biis_3c1_proxy))

coeftest_biis_4b1_controls <-
  lmtest::coeftest(model_biis_4b1_controls, sandwich::vcovHC(model_biis_4b1_controls))




