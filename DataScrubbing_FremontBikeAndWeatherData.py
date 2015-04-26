
# coding: utf-8

# In[103]:

import pandas
import numpy
import pylab

from pandas import *
from pylab import *


# In[104]:

# Read in raw weather CSV
fwd = read_csv("FremontWeatherData_Daily_raw.csv")


# In[105]:

# Eliminate unnecessary columns: index ('unnamed...') and 'PDT'
fwd = fwd.drop(["Unnamed: 0", "PDT"], axis=1)


# In[106]:

# Convert "Date" to datetime format for merging
fwd["Date"] = pandas.to_datetime(fwd["Date"])


# In[107]:

# Write formatted weather data to file
fwd.to_csv('FremontWeatherData_Daily.csv')


# In[108]:

# Desired end-result is merged dataset with bike and weather data
# Weather data formatting is completed.
# Now we begin formatting bike data.
# Desired columns:
    # "Date", "Time", "Direction", "Count"
    

# Import bike data...
fbd = read_csv("Fremont_Bridge_Hourly_Bicycle_Counts_by_Month_October_2012_to_present.csv")


# In[109]:

# Split date into date and time columns
fbd["Time"] = fbd["Date"].map(lambda x: x[x.index(" ") + 1:])
fbd["Date"] = fbd["Date"].map(lambda x: x[:x.index(" ")])


# In[110]:

# Reorder columns
fbd = fbd[["Date", "Time", "Fremont Bridge NB", "Fremont Bridge SB"]]


# In[111]:

# Convert "Date" to datetime format for merging
fbd["Date"] = pandas.to_datetime(fbd["Date"])


# In[112]:

# Melt the two count columns
fbd = pandas.melt(fbd,
                id_vars = ['Date', 'Time'],
                var_name = 'Direction',
                value_name = 'CyclistCount')


# In[113]:

# Simplify the entries in the "Direction" column
fbd["Direction"] = fbd["Direction"].map(lambda x: x[x.rfind(" "):])


# In[114]:

# Add boolean column for weekday/weekend state
fbd["IsWeekend"] = fbd["Date"].map(lambda x: x.weekday() >= 5)


# In[115]:

# Formatting of bike data complete.
# Dataframes ready for merge.
fwabd = merge(fbd, fwd, on = "Date", how = "inner")


# In[116]:

# Post-merge:
# Convert date column string
fwabd["Date"] = fwabd["Date"].map(lambda x: x.strftime('%Y-%m-%d'))


# In[117]:

# Convert cyclist count column to int
fwabd["CyclistCount"] = fwabd["CyclistCount"].fillna(0)
fwabd["CyclistCount"] = fwabd["CyclistCount"].astype(int)


# In[118]:

# Convert NA entries in "Events" to "None"
fwabd["Events"] = fwabd["Events"].fillna("None")


# In[119]:

# Convert NA entries in max gust column to 0
fwabd["Max_Gust_SpeedMPH"] = fwabd["Max_Gust_SpeedMPH"].fillna(0)


# In[120]:

# Done.
# Write merged dataset to file:
fwabd.to_csv("FremontBikeAndWeatherData.csv")

