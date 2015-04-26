# Retrieves weather data
#	Location: KBFI (Boeing Field)
#	Dates: Oct 1, 2012 - Apr 23, 2015
install.packages("weatherData")
library("weatherData")

# Get (first batch of) weather data
fremontWeatherData <- getSummarizedWeather(station_id = "KBFI",
                                        start_date = "2012-10-01",
                                        end_date = "2015-04-23",
                                        opt_all_columns = TRUE,
                                        opt_verbose = TRUE)
# Request not filled completely. Last day of weather data retrieved:
lastDay <- toString(tail(fremontWeatherData$Date, n=1))

# Loop to fulfill entire request
while (lastDay != "2015-04-23") {
  moreWeatherData <- getSummarizedWeather(station_id = "KBFI",
                                          start_date = lastDay,
                                          end_date = "2015-04-23",
                                          opt_all_columns = TRUE,
                                          opt_verbose = TRUE);
  # Update last day rec'd
  lastDay <- toString(tail(moreWeatherData$Date, n=1));
  
  # Some discrepancy in column names between data pulls ('PDT' vs 'PST') requires the following:
  names(moreWeatherData) <- names(fremontWeatherData);
  
  # Append new weather data to existing dataframe (skipping duplicate entry for lastDay)
  fremontWeatherData <- rbind(fremontWeatherData, moreWeatherData[2:nrow(moreWeatherData),]);
  
}
										
# Write output to file
write.csv(fremontWeatherData, file = "FremontWeatherData_Daily_raw.csv")
