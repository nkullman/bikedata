library(shiny)
library(dplyr)
library(ggvis)

fremont = readRDS("fremont.rds")

function(input, output) {
  
  dataset = reactive({
    #filter by weekday
    if (input$weekday == "Weekdays")
    {
      df = fremont[fremont$IsWeekday,]
    } else if (input$weekday == "Weekends")
    {
      df = fremont[!fremont$IsWeekday,]
    } else {
      df = fremont
    }
    
    #filter by temperature
    df = df[input$temp[1] <= df$Max_TemperatureF & df$Max_TemperatureF <= input$temp[2],]
    
    #filter by precipitation
    df = df[input$precip[1] <= df$PrecipitationIn & df$PrecipitationIn <= input$precip[2],]
    
    output$numdays = renderText({sprintf("Averaged over %d days", ceiling(dim(df)[1]/48))})
    
    #create aggregated dataframe to display
    df %>% group_by(Time, Direction) %>% summarize(CyclistCount=mean(CyclistCount))
    })
  
    
   p <- reactive({dataset %>% 
                    ggvis(x=~Time, y=~CyclistCount) %>% 
                    group_by(Direction) %>%
                    add_axis("x", properties = axis_props(labels=list(angle=30, align="left", fontSize=12)),
                             title_offset=60) %>%
                    add_axis("y", title="Average Bicycle Count", title_offset=50) %>%
                    layer_lines(stroke=~Direction, strokeWidth := 2) %>%
                    scale_numeric("y", domain=c(0, 550))
   })
    
   p %>% bind_shiny("plot")
}