# David C. Green
# 2022-03-23
# Homework 9
# ---------------------------------------------------------------------
# Libraries
library(tidyverse)

# ---------------------------------------------------------------------
# Sources

# ---------------------------------------------------------------------
# Functions

# ======================================================================
# FUNCTION sim_data_norm
# Purpose: simulates data for a normal distribution
# Input: size, mean, sd
# Output: data vector
# --------------------------------------------------------------------
sim_data_norm <- function(size = 100, mean = 50, sd  = 2) {
  dat <- rnorm(n = size, mean = mean, sd = sd)
}

# ======================================================================
# FUNCTION create_dataframe
# Purpose: puts data into a data frame
# Input: group 1 to 4
# Output: dataframe
# --------------------------------------------------------------------
create_dataframe<- function(g1 = NULL, g2 = NULL, g3 = NULL, g4 = NULL) {
  if(is.null(g1) & is.null(g2) & is.null(g3) & is.null(g4)) {
    message('No data has been entered') 
    nd <- TRUE
  } else
    if (is.null(g2) & is.null(g3) & is.null(g4)) {
      data1 <- data.frame(g1)
      nd <- FALSE
    } else
      if(is.null(g3) & is.null(g4)) {
        data1 <- data.frame(g1, g2)
        nd <- FALSE
      } else
        if(is.null(g4)) {
          data1 <- data.frame(g1, g2, g3)
          nd <- FALSE
        } else 
          data1 <- data.frame(g1, g2, g3, g4)
          nd <- FALSE
  return(data1)
}

# ======================================================================
# FUNCTION analyze_data
# Purpose:
# Input:
# Output:
# --------------------------------------------------------------------
analyze_data <- function(data = data.frame(rnorm(100), rnorm(100))) {
  t_test <- t.test(data[1], data[2])
  print(t_test)
  boxplot(data)
}

# ---------------------------------------------------------------------
# Body

control <- sim_data_norm(28, 17, 2)
latd <- sim_data_norm(28, 7, 2)
df <- create_dataframe(control, latd)
analyze_data(df)


