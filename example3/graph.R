graphBinom <- function(x, totaln) {
  pbin <- pbinom(1:totaln, size=totaln, prob=0.5)
  prev <- c(0, pbin[-length(pbin)])
  indiv <- pbin-prev
  cols <- rep("blue", totaln)
  cols[x] <- "red"
  xval <- barplot(indiv, col=cols, xlab="# of Successes", ylab="Probability")
  axis(1, xval, labels=1:totaln)
}  

graphBinom(7, 10)
