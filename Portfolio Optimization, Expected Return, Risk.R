#load necessary packages
library(tidyverse)
library(lpSolve)

#set working directory
setwd("")

#read in CSV file with data for multiple securities, each security present as a variable (5 in this example)
securities <- read.csv("")
##changing the first column name to 'Dates'
colnames(securities)[1] <- "Dates"



#assigning initial weights for optimization
a <- 0
b <- 0
c <- 0
d <- 0
e <- 0

weights <- c(a, b, c, d, e)



#creating a new data frame for a Portfolio ()
portfolio <- data.frame("Portfolio" = c(1:nrow(securities)))

##assigning values to the Portfolio data frame with dot prod of securities and their respective weights for specific Date (single observation) 
for(i in 1:nrow(securities)){
  x <- as.matrix(securities[i,2:6]) #<- here columns 2-6 represent the number of securities present as variables (5 securities for us)
  portfolio[i,1] = x %*% weights
}



#column binding the securities an portfolio data frames to a new data frame labeled 'raw'
raw <- cbind(securities, portfolio)



#creating a data frame for monthly price of a security and calculating the avg return and risk for each
monthly_price <- raw %>%
  gather(Company, Return, -Dates)
return_std <- monthly_price %>%
  group_by(Company) %>%
  summarise(avg_return = mean(Return),
            sd_return =sd(Return))



#finding the expected return and the risk for the portfolio
exp_ret <- mean(portfolio$Portfolio)
risk <- sd(portfolio$Portfolio)
risk <- return_std[5,2]


#creating an set of limits to serve as upper bounds
UB <- seq(.02, .08, by = .001)


#optimization model building
opt.objective <- exp_ret
opt.objective <- return_std$avg_return


opt.constraints <- matrix(c(a,b,c,d,e,0, # Sum of weights to be 1
                            a,0,0,0,0,0,
                            0,b,0,0,0,0,
                            0,0,c,0,0,0,
                            0,0,0,d,0,0,
                            0,0,0,0,e,0,
                            0,0,0,0,0,risk), nrow = 7, byrow = TRUE)
opt.direction <- c("=", ">=", ">=", ">=",">=",">=","<=")
opt.rhs <- c(1,0,0,0,0,0,UB[61])

solution.maxreturn <- lp(direction = "max",
                         opt.objective,
                         opt.constraints,
                         opt.direction,
                         opt.rhs)

weights.maxreturn <- solution.maxreturn$solution
return.maxreturn <- solution.maxreturn$objval

weights.maxreturn
return.maxreturn





#find the maxium return portfolio (rightmost point of efficient frontier)
#which will be 100% of Google
#maximize w1*Costco + w2*CVX + w3*DIS + w4*Google + w5*SBUX
#subject to 0<=Wi; Wi add up to 1
opt.objective <- return_std$avg_return
opt.constraints <- matrix(c(1,1,1,1,1, # Sum of weights to be 1
                            1,0,0,0,0,
                            0,1,0,0,0,
                            0,0,1,0,0,
                            0,0,0,1,0,
                            0,0,0,0,1), nrow = 6, byrow = TRUE)
opt.direction <- c("=", ">=", ">=", ">=",">=",">=")
opt.rhs <- c(1,0,0,0,0,0)



##modeling Building
solution.maxreturn <- lp(direction = "max",
                         opt.objective,
                         opt.constraints,
                         opt.direction,
                         opt.rhs)
##maximum Return and Weights
weights.maxreturn <- solution.maxreturn$solution
return.maxreturn <- solution.maxreturn$objval







