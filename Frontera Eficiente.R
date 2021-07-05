install.packages("tseries")
library(tseries)
install.packages("fPortfolio")
library(fPortfolio)
install.packages("knitr")
library(knitr)
install.packages("kableExtra")
library(kableExtra)
install.packages("gplots")
library(gplots)


AAPL<- get.hist.quote(instrument = "AAPL", 
                      start=as.Date("2010-01-04"), 
                      end=as.Date("2021-06-09"), quote = "AdjClose")

AMD<- get.hist.quote(instrument = "AMD", 
                    start=as.Date("2010-01-04"), 
                    end=as.Date("2021-06-09"), quote = "AdjClose")


IDT<- get.hist.quote(instrument = "IDT", 
                    start=as.Date("2010-01-04"), 
                    end=as.Date("2021-06-09"), quote = "AdjClose")

SLM<- get.hist.quote(instrument = "SLM", 
                     start=as.Date("2010-01-04"), 
                     end=as.Date("2021-06-09"), quote = "AdjClose")

SPG<- get.hist.quote(instrument = "SPG", 
                     start=as.Date("2010-01-04"), 
                     end=as.Date("2021-06-09"), quote = "AdjClose")

O<- get.hist.quote(instrument = "O", 
                     start=as.Date("2010-01-04"), 
                     end=as.Date("2021-06-09"), quote = "AdjClose")



CarteraInv <- merge(AAPL,AMD,IDT,SLM,SPG,O, all = FALSE) 
names(CarteraInv)


names(CarteraInv)<-c("AAPL","AMD","IDT", "SLM", "SPG","O")
plot(CarteraInv, main=" ", col="deepskyblue", xlab="Fecha")
title(main="Histórico de Cartera")

Rendimientos<-diff(log(CarteraInv))
head(Rendimientos,10)

plot(Rendimientos, main=" ", col="deepskyblue", xlab="Fecha")
title(main="Rendimientos de la Cartera")

Cov <- cov(Rendimientos)*100
Cov

corr <- cor(Rendimientos) * 100
corr


generate_heat_map <- function(correlationMatrix, title)
{
  
  heatmap.2(x = correlationMatrix,    
            cellnote = correlationMatrix,   
            main = title,           
            symm = TRUE,            
            dendrogram="none",      
            Rowv = FALSE,           
            trace="none",           
            density.info="none",        
            notecol="black")          
}
corr1 <- round(cor(Rendimientos) * 100, 2)
generate_heat_map(corr1,"Mapa de calor: Correlaciones")


markov<-portfolioSpec()

setRiskFreeRate(markov)<- -0.001 #Tasa libre de riesgo
setNFrontierPoints(markov) <- 20 #Cantidad de carteras en frontera

constraints="LongOnly"

Frontera <- portfolioFrontier(as.timeSeries(Rendimientos),spec=markov,constraints )
Frontera


frontierPlot(Frontera)
grid()
tangencyPoints(Frontera, pch = 19, col = "red", cex=2)
tangencyLines(Frontera, col="grey", pch=19, cex=2)
minvariancePoints(Frontera, col="blue", pch=19, cex=2)
monteCarloPoints(Frontera, mCsteps=2000, col="#0098D5", cex=0.001)


col <- qualiPalette(ncol(Rendimientos), "Pastel1")
weightsPlot(Frontera, col=col)



efPortfolio <- efficientPortfolio(as.timeSeries(Rendimientos),markov,constraints)
efPortfolio


weightsPie(efPortfolio, col=col )
mtext(text = "Portafolio eficiente", side = 3, line = 1.5,
      font = 2, cex = 0.7, adj = 0)















