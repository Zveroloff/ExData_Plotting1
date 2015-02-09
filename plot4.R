## Reading the data from .txt(unzipped), we can do that in more optimal way, but not this time.
## On this step all columns are treated as text.
electricity <- read.csv2("household_power_consumption.txt", na.strings = "?",
                         colClasses = "character")
## Now, combining the Date and Time in Datetime object
Datetime <- strptime(paste(electricity$Date, electricity$Time, sep =" "), "%d/%m/%Y %H:%M:%S")
electricity <- data.frame(Datetime, electricity[,3:ncol(electricity)])

##Subsetting the dataframe
lv <- electricity$Datetime >= "2007-02-01 00:00:00" & electricity$Datetime <= "2007-02-02 23:59:00" & !is.na(electricity$Datetime)
el.subset <- electricity[lv, ]

## Doing graphics
## Seting mfrow to combine plots and scaling the axis
par(mfrow = c(2,2), cex.axis = 0.6)

# plot 1
plot(el.subset$Datetime,
     as.numeric(el.subset$Global_active_power),
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# plot 2
plot(el.subset$Datetime,
     as.numeric(el.subset$Voltage),
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

# plot 3
yrange <- range(as.numeric(c(el.subset$Sub_metering_1, el.subset$Sub_metering_2, el.subset$Sub_metering_3)))

plot(el.subset$Datetime,
     as.numeric(el.subset$Sub_metering_1),
     type = "l",
     ylab = "Energy sub metering",
     xlab = "", ylim = yrange)

par(new = TRUE)

plot(el.subset$Datetime,
     as.numeric(el.subset$Sub_metering_2),
     type = "l",
     ylab = "",
     xlab = "", ylim = yrange, col = "red")

par(new = TRUE)

plot(el.subset$Datetime,
     as.numeric(el.subset$Sub_metering_3),
     type = "l",
     ylab = "",
     xlab = "", ylim = yrange, col = "blue")

colors = c("black", "red", "blue")
legend("topright", names(el.subset[,6:8]), lty = 1, col = colors, cex = 0.5)

# plot 4
plot(el.subset$Datetime,
     as.numeric(el.subset$Global_reactive_power),
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")