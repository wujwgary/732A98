library(shiny)
library(ggplot2)

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


##############################
##############################
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


##############################
##############################

myfunction<-function(){
  library(miniUI)
  ui<-miniPage(gadgetTitleBar("AAA"),
               miniContentPanel(
                 plotOutput(outputId = "myscat", click="plot_click"),
                 textOutput(outputId = "pr")
               )
  )
  
  server <- function(input, output) {
    v=reactiveValues(inp=list())
    output$myscat <- renderPlot({
      ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length))+geom_point()
    })
    observeEvent(input$done, {stopApp(v$inp)})
    output$pr <- renderText({
      print(input$plot_click$x)
      if(!is.null(input$plot_click))  v$inp$x=input$plot_click$x
    })
  }
  
  runGadget(ui, server)
}


Result=myfunction()
