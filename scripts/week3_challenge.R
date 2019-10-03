library(tidyverse)
gapminder <- read.csv("data/gapminder_data.csv")
gapminder

gapminder_1977 <- filter(gapminder, year == 1977)
gapminder_1977



##ggplot2 
## ggplot(<DATA>, <AESTHETIC MAPPING>) + <GEOMETRY FUNCTION> ##
ggplot(data = gapminder_1977) # Nothing happens

# Mapping out the axis but no points (we have not added in a geometry)
ggplot(data = gapminder_1977, # What data to use
       mapping = aes(x = gdpPercap, # What variables I want to assign to what aesthetics (x,y)
                     y = lifeExp,
                     colour = continent,
                     size = pop)) 

# Adding in the point to the figure
ggplot(data = gapminder_1977, # What data to use
       mapping = aes(x = gdpPercap, # What variables I want to assign to what aesthetics (x,y)
                     y = lifeExp,
                     colour = continent,
                     size = pop)) + geom_point() # Addition of the points


# Changing the scale of the x axis to log
ggplot(data = gapminder_1977, # What data to use
       mapping = aes(x = gdpPercap, # What variables I want to assign to what aesthetics (x,y)
                     y = lifeExp,
                     colour = continent,
                     size = pop)) + geom_point() + # Addition of the points
                                    scale_x_log10() # Addition of 'log' to the scale on the x-axis. Scale_thing you want to scale_how you want to scale it

# Another way to do it
ggplot(data = gapminder_1977) + 
       geom_point(mapping = aes(x = gdpPercap, 
                     y = lifeExp,
                     colour = continent,
                     size = pop)) + 
         scale_x_log10()


# Challenge 4 #
ggplot(data = gapminder_1977, 
       mapping = aes(x = country,
                     y = gdpPercap,
                     colour = continent,
                     size = lifeExp)) + geom_point()

ggplot(data = gapminder_1977) +
  geom_point(mapping = aes(x = gdpPercap,
                             y = country,
                             colour = continent,
                             size = lifeExp))
      
# Challenge 5 #
?geom_point
# x, y, alpha, colour, fill, group, shape, size, stroke


# Challenge 6 #
ggplot(gapminder_1977, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(colour = "blue", size = 5)


ggplot(data = gapminder_1977, 
  mapping = aes(x = gdpPercap, 
                y = lifeExp, 
                colour = continent, 
                size = pop)) +
  geom_point(alpha = 0.1, size = 3, colour = "blue") + #Using other aesthetics
  scale_x_log10()

# Challenge 7 #
# How life expectancy has changed over time?

gapminder

ggplot(gapminder,
       aes(x = year,
           y = lifeExp,
           colour = continent,
           size = pop)) + geom_point(shape = "triangle") 

gapminder_by_year <- gapminder %>% 
  group_by(year) %>% 
  summarise(mean_life_Exp = mean(lifeExp))
gapminder_by_year

ggplot(gapminder_by_year,
       aes( y = mean_life_Exp,
            x = year)) + geom_point(colour = "green", alpha = 1)








