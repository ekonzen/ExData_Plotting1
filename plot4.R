# plot 4

# Set the working directory

# Reading the original data
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE,
                   na.strings = "?",
                   colClasses=c("character", "character",rep("numeric",7) )
)

# Constructing a column with the date and the time information
data$Date_Time <- paste(data$Date, data$Time)
data$Date_Time <- strptime(data$Date_Time ,format = "%d/%m/%Y %H:%M:%S")

# Subsetting the data according to the date range between 2007-02-01 and 2007-02-02
data <- data[data$Date_Time >= "2007-02-01" & data$Date_Time < "2007-02-03",]

# Plotting the time series

week_days <- c("Thu", "Fri", "Sat")
date_range <- dim(data)[1]

par(mfrow=c(2,2))
# first plot
with(data, plot.ts(Global_active_power, col="black", 
                   ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab= NULL
)
)
axis(1, at=c(1, date_range/2+1, date_range+1), labels=week_days)

# second plot
ts.plot(data$Voltage, 
        gpars=list( xaxt = "n", xlab= "datetime", ylab = "Voltage")
        )
axis(1, at=c(1, date_range/2+1, date_range+1), labels=week_days)

# third plot
Sub_metering <- ts(data[,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")])
ts.plot(Sub_metering, 
        gpars=list(col = c("black", "red", "blue"), xaxt = "n", xlab= NULL,
                   ylab = "Energy sub metering")
)
axis(1, at=c(1, date_range/2+1, date_range+1), labels=week_days)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1), col = c("black", "red","blue"), cex=0.8
       )

# fourth plot
ts4 <- ts(data[,"Global_reactive_power"])
plot(ts4, xaxt = "n", xlab= "datetime", ylab="Global_reactive_power")
axis(1, at=c(1, date_range/2+1, date_range+1), labels=week_days)

# Copying the plot to a PNG file
dev.copy(png, file = "ExData_Plotting1/plot4.png",
         width = 480, height = 480, units = "px") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!