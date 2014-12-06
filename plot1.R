#load entire dataset with date and time as character and all other as numeric
#indicate that "?" represents NA
classes = c("character","character",rep("numeric",7))
data <- read.table("household_power_consumption.txt",header=T,sep=";", colClasses=classes, na.strings="?")

#convert the Date column from character to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset data by date
data2 <- subset(data, as.Date("2007-02-01") == Date | as.Date("2007-02-02") == Date)

#open a PNG device and make a histogram, then close the PNG device
png("plot1.png", width = 480, height = 480)
hist(data2$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()