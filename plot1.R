## plot1.R
## for coursera homework - exploratory data analysis peer review
## by John Sullivan
##

# Define libaries for fast 'n' easy data manipulation in Data Tables

library(data.table)
library(dplyr)

if (!exists('epc_data')) {
    
    ## Prepare the data table if it's missing
    
    # Download and unzip the file if needed
    if (!file.exists('./data/household_power_consumption.txt'))  {
        download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
                , dest="./data/household_power_consumptions.zip") 
        unzip ("./data/household_power_consumptions.zip", exdir = "./data")
    }
    # Read in the data table 
    epc_data <- fread('./data/household_power_consumption.txt',na.strings='?')
    
    # Cut down to the two days we need
    epc_data <- filter(epc_data, Date %in% c('2/2/2007','1/2/2007'))
    
    # Format the DateTime
    epc_data <- mutate(epc_data, DateTime = as.POSIXct(strptime(paste(Date,Time),"%e/%m/%Y %H:%M:%S")))
}

##plot1
png('./data/plot1.png') #open png device for write, default size is 480x480 pixels
hist(epc_data$Global_active_power, col="red", main="Global Active Power",
        xlab = 'Global Active Power (kilowatts',ylab='Frequency')
dev.off() #close the png file device.
