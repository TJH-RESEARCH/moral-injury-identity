library(sandwich)
library(lmtest)



# SELF --------------------------------------------------------------------
coeftest_self_bi <- lmtest::coeftest(model_self_bi, sandwich::vcovHC(model_self_bi))
coeftest_self_multi <- lmtest::coeftest(model_self_multi, sandwich::vcovHC(model_self_multi))


# OTHER --------------------------------------------------------------------
coeftest_other_bi <- lmtest::coeftest(model_other_bi, sandwich::vcovHC(model_other_bi))
coeftest_other_multi <- lmtest::coeftest(model_other_multi, sandwich::vcovHC(model_other_multi))


# BETRAYAL --------------------------------------------------------------------
coeftest_betrayal_bi <- lmtest::coeftest(model_betrayal_bi, sandwich::vcovHC(model_betrayal_bi))
coeftest_betrayal_multi <- lmtest::coeftest(model_betrayal_multi, sandwich::vcovHC(model_betrayal_multi))

# MULTIPLE --------------------------------------------------------------------
coeftest_multiple_bi <- lmtest::coeftest(model_multiple_bi, sandwich::vcovHC(model_multiple_bi))
coeftest_multiple_multi <- lmtest::coeftest(model_multiple_multi, sandwich::vcovHC(model_multiple_multi))

