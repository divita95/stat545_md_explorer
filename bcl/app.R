#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)




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
        sidebarPanel("This text is in the sidebar."),
        mainPanel(
            plotOutput("price_hist"),
            tableOutput("price_table")
        )
    )
   

    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
    output$price_table <- renderTable(bcl)
   
}

# Run the application 
shinyApp(ui = ui, server = server)
