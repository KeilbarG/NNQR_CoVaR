
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()
setwd("C:/Users/Georg_PC/Documents/Thesis/Final_20180626/Code")


# install and load packages
libraries = c("quantreg","qrnn","NeuralNetTools","quantmod","h2o","igraph")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
  install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)


# read data
data  = read.csv(file = "data.csv")
date  = as.Date(data[,1])
x0    = data[,-1]
VaR   = as.matrix(read.csv(file = "VaR.csv"))
CoVaR = as.matrix(read.csv(file = "CoVaR.csv"))


# plot returns, VaR and CoVaR for each bank
par(mfrow = c(4, 2), mar = c(2.5, 2, 3.5, 1))

for (j in 1 : ncol(x0)) {
  plot(x0[, j] ~ date, type = "p",
       ylim = c(min(x0[, j], CoVaR[, j]) * 1.1, max(x0[, j]) * 1.1),
       ylab = "", pch=".", cex = 3, main = colnames(x0)[j], cex.main = 2)
  lines(VaR[, j] ~ date, col = "blue", lwd = 2)
  lines(CoVaR[, j] ~ date, col = "red", lwd = 2)
}
