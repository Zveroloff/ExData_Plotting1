electricity <- read.csv2("household_power_consumption.txt", na.strings = "?", colClasses = "character")
Datetime <- strptime(paste(electricity$Date, electricity$Time, sep =" "), "%d/%m/%Y %H:%M:%S")
electricity <- data.frame(Datetime, electricity[,3:ncol(electricity)])

## subsetting the dataframe
lv <- electricity$Datetime >= "2007-02-01 00:00:00" & electricity$Datetime <= "2007-02-02 23:59:00" & !is.na(electricity$Datetime)
el.subset <- electricity[lv, ]

## doing graphics
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
     xlab = "", ylim = yrange, col = "orangered1")

par(new = TRUE)

plot(el.subset$Datetime,
     as.numeric(el.subset$Sub_metering_3),
     type = "l",
     ylab = "",
     xlab = "", ylim = yrange, col = "blue")

legend("topright", names(el.subset[,6:8]), lty = 1, col = colors)