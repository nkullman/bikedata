#clean the merged bike and weather frame
#and write in R's binary format

fremont = read.csv("FremontBikeAndWeatherData.csv")

fremont = fremont[!is.na(fremont$CyclistCount),c(-1,-(8:24),-(26:28))] #remove some NAs and an index col
fremont$Date = as.Date(fremont$Date, "%Y-%m-%d")

fremont$IsWeekday = (fremont$IsWeekday == "False") #convert from (backwards) factor to logical
fremont$daynum = as.integer(format(fremont$Date, "%j"))-1
write.csv(fremont, file="fremont.csv")
