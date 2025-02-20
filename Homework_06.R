# David C. Green
# 2_23_22
# Homework 6

library(ggplot2) # for graphics
library(MASS) # for maximum likelihood estimation

# #PART 1

# quick and dirty, a truncated normal distribution to work on the solution set
z <- rnorm(n=3000,mean=0.2)
z <- data.frame(1:3000,z)
names(z) <- list("ID","myVar")
z <- z[z$myVar>0,]
str(z)
summary(z$myVar)

# Plot histogram of data
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2)
print(p1)

# Add imperical curve density
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

# Get maximum likelihood parameters for normal
normPars <- fitdistr(z$myVar,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute

# Plot normal probability density
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat

# Plot exponential probability density
expoPars <- fitdistr(z$myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(z$myVar), args = list(rate=rateML))
p1 + stat + stat2

# Plot uniform probability density
stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat + stat2 + stat3

# Plot gamma probability density
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4

# Plot beta probability density
pSpecial <- ggplot(data=z, aes(x=myVar/(max(myVar + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) +
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")

betaPars <- fitdistr(x=z$myVar/max(z$myVar + 0.1),start=list(shape1=1,shape2=2),"beta")
shape1ML <- betaPars$estimate["shape1"]
shape2ML <- betaPars$estimate["shape2"]

statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid", n = length(z$myVar), args = list(shape1=shape1ML,shape2=shape2ML))
pSpecial + statSpecial

#PART 2

# quick and dirty, a truncated normal distribution to work on the solution set
z <- read.table('CleanData/Azevedo_Egg_size_&_ovariole_number_cleaned.csv',header = TRUE, sep = ',')
str(z)
summary(z)

# Plot histogram of data
p1 <- ggplot(data=z, aes(x=Mean_ovariole_number, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)

# Add imperical curve density
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

# Get maximum likelihood parameters for normal
normPars <- fitdistr(z$Mean_ovariole_number,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute

# Plot normal probability density
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$Mean_ovariole_number),len=length(z$Mean_ovariole_number))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$Mean_ovariole_number), args = list(mean = meanML, sd = sdML))
p1 + stat

# Plot exponential probability density
expoPars <- fitdistr(z$Mean_ovariole_number,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(z$Mean_ovariole_number), args = list(rate=rateML))
p1 + stat + stat2

# Plot uniform probability density
stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat + stat2 + stat3

# Plot gamma probability density
gammaPars <- fitdistr(z$Mean_ovariole_number,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(z$Mean_ovariole_number), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4

# Plot beta probability density
pSpecial <- ggplot(data=z, aes(x=Mean_ovariole_number/(max(Mean_ovariole_number + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) + 
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")

betaPars <- fitdistr(x=z$Mean_ovariole_number/max(z$Mean_ovariole_number + 0.1),start=list(shape1=1,shape2=2),"beta")
shape1ML <- betaPars$estimate["shape1"]
shape2ML <- betaPars$estimate["shape2"]

statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid", n = length(z$Mean_ovariole_number), args = list(shape1=shape1ML,shape2=shape2ML))
pSpecial + statSpecial

# PART 4

# quick and dirty, a truncated normal distribution to work on the solution set
z <- read.table('CleanData/Azevedo_Egg_size_&_ovariole_number_cleaned.csv',header = TRUE, sep = ',')
str(z)
summary(z)

# Plot gamma probability density
gammaPars <- fitdistr(z$Mean_ovariole_number,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

# rnorm distribution
rnormdist <- rnorm(500, shapeML, rateML)
#into data frame
dframe <- data.frame(rnormdist)

p2 <- ggplot(data = dframe, aes(x = rnormdist, y = ..density..)) +
  geom_histogram(color = 'grey60', fill = 'cornsilk', size = 0.2)
print(p2)
#gamma curve
xval <- seq(0,max(dframe),len=length(dframe))
stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(dframe), args = list(shape=shapeML, rate=rateML))
p1 + stat4

#histogram for origional data and curve
pSpecial <- ggplot(data=z, aes(x=Mean_ovariole_number/(max(Mean_ovariole_number + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) + 
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")
print(pSpecial)
