
library(shiny)


ui <- fluidPage(
   sliderInput(inputId="ws", label="Choose bandwidth size", value=0.01, min=0.1, max=1),
   plotOutput("densPlot")
)

server <- function(input, output) {
   
   output$densPlot <- renderPlot({
     ggplot(iris, aes(x=Sepal.Length,fill=Species))+
       stat_density(alpha=0.8, bw=input$ws, position="identity")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

