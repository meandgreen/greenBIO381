# David C. Green
# 2022-04-13
# ggplot
# ---------------------------------------------------------------------
# Libraries
library(tidyverse)
library(ggthemes)
library(patchwork)

# ---------------------------------------------------------------------
# Sources

# ---------------------------------------------------------------------

filePath1 <- 'Random_NOD_Data/rand_nod1.csv'
table1 <- read.table(filePath1, header = TRUE, sep = ',')
filePath2 <- 'NodData/MSSR108_POOL_NODEAD_RAW.csv'
table2 <- read.table(filePath2, header = TRUE, sep = ',')

# boxplot for random nod data
plot1 <- ggplot(table1, aes(x = Treatment, y = LR, fill = Inoculation)) +
  geom_boxplot() +
  xlab('Treatment') +
  ylab('PRL') +
  ggtitle('Lateral Root Density During Moderate Salt Stress Using Simulated Data')

print(plot1)

# boxplot for experimental nod data
plot2 <- ggplot(table2, aes(x = Treatment, y = LR, fill = Inoculation)) +
  geom_boxplot() +
  xlab('Treatment') +
  ylab('PRL') +
  ggtitle('Lateral Root Density During Moderate Salt Stress')

print(plot2)

Sheeva <- sample(c(rep('Mardiel', 100), rep('Gramital', 100), rep('Hormal', 100), rep('Sidel', 100)))
Sental <- sample(c(rep('Horn', 50), rep('Sheeve', 50), rep('Stral', 50), rep('Grift', 50), rep('Freal', 50), rep('Trill', 50), rep('Sogor', 50), rep('Raydal', 50)))
Corisent <- runif(400)
df1 <- data.frame(Sheeva, Sental, Corisent)

# heatmap for fantasy data
plot3 <- ggplot(df1, aes(x = Sheeva, y = Sental, fill = Corisent)) +
  geom_tile() +
  ggtitle('Chiveral of Gorintal') +
  xlab('Sheeva') +
  ylab('Sental')
print(plot3)

