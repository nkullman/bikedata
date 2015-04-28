library(shiny)
library(ggvis)

fluidPage(
  
  titlePanel("Fremont Bridge Bicycle Counts"),
  
  sidebarPanel(
    radioButtons("weekday", NULL, c("All days", "Weekdays", "Weekends")),
    sliderInput("temp", "High Temperature", 30, 95, c(30,95), step=1, ticks=TRUE, animate=animationOptions(interval=250))
  ),
  
  mainPanel(
    ggvisOutput('plot')
  )
)