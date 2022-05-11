#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rmarkdown)
library(DBI)
library(odbc)
library(tidyverse)
library(shinythemes)

# UI
# Application title
title  <- "Deceased Donor Assessment Report" %>% 
  titlePanel()

# Sidebar  
side   <- list(textInput("MRN", "Patient MRN"), 
               textInput("DonorID", "Donor ID"), 
               actionButton("validate", "Validate pair"), 
               downloadButton("report", "Generate report")) %>%   
          sidebarPanel()

# Main
main   <- list(h3("Recipient/Donor Pair"), 
               tableOutput("Patient") 
               ) %>% 
        mainPanel()


# Combine sidebar and main panels into layout
layout <- sidebarLayout(side, 
                        main)

# Define UI for application 
ui     <- fluidPage(title, 
                    layout,
                    hr(),
                    print("HUP HLA lab deceased donor assessment report V5.0. 
                          Enter the patient's MRN and the donor ID above. 
                          Press the \"validate pair\" button to verify the inputs, 
                          then hit the \"generate report\" button to create a PDF. 
                          Note that the PDF may take a minute to generate, 
                          and the status bar may not be accurate."),
                    #shinythemes::themeSelector(),
                    theme=shinytheme("cerulean")
                    )


# Server
server = function(input, output) {
  
  # This is the reactive part - it generates a table when the validate button is pressed
  Patient <- eventReactive(input$validate, {
    
    # Creating a connection to the HistoTrac server
    con <- dbConnect(odbc::odbc(), "HistoTrac", timeout = 10)
    on.exit(dbDisconnect(con), add = TRUE)
    
    # Extracting the inputs to pass to the SQL server
    HospID <- input$MRN
    DonID <- input$DonorID
    
    # Querying the HistoTrac server for the patient and donor entered
    tbl(con, "Patient") %>% 
      select(HospitalID, firstnm, lastnm, DOB) %>% 
      filter(HospitalID == HospID | firstnm == DonID) %>% 
      as_tibble %>% 
      mutate(DOB = format(DOB, '%m-%d-%Y')) %>% 
      rename(MRN = HospitalID, First = firstnm, Last = lastnm) %>% 
      mutate(Case = "", .before = MRN) %>% 
      mutate(Case = case_when(
        MRN == HospID ~ "Patient",
        First == DonID ~ "Donor"
      ))
  })
  
  # Displaying a table of the HistoTrac results
  output$Patient <- renderTable(Patient(), bordered = FALSE, striped = TRUE, rownames = FALSE)
  
  # This is the part that knits the RMarkdown report and saves it to a PDF
    output$report <- downloadHandler(
      filename = "report.pdf",
      content = function(file) {
        withProgress(message = 'Generating report', value = 1, {
        # Copy the report file to a temporary directory before processing it, in
        # case we don't have write permissions to the current working dir (which
        # can happen when deployed).
        tempReport <- file.path(tempdir(), "temp.rmd")
        file.copy("Deceased-donor-VXM-report.V5.0.rmd", tempReport, overwrite = TRUE)
        
        # Set up parameters to pass to Rmd document
        params <- list(
          MRN_patient = input$MRN,
          First_name_donor = input$DonorID
          )
        
        # Knit the document, passing in the `params` list, and eval it in a
        # child of the global environment (this isolates the code in the document
        # from the code in this app).
        rmarkdown::render(tempReport, 
                          output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )
        })
      }
    )
  }


# Run the application 
shinyApp(ui = ui, server = server)
