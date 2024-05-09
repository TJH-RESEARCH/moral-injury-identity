
# Graphs ------------------------------------------------------------------
data %>% ggplot(aes(years_of_age)) + geom_density()
data %>% ggplot(aes(branch)) + geom_bar()
data %>% ggplot(aes(service_era)) + geom_bar()
ggplot(data, aes(x = '', y = 'identity', fill = branch)) + geom_col() + coord_polar(theta = "y")
data %>% ggplot(aes(highest_rank)) + geom_bar()
ggplot(data, aes(x = '', y = 'identity', fill = highest_rank)) + geom_col() + coord_polar(theta = "y")
