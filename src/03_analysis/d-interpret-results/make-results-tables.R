

texreg::texreg(list(coeftest_wis_0, 
                    coeftest_wis_1_bivariate, 
                    coeftest_wis_2_adjust,
                    coeftest_wis_3b1_crit,
                    coeftest_wis_3c1_proxy,
                    coeftest_wis_4b1_controls), 
               stars = 0,
               custom.note = 'Standard error in parentheses. Bold indicates p less than .05',
               bold = .05,
               caption = "Regressions on Military Identity", 
               caption.above = T) #add to list for more models in tbl


texreg::texreg(list(coeftest_biis_0, 
                    coeftest_biis_1_bivariate, 
                    coeftest_biis_2_adjust,
                    coeftest_biis_3b1_crit,
                    coeftest_biis_3c1_proxy,
                    coeftest_biis_4b1_controls), 
               stars = 0,
               custom.note = 'Standard error in parentheses. Bold indicates p less than .05',
               bold = .05,
               caption = "Regressions on Identity Dissonance", 
               caption.above = T) #add to list for more models in tbl
