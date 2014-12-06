#load entire dataset with date and time as character and all other as numeric
#indicate that "?" represents NA
classes = c("character","character",rep("numeric",7))
data <- read.table("household_power_consumption.txt",header=T,sep=";", colClasses=classes, na.strings="?")

#convert the Date column from character to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset data by date
data2 <- subset(data, as.Date("2007-02-01") == Date | as.Date("2007-02-02") == Date)
#Make a combined DateTime variable in POSIXlt format and assign it to a new column
dateTime <- as.POSIXlt(do.call(paste,c(data2[c("Date","Time")])))
data2$DateTime <- dateTime

#open PNG device
png("plot4.png", width = 480, height = 480)
#set number of rows and columns to 2x2 plots
par(mfrow=c(2,2))
#generate the 4 required plots
plot(data2$DateTime, data2$Global_active_power, type="n", xlab="",ylab="Global Active Power")
lines(data2$DateTime, data2$Global_active_power, type="s")

plot(data2$DateTime, data2$Voltage, type="n", xlab="datetime",ylab="Voltage")
lines(data2$DateTime, data2$Voltage, type="s")

plot(data2$DateTime, data2$Sub_metering_1, type="n", xlab="",ylab="Energy sub metering")
lines(data2$DateTime, data2$Sub_metering_1, type="s")
lines(data2$DateTime, data2$Sub_metering_2, type="s", col="red")
lines(data2$DateTime, data2$Sub_metering_3, type="s", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, lwd=1, bty="n")

plot(data2$DateTime, data2$Global_reactive_power, type="n", xlab="datetime",ylab="Global_reactive_power")
lines(data2$DateTime, data2$Global_reactive_power, type="s")

dev.off()
