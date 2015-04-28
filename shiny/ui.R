library(shiny)
library(ggvis)

fluidPage(
  
  titlePanel("Fremont Bridge Bicycle Counts"),
  
  sidebarPanel(
    radioButtons("weekday", NULL, c("All days", "Weekdays", "Weekends")),
    sliderInput("temp", "High Temperature", 30, 95, c(30,95), step=1, ticks=TRUE),
    sliderInput("precip", "Total Precipitation", 0, 2.49, c(0, 2.49), step=.01, ticks=TRUE),
    textOutput("numdays")
  ),
  
  mainPanel(
    ggvisOutput('plot')
  )
)