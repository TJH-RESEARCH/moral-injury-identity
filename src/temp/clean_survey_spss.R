


# Import Data -------------------------------------------------------------
data <- haven::read_sav(here::here('data/raw/Dissertation_May 4, 2023_18.41.sav'))


# Inspect -----------------------------------------------------------------
data %>% glimpse()
data %>% haven::as_factor() %>% glimpse()
data %>% skimr::skim()

# M-CARM needs to be recoded from 6-10 scale to 1-5 scale
data %>% select(mcarm_10) - 5

