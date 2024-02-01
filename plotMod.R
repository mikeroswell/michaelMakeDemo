library(dplyr)
library(tidyr)
library(ggplot2)
library(shellpipes)
theme_set(theme_test())
sourceFiles()
loadEnvironments()
startGraphics()

y_stoch = data.frame(stochsim_SIR(c(0, ts)
                                  , y0
                                  , pars))

stochPlot <- y_stoch %>% 
    tidyr::pivot_longer(cols = 2:4, names_to = "population", values_to = "n") %>% 
    ggplot(
        aes(time, n, color = population)) +
    geom_line() 

print(stochPlot)
rdsSave(stochPlot)
