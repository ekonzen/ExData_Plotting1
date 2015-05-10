# plot 1

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

# Plotting the Histogram
with(data, hist(Global_active_power, col="red", 
                xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
                main = "Global Active Power"))

# Copying the plot to a PNG file
dev.copy(png, file = "ExData_Plotting1/plot1.png",
         width = 480, height = 480, units = "px") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
