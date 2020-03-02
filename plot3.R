library(tidyverse)
setwd("C:/Users/JIN/Documents/R/Coursera/Exploratory Data Analysis/week1/Course Project 1/ExData_Plotting1/data")
Sys.setlocale("LC_TIME","English")

#tidying data
dt <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
dt$Time <- format(strptime(dt$Time, format = "%H:%M:%S"), "%H:%M:%S")

dt <- dt[which(dt$Date == "2007-02-01"|dt$Date == "2007-02-02"), ]
dt$DateTime <- strptime(paste(dt$Date, dt$Time), format="%Y-%m-%d %H:%M:%S")

dt[which(dt$Global_active_power == "?"), 3] <- NA
dt[which(dt$Global_reactive_power == "?"), 4] <- NA
dt[which(dt$Voltage == "?"), 5] <- NA
dt[which(dt$Global_intensity == "?"), 6] <- NA
dt[which(dt$Sub_metering_1 == "?"), 7] <- NA
dt[which(dt$Sub_metering_2 == "?"), 8] <- NA
dt[which(dt$Sub_metering_3 == "?"), 9] <- NA

dt$Global_active_power <- as.numeric(as.character(dt$Global_active_power))
dt$Global_reactive_power <- as.numeric(as.character(dt$Global_reactive_power))
dt$Voltage <- as.numeric(as.character(dt$Voltage))
dt$Global_intensity <- as.numeric(as.character(dt$Global_intensity))
dt$Sub_metering_1 <- as.numeric(as.character(dt$Sub_metering_1))
dt$Sub_metering_2 <- as.numeric(as.character(dt$Sub_metering_2))
dt$Sub_metering_3 <- as.numeric(as.character(dt$Sub_metering_3))

#create plot3.png
with(dt, plot(DateTime, Sub_metering_1, 
              ylim = c(0, max(Sub_metering_1, Sub_metering_2, Sub_metering_3)),
              type = "s",
              xlab = NA, ylab = "Energy sub metering"))
with(dt, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(dt, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, cex = 0.8, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
