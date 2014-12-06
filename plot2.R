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

#open PNG device and generate plot
png("plot2.png", width = 480, height = 480)
#create empty plot using type="n" argument
plot(data2$DateTime, data2$Global_active_power, type="n", xlab="",ylab="Global Active Power (kilowatts)")
#add lines using staircase (type="s") representation
lines(data2$DateTime, data2$Global_active_power, type="s")
dev.off()