library(ggplot2)
install.packages("tseries")
library("tseries")
install.packages("readr")
library("readr")
library("plyr")
Bancolombia <- read_csv("C:/Users/jhona/Desktop/Brayan/Github/Derivados-Financieros/Bases de datos/Datos históricos BIC.csv", 
                       col_types = cols(Fecha = col_date(format = "%d.%m.%Y"), 
                                        Último = col_number(), Apertura = col_number()))

GrupoArgos <- read_csv("C:/Users/jhona/Desktop/Brayan/Github/Derivados-Financieros/Bases de datos/Datos históricos ARG.csv", 
                      col_types = cols(Fecha = col_date(format = "%d.%m.%Y"), 
                                       Último = col_number(), Apertura = col_number()))
                        
#base de datos como serie de tiempo 
FechaBancolombia <- ts(Bancolombia$Fecha, start=2016, frequency=12)
FechaGrupoArgos <- ts(GrupoArgos$Fecha, start=2016, frequency=12)

plot(Bancolombia$Último, xlab='FechaBancolombia',type="l",main ='Bancolombia',col='red')
plot(GrupoArgos$Último, xlab='FechaGrupoArgos',type="l",main ='Grupo Argos',col='blue')


summary(Bancolombia)
summary(GrupoArgos)


RetornoIndiceBancolombia<-diff(log(Bancolombia$Último))
head(RetornoIndiceBancolombia,10)

RetornoIndiceGrupoArgos<-diff(log(GrupoArgos$Último))
head(RetornoIndiceGrupoArgos,10)


plot(RetornoIndiceBancolombia, main=" ", col="deepskyblue", xlab="Fecha", ylab="Rendimientos",type="l")
plot(RetornoIndiceGrupoArgos, main=" ", col="red", xlab="Fecha", ylab="Rendimientos",type="l")

#creamos el portafolio 
CarteraInv <- merge(Bancolombia,GrupoArgos, all = FALSE) 
names(CarteraInv)

plot(CarteraInv, main=" ", col="deepskyblue",xlab="Fecha")



var(RetornoIndiceBancolombia)*100
var(RetornoIndiceGrupoArgos)*100

Cov <- cov(Bancolombia)*100






