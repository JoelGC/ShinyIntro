### File: 			  ui.R
### Date: 		 	  02Sep2016
### Author:		    Joel Chaney (P&G Quantitative Sciences)
### Description: 	This program is one of two files comprising a Shiny app for demonstrating the ability to upload and display data in an interactive data table.

library(shiny)
shinyUI(fluidPage(
	titlePanel("Data Viewer"),
  sidebarLayout(
		sidebarPanel(
			fileInput("file1", "Choose a .csv file", multiple=FALSE, accept=".csv"),
			tags$hr(),
			checkboxInput("header", "Check if the first row is a header", TRUE)
		),
		mainPanel(
			dataTableOutput("contents")
		)
	)
))
