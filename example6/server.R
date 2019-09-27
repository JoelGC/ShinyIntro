### File: 			  ui.R
### Date: 		 	  02Sep2016
### Author:		    Joel Chaney (P&G Quantitative Sciences)
### Description: 	This program is one of two files comprising a Shiny app for demonstrating the ability to upload and display data in an interactive data table.

library(shiny)
shinyServer(function(input, output) {
  output$contents <- renderDataTable({
    inFile <- input$file1
    if (is.null(inFile))  return(NULL)
    if (!is.null(inFile)) {
      indata <- read.csv(inFile$datapath, header=input$header)
  	  return(indata)
    }  
  })
})
