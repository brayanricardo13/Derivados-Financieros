install.packages("quantmod")
library("quantmod") 
install.packages("fOptions")
library("fOptions") 
install.packages("FinancialMath")
library("FinancialMath")
install.packages("pacman")
library("pacman")


opciones <- getOptionChain("ORCL",Exp="2021-05-07",src ="yahoo")

calls <- opciones$calls[,c(1:2,4:6)] # Nos quedamos con las columnas del 1 al 2 y del 4 al 6.
puts  <- opciones$puts[,c(1:2,4:6)] # Nos quedamos con las columnas del 1 al 2 y del 4 al 6.

getSymbols("ORCL", from = "2015-05-07", to = "2021-05-07", periodicity = "daily")

## [1] "ORCL"

rcl <- as.data.frame("ORCL") %>%  # a data.frame 
  mutate(ret = log(ORCL.Adjusted/lag(ORCL.Adjusted))) %>%  # construimos el retorno
  select(ORCL.Adjusted,ret) %>% # Seleccionamos el retorno y precio de ajuste
  na.omit() # por el NA que se produce del retorno

# extraemos el precio a la fecha que nos piden
precio <- tail(orcl$ORCL.Adjusted,1)




