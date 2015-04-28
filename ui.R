library(shiny)

fluidPage(
  
  titlePanel("Fremont Bridge Bicycle Counts"),
  
  sidebarPanel(
    radioButtons("weekday", NULL, c("All days", "Weekdays", "Weekends"))
  ),
  
  mainPanel(
    ggvisOutput('plot')
  )
)