# downloads the dataset with the link provided on the assignment and unzips it
downloaddata <- function() {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
    unzip("household_power_consumption.zip")
}

# reads the whole data on the dataset to a data table and then cleans it by
# subsetting the whole dataset to the days necessary for the exercise and
# converting the data to the proper data types
preparedata <- function() {
    library(data.table)
    DT <- fread("household_power_consumption.txt", na.strings=c("NA","","?"))
    DT <- subset(DT,Date %in% c("1/2/2007", "2/2/2007"))
    DT$Date_time <- as.POSIXct(strptime(paste(DT$Date, DT$Time), "%d/%m/%Y %H:%M:%S"))
    DT$Date <- NULL
    DT$Time <- NULL
    DT$Global_active_power <- as.numeric(DT$Global_active_power)
    DT$Global_reactive_power <- as.numeric(DT$Global_reactive_power)
    DT$Global_intensity <- as.numeric(DT$Global_intensity)
    DT$Sub_metering_1 <- as.numeric(DT$Sub_metering_1)
    DT$Sub_metering_2 <- as.numeric(DT$Sub_metering_2)
    DT$Sub_metering_3 <- as.numeric(DT$Sub_metering_3)
    DT
}

# creates a png file with the plot 4
plot4 <- function(DT) {
    Sys.setlocale("LC_TIME", "English")
    png("plot4.png")
    par(mfrow=c(2,2))
    with(data, {
        plot(DT$Date_time, DT$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        plot(DT$Date_time, DT$Voltage, type="l", xlab="datetime", ylab="Voltage")
        plot(DT$Date_time, DT$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
        lines(DT$Date_time, DT$Sub_metering_2, col="red")
        lines(DT$Date_time, DT$Sub_metering_3, col="blue")
        legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
        plot(DT$Date_time, DT$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    })
    dev.off()
}

# comment out this function call if the dataset is already available in the wd
downloaddata()
# comment out this function call if the clean data is already in the environment
data <- preparedata()

plot4(data)