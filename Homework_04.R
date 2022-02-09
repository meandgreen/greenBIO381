#David C. Green
#Homework_04
#02_09_22

#1
#assign variables
x <- 1.1
a <- 2.2
b <- 3.3
z <- c(x, a, b)
print(z)

#a
z <- x^a^b
#b
z <- (x^a)^b
#c
z <- 3*x^3+2*x^2+1

#2
#a
q <- c(seq(from = 1, to = 8), seq(from = 7, to = 1))
print(q)
#b
w <- c(1, rep(2, 2), rep(3, 3), rep(4, 4), rep(5, 5))
print(w)
#c
e <- c(5, rep(4, 2), rep(3, 3), rep(2, 4), rep(1, 5))
print(e)

#3
y <- runif(1, 1, 10)
i <- runif(1, 10, 20)
r <- sqrt(i^2+y^2)
theta <- atan(y/i)

#4
queue <- c('sheep', 'fox', 'owl', 'ant')
#a
queue <- c(queue, 'serpent')
#b
queue <- queue[-1]
#c
queue <- c('donkey', queue)
#d
queue <- queue[-5]
#e
queue <- queue[-3]
#f
queue <- append(queue, 'aphid', after = 2)
#g
print(which(queue == 'aphid'))

#5
o <- 1:100
l <- which(o %% 2 !=0 & o %% 3 !=0 & o %% 7 !=0)

