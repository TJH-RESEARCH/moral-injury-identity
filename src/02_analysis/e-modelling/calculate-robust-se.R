library(sandwich)
library(lmtest)


coeftest_biis     <- lmtest::coeftest(fit_biis,     
                     sandwich::vcovHC(fit_biis)
                     )

coeftest_wis       <- lmtest::coeftest(fit_wis,    
                      sandwich::vcovHC(fit_wis)
                     )

coeftest_interact  <- lmtest::coeftest(fit_interact,
                      sandwich::vcovHC(fit_interact)
                     )

coeftest_biis_m2cq <- lmtest::coeftest(fit_biis_m2cq,     
                      sandwich::vcovHC(fit_biis_m2cq)
)

coeftest_wis_m2cq  <- lmtest::coeftest(fit_wis_m2cq,    
                      sandwich::vcovHC(fit_wis_m2cq)
)

