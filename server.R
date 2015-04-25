library(shiny)
library(ggplot2)

dataset = reactive({readRDS("fremont.rds")})

function(input, output) {
  
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x="Time", y="Count", group=1)) +
      stat_summary(fun.y=mean, geom="line", size=1)
    
    if (input$color != 'None')
      p <- p + aes_string(group=input$color, color=input$color)
    
    print(p)
    
  }, height=700)
  
}