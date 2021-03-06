## plot4.R
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


##plot4
png('./data/plot4.png') #open png device for write, default size is 480x480 pixels
#set the 2x2 plot grid
par(mfcol=c(2,2),mar=c(4,4,2,2),lheight = 0.5)
#plot 4a
plot(epc_data$DateTime,epc_data$Global_active_power,type = 'l',xlab='',
     ylab='Global Active Power')
#plot 4b
plot(epc_data$DateTime,epc_data$Sub_metering_1,type = 'l',xlab='',ylab='Energy sub metering')
lines(epc_data$DateTime,epc_data$Sub_metering_2, col='red')
lines(epc_data$DateTime,epc_data$Sub_metering_3, col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       bty='n',lty=1,col=c('black','red','blue'))
#plot 4c
with(epc_data,plot(DateTime,Voltage,type = 'l'))
#plot 4d
with(epc_data,plot(DateTime,Global_reactive_power,type = 'l'))
dev.off() #close the png file device.
