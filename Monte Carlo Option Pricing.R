library(tidyverse)



#initial set up 
s0 = 174.79
p_up = .502
p_down = abs(1 - p_up)
g_up = 1.01
g_down = .99
strike = 172.50



#creating a table of random uniform probabilities
up_down <- as.data.frame(rbinom(30, 1, p_up))
colnames(up_down)[1] <- "up or down"



#creating a new column for whether or not the stock would go up/down based on the probability
#up_down$'up or down' <- 0

#for (i in 1:nrow(up_down)){
#  if(up_down[i,1] >= p_up){
#    up_down[i,2] = 1
#    
#  }
#}



#building a dataset for simulations for 30 periods
simulation <- up_down %>%
  mutate(stock_price = 0)

simulation <- rbind(c(NA, s0), simulation)

for (i in 2:nrow(simulation)){
  if(simulation[i,1] == 1){
    simulation[i,2] <- simulation[i-1,2] * g_up
  }
  else{simulation[i,2] <- simulation[i-1,2] * g_down}
}



#calculating the payoff for the call option
payoff <- max(c(simulation[31,2]-strike, 0))



#simulating 100,000 times RIP
all_payoffs <- data.frame("simulation" = 1:100000, "payoffs" = 0)

for(i in 1:100000){
  d <- i
  d <- as.data.frame(rbinom(30, 1, p_up))
  colnames(d)[1] <- "up or down"
  
  simulation_n <- d %>%
    mutate(stock_price = 0)
  
  simulation_n <- rbind(c(NA, s0), simulation_n)
  
  for (y in 2:nrow(simulation_n)){
    if(simulation_n[y,1] == 1){
      simulation_n[y,2] <- simulation_n[y-1,2] * g_up
    }
    else{simulation_n[y,2] <- simulation_n[y-1,2] * g_down}
  }
  
  payoff <- max(c(simulation_n[31,2]-strike, 0))
  
  
  all_payoffs[i, 2] <- payoff
}

average_payoff <- mean(all_payoffs$payoffs)




