# David C. Green
# 03_16_22
# Data simulation

library(boot)

# ---------------------------------------------------------------------
#normally distributed data
# for t-test or ANOVA

# simulate groups with 20 obs
group1 <- rnorm(n = 20, mean = 2, sd = 1)
hist(group1)

# change some parameters
group2 <- rnorm(n = 20, mean = 5, sd = 1)
group3 <- rnorm(n = 20, mean = 2, sd = 3)
hist(group2)
hist(group3)

# ---------------------------------------------------------------------
# linear regression data

# assume intercept of 0
# slope = beta1
# x is predictor

# constant slope
beta1 <- 1
#predictor is normally distributed
x <- rnorm(n = 20)
# linear model
y <- beta1*x

# can play with different slopes
beta2 <- 1.5
y <- beta2*x
print(y)

beta3 <- 2
y <- beta3*x
print(y)

# add covariates, can draw covariates from a different distribution

# ---------------------------------------------------------------------
# Abundance data
# use round() to remove decimals

# data is normalish
abund1 <-round(rnorm( n = 20, mean = 50, sd = 10))
hist(abund1)

# Poisson distribution
abund2 <- rpois(n = 20, lambda = 3)
barplot(table(abund2))

# sometimes the enviroment affects counts 
# to account for that, first create lambda's

# use a regression to get initial values
prelambda <- beta1+beta2*x
#inverse log 'exp()' to make lambdas positive and to convert regrssion data to poisson data
lambda <- exp(prelambda)
# use created lambdas to get counts
abund3 <- rpois(n = 20, lambda = lambda)
hist(abund3)

# ---------------------------------------------------------------------
# Occupancy data

# get probs from beta distribution
probs <- rbeta(n =20, shape= 1, shape2 = 1)
occ1 <- rbinom(n=20, size = 1, prob = probs)
print(occ1)

# occupancy with a covariant
# similar to above, except we're generating probabilities not lambdas

preprobs2 <- beta1+beta2*x

# convert to 0-1 scale
psi <- inv.logit(preprobs2)
# create new occupany values
occ2 <- rbinom(n = 20, size = 1, prob = psi)
print(occ2)



# ---------------------------------------------------------------------
# ASSIGNMENT

control <- rnorm(n = 28, mean = 17, sd = 2) 
latd <- rnorm(n = 28, mean = 6, sd = 2)
df <- data.frame(control, latd)
t_test <- t.test(latd, control)
print(t_test)
boxplot(control, latd, 
        names = c('Control', 'latd'),
        ylab = 'Primary Root Length',
        title = 'Primary root Length: latd vs. Wild')


