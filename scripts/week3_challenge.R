library(tidyverse)
gapminder <- read.csv("data/gapminder_data.csv")
gapminder

gapminder_1977 <- filter(gapminder, year == 1977)
gapminder_1977
