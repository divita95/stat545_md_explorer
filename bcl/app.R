#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)




# Define UI for application that draws a histogram
#"This is some text",
#br(),
#br(),
#"this is more text.",
#tags$h1("Level 1 header"),
#h1(em("Level 1 header, part2")),
#HTML("<h1>Level 1 header, part 3</h1>"),
#tags$blockquote("some text"),
#tags$div(`data-value` = "test"),
#tags$a(href="https://www.google.com/","Link to google!"),
#p(print(a))


bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
    titlePanel("BC Liquor price app", 
               windowTitle = "BCL app"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
            radioButtons("typeInput", "Select your desired beverage type",
                         choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                         selected = "WINE")
        ),
        mainPanel(
            plotOutput("price_hist"),
            tableOutput("price_table")
        )
    )
   

    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    observe(print(input$priceInout))
    bcl_filtered <- reactive({
        bcl %>% 
        filter( Price < input$priceInput[2],
                Price > input$priceInput[1],
                Type == input$typeInput)
    })
    output$price_hist <- renderPlot({
        bcl_filtered() %>% 
            ggplot(aes(Price)) +
            geom_histogram()
        })
    output$price_table <- renderTable({
        bcl_filtered()   
        }) 
   
} # curly brackets can be used with render function to run multiple lines of code.

# Run the application 
shinyApp(ui = ui, server = server)
