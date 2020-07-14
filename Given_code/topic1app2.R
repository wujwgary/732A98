
library(shiny)


ui <- fluidPage(
   actionButton(inputId = "add",label = "Add one class"),
   actionButton(inputId = "rem",label = "Remove one class"),
   plotOutput("densPlot")
)

server <- function(input, output) {
  nclass <- reactiveValues(n=1)
  observeEvent(input$add, {nclass$n <- nclass$n+1})
  observeEvent(input$rem, {nclass$n <- nclass$n-1})
   
   output$densPlot <- renderPlot({
     iris1=iris[as.numeric(iris$Species)<=nclass$n,]
     ggplot(iris1, aes(x=Sepal.Length,fill=Species))+
       stat_density()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

