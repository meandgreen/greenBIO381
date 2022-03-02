# David C. Green
# Homework 7
# 03_02_22

library(tidyverse)

data(iris)

#1
glimpse(iris)

# 2
iris1 <- filter(iris, Species == c('virginica', 'versicolor'), Sepal.Length > 6, Sepal.Width > 2.5)
glimpse(iris1)

# 3
iris2 <- select(iris1, Species, Sepal.Length, Sepal.Width)
glimpse(iris2)

# 4
iris3 <- arrange(iris2, desc(Sepal.Length))
glimpse(iris3)

# 5
iris4 <- mutate(iris3, Sepal.Area = Sepal.Length*Sepal.Width)
glimpse(iris4)

# 6
iris5 <- summarize(iris4, meanSepal.Length = mean(Sepal.Length), meanSepal.Width = mean(Sepal.Width), N = n())
print(iris5)

# 7
irisGroups <- group_by(iris4, Species)
iris6 <- summarize(irisGroups, meanSepal.Length = mean(Sepal.Length), meanSepal.Width = mean(Sepal.Width), N = n())
glimpse(iris6)

# 8
iris7 <- iris %>%
  filter(Species == c('virginica', 'versicolor'), Sepal.Length > 6, Sepal.Width > 2.5) %>%
  select(Species, Sepal.Length, Sepal.Width) %>%
  arrange(desc(Sepal.Length)) %>%
  mutate(Sepal.Area = Sepal.Length*Sepal.Width) %>%
  group_by(Species) %>%
  summarize(meanSepal.Length = mean(Sepal.Length), meanSepal.Width = mean(Sepal.Width), N = n())
glimpse(iris7)

# 9
newIris <- pivot_longer(iris, cols = 1:4, names_to = 'Measure', values_to = 'Value')
glimpse(newIris)
