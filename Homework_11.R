# David C. Green
# 2022-04-06
# Batch Processing
# ---------------------------------------------------------------------
# Libraries
library(tidyverse)

# ---------------------------------------------------------------------
# Sources

# ---------------------------------------------------------------------

# ======================================================================
# FUNCTION analyzeNodData
# Purpose: mean, sd of root and nodule stats
# Input: x = target .csv file
# Output: df
# --------------------------------------------------------------------
analyzeNodData <- function(x = NULL) {
  table <- read.table(file = x,
             header = TRUE,
             sep = ',')
  group1 <- group_by(table, Treatment)
  group <- group_by(group1, Inoculation, .add = TRUE)
  sumPRL <- summarize(group, mean = mean(PRL))
  sumLR <- summarize(group, mean = mean(LR))
  sumWN <- summarize(group, mean = mean(WN))
  sumPN <- summarize(group, mean = mean(PN))
  sumBN <- summarize(group, mean = mean(BN))
  df <- data.frame(PRL_AVG = sumPRL, LR_AVG = sumLR, WN_AVG = sumWN, PN_AVG = sumPN, BN_AVG = sumBN)
  return(df)
}

# ======================================================================
# FUNCTION randomizeNODdata
# Purpose: radomize NOD data and export into a .csv
# Input: df = data frame containing NOD data
# Output: .csv file
# --------------------------------------------------------------------
randomizeNODdata <- function(df = data.frame(Treatment = c(rep('Control', 20), rep('50mM', 20), rep('100mM', 20)),
                                             Inoculation = c(rep(c(rep('Rm1021', 10), rep('Mock', 10)), 3)),
                                                               PRL = runif(60, 5, 25), 
                                                               LR = runif(60, 0, 10), 
                                                               WN = runif(60, 0, 5), 
                                                               PN = runif(60, 0, 5), 
                                                               BN = runif(60, 0, 5)), times = 10, dest = 'Random_NOD_Data/') {
  for(i in 1:times) {
  ndf <- data.frame(Treatment = df$Treatment,
                    Inoculation = df$Inoculation,
                    PRL = sample(df$PRL), 
                    LR = sample(df$LR), 
                    WN = sample(df$WN), 
                    PN = sample(df$PN), 
                    BN = sample(df$BN))
  file_label <- paste(dest,
                      'rand_nod',
                      formatC(i,
                              format = 'd'),
                      '.csv', sep = '')
  write.table(cat('# Simulated Nodulation Data File ', i, '\n',
                  '# Date: ', as.character(Sys.time()), '\n',
                  '# David C. Green', '\n',
                  '\n',
                  file = file_label,
                  row.names = '',
                  col.names = '',
                  sep = ''))
  write.table(x = ndf,
              file = file_label,
              sep = ',',
              row.names = FALSE,
              append = TRUE)
  }
}

# ======================================================================
# Batch processing for nodulation data
# ---------------------------------------------------------------------
# Globals
file_path <- 'NodData/MSSR108_POOL_NODEAD_RAW.csv'
sumFile <- 'Random_NOD_Data/rand_nod_summary.csv'
table <- read.table(file_path, header = TRUE, sep = ',')
rawData <- data.frame(table)
dest <- 'Random_NOD_Data/'
dir.create(dest)
Nfiles <- 10

# Analyze experimental results
expData <- analyzeNodData(file_path) # 6 x 15 table


# Create simulation data
randomizeNODdata(rawData)

# Analyze simulated data and write to summary file
# Create summary file and write experimental data
write.table(cat('# Simulated Nodulation Summary Data File ', '\n',
            '# Date: ', as.character(Sys.time()), '\n',
            '# David C. Green', '\n',
            '\n',
            'Experimnetal Data:',
            '\n',
            file = sumFile,
            row.names = '',
            col.names = '',
            sep = ''))
write.table(x = expData,
            file = sumFile,
            sep = ',',
            row.names = FALSE,
            append = TRUE)
write.table('\n',
            file = sumFile,
            row.names = FALSE,
            append = TRUE)
# Write simulated data to summary file
write.table('Simulated Data:',
            file = sumFile,
            row.names = FALSE,
            append = TRUE)
for(i in 1:Nfiles) {
  file_path2 <- paste('Random_NOD_Data/rand_nod',
                      formatC(i,
                              format = 'd',
                              flag = '0'),
                      '.csv', sep = '')
  simData <- analyzeNodData(file_path2)
  write.table(x = simData,
              file = sumFile,
              sep = ',',
              row.names = FALSE,
              append = TRUE)
  write.table('\n',
              file = sumFile,
              row.names = FALSE,
              append = TRUE)
}
