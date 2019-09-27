### File: 			  ui.R
### Date: 		 	  01Sep2016
### Author:		    Joel Chaney (P&G Quantitative Sciences)
### Description: 	This program is one of two files comprising a Shiny app for conducting a one sample proportion test (exact binomial test).

library(shiny)
shinyUI(fluidPage(
	titlePanel("Test for One Proportion (Exact Binomial Test)"),
  sidebarLayout(
		# Sidebar with controls to select the # of successes, sample size, confidence level and alternative hypothesis
		sidebarPanel(
			p("Enter the number of \"successes\" and the total sample size for a single group below, and enter the desired confidence level and alternative hypothesis 
				(i.e., statement you would like to make).  The table to the right will be automatically updated with the statistical test results.  This table can be downloaded
				in .csv format by clicking on the \"Download the Results\" button."),
      fluidRow(
			  column(6, numericInput("s1", "# of Successes:", 12)),
			  column(6, numericInput("t1", "Total Sample Size:", 30))
      ),			
			sliderInput("confid", "Confidence Level (%):", 50, 99, 95, 1), 
			radioButtons("testType", "Alternative Hypothesis:", c("proportion of successes is not equal to 0.5"="two.sided", "proportion of successes is less than 0.5"="less", 
				"proportion of successes is greater than 0.5"="greater"))
		),
    # Show the results table and download button
		mainPanel(
      br(),
		  tableOutput("stats"),
			br(),
			plotOutput("graph"),
			downloadButton('downloadResults', 'Download the Results'),
			br(),
			br(),
			br(),
			p("This web tool was created by QS-Informatics.  Contact Joel Chaney (chaney.jg) with any comments or questions."),
			img(src="QSstacked.png", height=100)
		)
	)
))
