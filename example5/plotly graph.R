graphBinom <- function(x, totaln) {
  pbin <- pbinom(1:totaln, size=totaln, prob=0.5)
  prev <- c(0, pbin[-length(pbin)])
  indiv <- pbin-prev
  cols <- rep("blue", totaln)
  cols[x] <- "red"
  #xval <- barplot(indiv, col=cols, xlab="# of Successes", ylab="Probability")
  #axis(1, xval, labels=1:totaln)
  plot_ly(x=1:totaln, y=indiv, name="Interactive Graph", type="bar", marker=list(color=toRGB(cols))) %>% 
  layout(xaxis=list(title="# of Successes"), 
         yaxis=list(title="Probability"))
}  

graphBinom(12, 30)

