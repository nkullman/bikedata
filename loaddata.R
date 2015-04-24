#reads raw data from data.seattle.gov and gives well-formated R data frame
library(reshape)

fremont <- read.csv("Fremont_Bridge_Hourly_Bicycle_Counts_by_Month_October_2012_to_present.csv", stringsAsFactors=FALSE)
fremont = fremont[complete.cases(fremont),] #remove some NAs

fremont = data.frame(fremont[,-1], Date=as.Date(fremont$Date, "%m/%d/%Y"), Time=substring(fremont$Date, 12))
colnames(fremont)[c(1,2)] = c("NB", "SB")
fremont = melt(fremont, id.vars=c("Date","Time"))
colnames(fremont)[c(3,4)] = c("Direction", "Count")
