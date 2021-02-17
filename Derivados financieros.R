# DERIVADOS FINANCIEROS 
library(quantmod)
simbolos=c("F","TSLA","GM")
getSymbols(simbolos,src="yahoo",from="2018-02-11",to="2021-02-17")
par(mfrow=c(2,1)) # para mostrar dos graficos a la vez
plot(TSLA$TSLA.Open,main="TSLA",xlab="dates",ylab="Price")
plot(GM$GM.Open,main="GM",xlab="dates",ylab="Price")

