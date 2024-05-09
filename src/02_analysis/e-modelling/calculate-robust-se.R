library(sandwich)
library(lmtest)


coeftest_biis_1               <- lmtest::coeftest(model_biis_1, sandwich::vcovHC(model_biis_1))
coeftest_biis_interact_1      <- lmtest::coeftest(model_biis_interact_1, sandwich::vcovHC(model_biis_interact_1))
coeftest_wis_private_regard_1 <- lmtest::coeftest(model_wis_private_regard_1, sandwich::vcovHC(model_wis_private_regard_1))
coeftest_wis_interdependent_1 <- lmtest::coeftest(model_wis_interdependent_1, sandwich::vcovHC(model_wis_interdependent_1))

coeftest_biis_2               <- lmtest::coeftest(model_biis_2, sandwich::vcovHC(model_biis_2))
coeftest_biis_interact_2      <- lmtest::coeftest(model_biis_interact_2, sandwich::vcovHC(model_biis_interact_2))
coeftest_wis_private_regard_2 <- lmtest::coeftest(model_wis_private_regard_2, sandwich::vcovHC(model_wis_private_regard_2))
coeftest_wis_interdependent_2 <- lmtest::coeftest(model_wis_interdependent_2, sandwich::vcovHC(model_wis_interdependent_2))


