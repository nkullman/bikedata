library(shiny)
library(dplyr)
library(ggvis)

fremont = readRDS("fremont.rds")

function(input, output) {
  
  dataset = reactive({
    #filter by weekday
    if (input$weekday == "Weekdays")
    {
      df = fremont %>% filter(IsWeekday)
    } else if (input$weekday == "Weekends")
    {
      df = fremont %>% filter(!IsWeekday)
    } else {
      df = fremont
    }
    
    #filter by temperature and precipitation
    df = df %>% filter(input$temp[1] <= Max_TemperatureF, Max_TemperatureF <= input$temp[2]) %>%
      filter(input$precip[1] <= PrecipitationIn, PrecipitationIn <= input$precip[2])
    
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