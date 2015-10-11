library(lubridate)
library(lattice)
library(ggplot2)
# Rough estimate of size- formula= no of rows* no of columns*8 bytes/2^20
##= 2,075,259 rows * 9 columns*8/2^20=142 Mb approximatly (which is sufficient
## given that i have a state of art robust 220 Gig system :)


## recheck: obj size =258083544


# Reading File
data_file<-file("household_power_consumption.txt")

# Ensuring that the value of Date is between  2007-02-01 and 2007-02-02
# while reading the data from the file
data <- read.table(text = grep("^[1,2]/2/2007", readLines(data_file), 
                   value = TRUE), col.names = 
                  c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                  "Sub_metering_1", "Sub_metering_2", 
                  "Sub_metering_3"), sep = ";", header = TRUE, na.strings = "?"
                  ,check.names = F, 
                  stringsAsFactors = F, comment.char = "", quote = '\"')
# Converting Time and Date into Time and date ( currently they
# have been read as factor variables while reading data)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Creating Plot-4
png(file="plot4.png",width = 480, height = 480,units="px")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
  plot(Global_active_power ~ Datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})
dev.off()