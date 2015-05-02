#clean the merged bike and weather frame
#and write in R's binary format

fremont = read.csv("FremontBikeAndWeatherData.csv")

fremont = fremont[!is.na(fremont$CyclistCount),c(-1,-(8:24),-(26:28))] #remove some NAs and an index col
fremont$Date = as.Date(fremont$Date, "%Y-%m-%d")

fremont$IsWeekday = (fremont$IsWeekday == "False") #convert from (backwards) factor to logical
fremont$daynum = as.integer(format(fremont$Date, "%j"))-1

#Convert time strings to integers
times = c("12:00:00 AM", "01:00:00 AM", "02:00:00 AM", "03:00:00 AM", "04:00:00 AM", "05:00:00 AM", "06:00:00 AM",
          "07:00:00 AM", "08:00:00 AM", "09:00:00 AM", "10:00:00 AM", "11:00:00 AM", "12:00:00 PM","01:00:00 PM", "02:00:00 PM", "03:00:00 PM", "04:00:00 PM", "05:00:00 PM", "06:00:00 PM", "07:00:00 PM", "08:00:00 PM", "09:00:00 PM", "10:00:00 PM", "11:00:00 PM")
fremont$Time = factor(fremont$Time, levels=times, labels=0:23);
write.csv(fremont, file="fremont.csv")
