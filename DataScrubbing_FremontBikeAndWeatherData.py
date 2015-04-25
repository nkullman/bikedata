
# coding: utf-8

# In[135]:

import pandas
import numpy
import pylab

from pandas import *
from pylab import *


# In[137]:

# Read in raw weather CSV
fwd = read_csv("FremontWeatherData_Daily_raw.csv")


# In[138]:

# Eliminate unnecessary columns: index ('unnamed...') and 'PDT'
fwd = fwd.drop(["Unnamed: 0", "PDT"], axis=1)


# In[139]:

# Convert "Date" to datetime format
fwd["Date"] = pandas.to_datetime(fwd["Date"])


# In[140]:

# Write formatted weather data to file
fwd.to_csv('FremontWeatherData_Daily.csv')


# In[141]:

# Desired end-result is merged dataset with bike and weather data
# Weather data formatting is completed.
# Now we begin formatting bike data.
# Desired columns:
    # "Date", "Time", "Direction", "Count"
    

# Import bike data...
fbd = read_csv("Fremont_Bridge_Hourly_Bicycle_Counts_by_Month_October_2012_to_present.csv")


# In[142]:

# Split date into date and time columns
fbd["Time"] = fbd["Date"].map(lambda x: x[x.index(" ") + 1:])
fbd["Date"] = fbd["Date"].map(lambda x: x[:x.index(" ")])


# In[143]:

# Reorder columns
fbd = fbd[["Date", "Time", "Fremont Bridge NB", "Fremont Bridge SB"]]


# In[144]:

# Convert "Date" to datetime format
fbd["Date"] = pandas.to_datetime(fbd["Date"])


# In[145]:

# Melt the two count columns
fbd = pandas.melt(fbd,
                id_vars = ['Date', 'Time'],
                var_name = 'Direction',
                value_name = 'CyclistCount')


# In[146]:

# Simplify the entries in the "Direction" column
fbd["Direction"] = fbd["Direction"].map(lambda x: x[x.rfind(" "):])


# In[150]:

# Formatting of bike data complete.
# Dataframes ready for merge.
fwabd = merge(fbd, fwd, on = "Date", how = "inner")


# In[151]:

# Write merged dataset to file:
fwabd.to_csv("FremontBikeAndWeatherData.csv")

