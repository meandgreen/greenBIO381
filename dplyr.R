# David C. Green
# dplyr
# 03_02_22

# DPLYR!!!
library(tidyverse)

# filter(): pick/subset observations by their values (rows)
# range(): reordering the rows
# select(): chose variables (columns) by name
# mutate(): creating new variables with functions of existing variables
# summarize() and group_by(): collapses many values down to a single summary

# get sample data
data(starwars)
class(starwars)
# tbl: tibble: modern take on data frames that keeps great aspects of data frames and drops the frustrating ones
# glimpse() gives an easy view of the tbl
glimpse(starwars)

# complete cases to clean up data set
starwarsClean <- starwars[complete.cases(starwars[,1:10]),]

is.na(starwarsClean)
# anyNA() gives a single response that referse to all of the variables
anyNA(starwarsClean)

head(starwarsClean)
# ---------------------------------------------------------------------------------------------------------

# filter()
# use <, >, <=, >=, !=, ==
# filter auto-exculed NAs - have to ask

filter(starwarsClean, gender == 'masculine' & height < 180) # a comma and & are interchangeable
filter(starwarsClean, gender == 'masculine', height < 180, height > 100)

filter(starwarsClean,  eye_color %in% c('blue', 'brown')) # gives back everything that has blue or brown eyes

# ---------------------------------------------------------------------------------------------------------

# arrange()
# arranges the data by rows
arrange(starwarsClean, by = height) # default arrangement is ascending
arrange(starwarsClean, by = desc(height)) # using desc() arranges them in descending order
arrange(starwarsClean, height, mass) # variables can serve as tie breakers in the arrangement

# ---------------------------------------------------------------------------------------------------------

# select()
# chooses variables by name (columns)

#all of these do the name thing, but by different methods
starwarsClean[,1:10]
select(starwarsClean, 1:10)
select(starwarsClean, name:homeworld)

select(starwarsClean, -(films:starships)) # this selects everything except for the specified columns

# can re arrange columns
select(starwarsClean, name, gender, species, everything()) # everything() is used to select everything else that is in the data set
select(starwarsClean, contains('color')) # contains() will get all the columns that contain the str that is specified 

# these are other helpers
# ends_with(), starts_with(), matches(), num_range()

# rename columns with select
select(starwarsClean, haircolor = hair_color) # new name first, old name second

# ---------------------------------------------------------------------------------------------------------

# mutate
# creates new variables with functions of existing variables

mutate(starwarsClean, ratio = height/mass)
starwars_lbs <- mutate(starwarsClean, mass_lbs = mass*2.2)

select(starwars_lbs, 1:3, mass_lbs, everything())

# transmute
transmute(starwars_lbs, mass_lbs, mass*2.2)

# ----------------------------------------------------------------------------------------------------------
# summarize() and group_by()

summarize(starwarsClean, meanHeight = mean(height))
summarize(starwars, meanHeight = mean(height)) # if there are NAs then the mean will come back as NA
summarize(starwars, meanHeight = mean(height, na.rm=TRUE)) # adding na.rm fixes this
summarize(starwars, meanHeight = mean(height, na.rm=TRUE), TotalN = n()) # TotalN = n() gives the amount of numbers that the mean in beingcalculated by

# group_by()
starwarsGenders <- group_by(starwars, gender) 
head(starwarsGenders)
summarize(starwarsGenders, meanHeight = mean(height, na.rm = TRUE), N = n()) # now the means can be taken by group

# ----------------------------------------------------------------------------------------------------------

#PIPING
# %>%
# emphasize sequence of actions
# lets you pass and intermediate result onto the next function - it takes the output of one statement/function and uses it as the input of the next statement/ function\$ 
# avoid when manipulating more than one object or if toy have meaningful intermediate objects

starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight = mean(height), N = n())

# instead of having to write out a long set of codes you can use one line of piping

# case_when()
# useful for if else statements

ifelse(starwarsClean$gender == 'feminine', 'F', 'M') 

starwarsClean %>%
  mutate(sp = case_when(species == 'Human' ~ 'Humanoid', TRUE ~ 'Non-Human')) %>%
  select(name, sp, everything())
# case_when() can be used for multiple variables where as ifelse() can only be used with one or the other

# ---------------------------------------------------------------------------------------------------------

# convert long to wide format and vice-versa
glimpse(starwarsClean)

wideSW <- starwarsClean %>%
  select(name, sex, height) %>%
  pivot_wider(names_from = sex, values_from = height) # values_fill replaces NAs with a specified variable
glimpse(wideSW)

wideSW %>%
  pivot_longer(cols = males:female, names_to = 'sex', values_to = 'height', values_drop_na = TRUE)

starwars %>%
  select(name, homeworld) %>%
  group_by(homeworld) %>%
  mutate(rn = row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = homeworld, values_from = name)
