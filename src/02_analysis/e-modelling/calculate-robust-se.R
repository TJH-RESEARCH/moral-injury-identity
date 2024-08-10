library(sandwich)
library(lmtest)


coeftest_biis     <- lmtest::coeftest(fit_biis,     
                     sandwich::vcovHC(fit_biis)
                     )

coeftest_wis      <- lmtest::coeftest(fit_wis,    
                     sandwich::vcovHC(fit_wis)
                     )

coeftest_interact <- lmtest::coeftest(fit_interact,
                     sandwich::vcovHC(fit_interact)
                     )

