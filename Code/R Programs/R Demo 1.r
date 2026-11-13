

library(tidyverse) #this is a library that contains most of what you need
carsdf <- sd2df('sashelp.cars')
carsAudi <- carsdf %>% filter(Origin == 'USA')
show(mean(carsAudi$Invoice, na.rm = TRUE),title = "average invoice for USA")
show(head(carsAudi), title = "Vehicles from USA");
df2sd(carsAudi, 'work.R_USA');