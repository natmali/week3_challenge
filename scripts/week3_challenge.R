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
ggplot(gapminder,
       aes(x = year,
           y = lifeExp,
           colour = continent,
           size = pop)) + geom_point(shape = "triangle") 

# Grouped by mean life expectancy per year
gapminder_by_year <- gapminder %>% 
  group_by(year) %>% 
  summarise(mean_life_Exp = mean(lifeExp))
gapminder_by_year

ggplot(gapminder_by_year,
       aes( y = mean_life_Exp,
            x = year)) + geom_point(colour = "green", alpha = 1)

# Group by continent and by year 
gapminder_grouped <- gapminder %>% 
  group_by(continent, year) %>%  # Use of the 2 x group by 
  summarise(mean_life_exp = mean(lifeExp))
gapminder_grouped

ggplot(gapminder_grouped,
       aes( y = mean_life_exp,
            x = year,
            colour = continent)) + geom_point()

## Adding more than one geometry 
ggplot(data = gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group = country, # Group aesthetic 
           color = continent)) +
  geom_line() # Using line instead

ggplot(data = gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() + 
  geom_point() # Using both points and lines 

# To only colour in one of the aesthetics
ggplot(data = gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() + 
  geom_point(colour = "black")

# Trying to swap the order of the geometries
ggplot(data = gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_point(colour = "black") +
  geom_line() # The lines came in front. The order that you write the code will result in the order that the results are layered in


## Transformations and Statistics
ggplot(data = gapminder, 
       mapping = aes(x = gdpPercap, 
                     y = lifeExp)) +
  geom_point(alpha = 0.3) +
  scale_x_log10()


# Add a trend line using a geometry called smooth
ggplot(data = gapminder, 
       mapping = aes(x = gdpPercap, 
                     y = lifeExp)) +
  geom_point(alpha = 0.3) +
  scale_x_log10() + 
  geom_smooth(method = "lm") # Using the geom_smooth to add trend line. We ask it to use the method of linear with method = "lm"

ggplot(data = gapminder, 
       mapping = aes(x = gdpPercap, 
                     y = lifeExp)) +
  geom_point(alpha = 0.3) +
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5) # Changing the thickness of the line

# We would now like these points to be coloured by continent 
ggplot(data = gapminder, 
       mapping = aes(x = gdpPercap, 
                     y = lifeExp,
                     colour = continent)) +
  geom_point(alpha = 0.3) +
  scale_x_log10() +
  scale_colour_manual (values = c("red", "green", "purple", "blue", "black")) # Creating a vector of colours. they have been applied in the order that you have put them inthe vector

# Chaleenge 9 = Modify the color and size of the points on the point layer in the previous example #
ggplot(data = gapminder, 
       aes(x = gdpPercap, 
           y = lifeExp)) +
  geom_point(colour = "turquoise", size = 3) + 
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5)
  
# Challenge 10 = Modify your solution to Challenge 9 so that the points are now a different shape and are colored by continent with new trendlines #
ggplot(data = gapminder, 
       aes(x = gdpPercap, 
           y = lifeExp,
           colour = continent)) +
  geom_point(shape = "triangle", size = 3) + 
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5)

# Challenge 11 = Try modifying the plot above by changing some colours in the scale to see if you can find a pleasing combination. 
# Run the colours() function if you want to see a list of colour names R can use.#
ggplot(data = gapminder, 
       aes(x = gdpPercap, 
           y = lifeExp,
           colour = continent)) +
  geom_point(shape = "triangle", size = 3) + 
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5, se = FALSE) +
  scale_colour_manual (values = c("coral", "palegreen2", "cyan", "magenta2", "plum"))

colours()

# There is also a scale_colour_brewer() scale that takes an argument palette that is the name of a ColorBrewer palette. 
# Select an appropriate colour palette for the continents from ColorBrewer and apply it to your plot instead.
ggplot(data = gapminder, 
       aes(x = gdpPercap, 
           y = lifeExp,
           colour = continent)) +
  geom_point(shape = "triangle", size = 3) + 
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 1.5, se = FALSE) +
  scale_colour_brewer(palette = 3)


## Seperating Figures
#
a_countries <- filter(gapminder, str_starts(country, "A"))
a_countries

ggplot(a_countries, 
       aes(x = year,
           y = lifeExp,
           colour = continent,
           group = country)) +
  geom_line()

# Now we are going to break this up into seperate panels

ggplot(a_countries, 
       aes(x = year,
           y = lifeExp,
           colour = continent,
           group = country)) +
  geom_line() +
  facet_wrap(~ country) # How we want to break each facet up. In this case it would be country 

# Challenge 12 #
ggplot( data = gapminder_1977, 
  mapping = aes(x = gdpPercap, 
                y = lifeExp, 
                colour = continent, 
                size = pop)) +
  geom_point() +
  scale_x_log10()

# modify it by (1) using the full gapminder dataset (2) adding a facet_wrap to demonstrate the change through time
ggplot( data = gapminder, 
        mapping = aes(x = gdpPercap, 
                      y = lifeExp, 
                      colour = continent, 
                      size = pop)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~year)

# Playing with something 
gapminder_rich <- filter(gapminder_1977, gdpPercap > 30000)
gapminder_rich

ggplot( data = gapminder_1977, 
        mapping = aes(x = gdpPercap, 
                      y = lifeExp, 
                      colour = continent, 
                      size = pop,
                      label = country)) +
  geom_point() +
  scale_x_log10() +
  geom_text(data = gapminder_rich)


## Themes
# Adding our plot to a variable
rough_plot <- ggplot(a_countries, 
       aes(x = year,
           y = lifeExp,
           colour = continent,
           group = country)) +
  geom_line() +
  facet_wrap(~ country)

rough_plot

rough_plot + scale_color_brewer(palette = "Dark2") # Now you can add additional layers to your plot. However this is not changing 'Rough_plot' itself.

rough_plot + 
  labs(title = "Fig1",
       x = "Year",
       y = "Life Expectancy",
       colour = "Continent") # Changing the labels. Look at the menue to see the different things that you can change







  
  

