
df <- read.table("/Users/user/Downloads/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
 sub_df <- subset(df, Date=="1/2/2007" | Date =="2/2/2007")
sub_df$Date<-as.Date(sub_df$Date, format = "%d/%m/%Y")
sub_df$DateTime<-strptime(paste(sub_df$Date,sub_df$Time),"%F %T")

Graph 1 

png("plot1.png", width=480, height=480)
hist(subdt$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

Graph 2

png("plot2.png", width=480, height=480)
plot(subdt$DateTime,subdt$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", type="l")
dev.off()

Graph 3


png("plot3.png", width=480, height=480)
plot(subdt$DateTime,subdt$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(subdt$DateTime,subdt$Sub_metering_2, col="red", type="l")
points(subdt$DateTime,subdt$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(subdt[,7:9]))
dev.off()

Graph 4
Combination of 4 plots: global active power, energy sub meterings, voltage over time, global reactive power over time

png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))
# Plot 4.1
plot(subdt$DateTime, subdt$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
# Plot 4.2
plot(subdt$DateTime, subdt$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(subdt$DateTime, subdt$Sub_metering_2, col="red", type="l")
points(subdt$DateTime, subdt$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(subdt[,7:9]), bty="n")
# Plot 4.3
plot(subdt$DateTime, subdt$Voltage, ylab="Voltage", xlab="datetime", type="l")
# Plot 4.4
plot(subdt$DateTime, subdt$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
dev.off()
