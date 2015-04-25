library(shiny)
library(ggplot2)

fluidPage(
  
  titlePanel("Fremont Bridge Bicycle Counts"),
  
  sidebarPanel(
    selectInput('color', 'Color', c('None', 'Direction'))
  ),
  
  mainPanel(
    plotOutput('plot')
  )
)