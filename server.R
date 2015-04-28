library(shiny)
library(dplyr)
library(ggvis)

fremont = readRDS("fremont.rds")

function(input, output) {
  
  dataset = reactive({
    if (input$weekday == "Weekdays")
    {
      df = fremont[fremont$IsWeekday,]
    } else if (input$weekday == "Weekends")
    {
      df = fremont[!fremont$IsWeekday,]
    } else {
      df = fremont
    }
    df %>% group_by(Time, Direction) %>% summarize(CyclistCount=mean(CyclistCount))
    })
  
    
   p <- reactive({dataset %>% 
                    ggvis(x=~Time, y=~CyclistCount) %>% 
                    group_by(Direction) %>% 
                    layer_lines(stroke=~Direction)
   })
    
   p %>% bind_shiny("plot")
}