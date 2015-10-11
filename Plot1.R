library(lubridate)

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
                    "Sub_metering_3"), sep = ";", header = TRUE,na.strings = "?")
# Converting Time and Date into Time and date ( currently they
# have been read as factor variables while reading data)

data$Time<-strptime(data$Time,format="")
data$Date<-as.Date(data$Date)

## Creating Plot-1
png(file="plot1.png",width = 480, height = 480,units="px")
hist(data$Global_active_power, col="red",main="Global Active Power",
     xlab="Global Active Power(kilowatts)",mar=c(2,2,0,0))
dev.off()