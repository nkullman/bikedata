#reads raw data from data.seattle.gov and gives well-formated R data frame
library(reshape)

fremont <- read.csv("Fremont_Bridge_Hourly_Bicycle_Counts_by_Month_October_2012_to_present.csv", stringsAsFactors=FALSE)
fremont = fremont[complete.cases(fremont),] #remove some NAs

fremont = data.frame(fremont[,-1], Date=as.Date(fremont$Date, "%m/%d/%Y"), Time=substring(fremont$Date, 12))
colnames(fremont)[c(1,2)] = c("NB", "SB")
fremont = melt(fremont, id.vars=c("Date","Time"))
colnames(fremont)[c(3,4)] = c("Direction", "Count")

times = c("12:00:00 AM", "01:00:00 AM", "02:00:00 AM", "03:00:00 AM", "04:00:00 AM", "05:00:00 AM", "06:00:00 AM",
"07:00:00 AM", "08:00:00 AM", "09:00:00 AM", "10:00:00 AM", "11:00:00 AM", "12:00:00 PM","01:00:00 PM", "02:00:00 PM", "03:00:00 PM", "04:00:00 PM", "05:00:00 PM", "06:00:00 PM", "07:00:00 PM", "08:00:00 PM", "09:00:00 PM", "10:00:00 PM", "11:00:00 PM")
fremont$Time = factor(fremont$Time, levels=times)