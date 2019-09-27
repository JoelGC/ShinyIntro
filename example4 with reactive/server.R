### File: 			  server.R
### Date: 		 	  01Sep2016
### Author:		    Joel Chaney (P&G Quantitative Sciences)
### Description: 	This program is one of two files comprising a Shiny app for conducting a one sample proportion test (exact binomial test).

library(shiny)
shinyServer(function(input, output) {
  altHypothesisLabel <- reactive({ ifelse(input$testType=="two.sided", "Not Equal", ifelse(input$testType=="less", "Less Than", "Greater Than")) })
  propTest <- reactive({
    # wait for no good reason other than to demonstrate the "reactive" function
    Sys.sleep(10)
    # now do the analysis
    results <- binom.test(input$s1, input$t1, conf.level=input$confid/100, alternative=input$testType)
	  s1 <- sprintf("%1.0f", input$s1)
	  t1 <- sprintf("%1.0f", input$t1)
	  s2 <- sprintf("%1.0f", input$t1 - input$s1)
	  prop1 <- sprintf("%1.3f", input$s1/input$t1)
	  prop2 <- sprintf("%1.3f", (input$t1 - input$s1)/input$t1)
	  propdiff <- sprintf("%1.3f", input$s1/input$t1 - (input$t1 - input$s1)/input$t1)
	  pvalue <- sprintf("%1.4f", results$p.value)
    c1 <- sprintf("%1.3f", results$conf.int[1])
	  c2 <- sprintf("%1.3f", results$conf.int[2])
	  clevel <- paste0(sprintf("%1.0f", input$confid), "%")
	  out <- data.frame(paste0(prop1, "  (", s1, "/", t1, ")"), paste0(prop2, "  (", s2, "/", t1, ")"), pvalue, c1, c2, altHypothesisLabel(), clevel)
	  names(out) <- c("Success Proportion", "Failure Proportion", "p", "Success Proportion Lower CL", "Success Proportion Upper CL", "Alternative Hypothesis", "Confidence Level")
	  return(out)
  })
  graphBinom <- function(x, totaln) {
    pbin <- pbinom(1:totaln, size=totaln, prob=0.5)
    prev <- c(0, pbin[-length(pbin)])
    indiv <- pbin-prev
    cols <- rep("blue", totaln)
    cols[x] <- "red"
    xval <- barplot(indiv, col=cols, xlab="# of Successes", ylab="Probability")
    axis(1, xval, labels=1:totaln)
  }  
  output$stats <- renderTable({ propTest() }, align=rep("c", 8), include.rownames=FALSE)
  output$graph <- renderPlot({ graphBinom(input$s1, input$t1) })
  output$downloadResults <- downloadHandler(
    filename = "output.csv",
    content = function(file) {
      write.csv(propTest(), file, row.names=FALSE)
    }
  )
})
