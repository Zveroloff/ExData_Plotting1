electricity <- read.csv2("household_power_consumption.txt", na.strings = "?", colClasses = "character")
Datetime <- strptime(paste(electricity$Date, electricity$Time, sep =" "), "%d/%m/%Y %H:%M:%S")
electricity <- data.frame(Datetime, electricity[,3:ncol(electricity)])

## subsetting the dataframe
lv <- electricity$Datetime >= "2007-02-01 00:00:00" & electricity$Datetime <= "2007-02-02 23:59:00"
el.subset <- electricity[lv, ]

## doing graphics
hist(as.numeric(el.subset$Global_active_power),
        main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)",
        col = "orangered1")
