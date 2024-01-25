# Install and load required packages if not already installed
if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}

library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Discounted Cash Flow (DCF) Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("initial_investment", "Initial Investment ($)", value = 500),
      numericInput("discount_rate", "Discount Rate (%)", value = 10),
      textInput("cash_flows", "Cash Flows (comma-separated)", value = "60,70,80,90,100"),
      actionButton("calculate_button", "Calculate")
    ),
    mainPanel(
      h4("Results:"),
      textOutput("npv_output")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  observeEvent(input$calculate_button, {
    # Parse user inputs
    initial_investment <- as.numeric(input$initial_investment)
    discount_rate <- as.numeric(input$discount_rate) / 100
    cash_flows <- as.numeric(strsplit(input$cash_flows, ",")[[1]])
    
    # Calculate NPV
    npv <- sum(cash_flows / (1 + discount_rate)^(1:length(cash_flows))) - initial_investment
    
    # Display the results
    output$npv_output <- renderText(paste("Net Present Value (NPV):", round(npv, 2)))
  })
}

# Run the app
shinyApp(ui = ui, server = server)




    