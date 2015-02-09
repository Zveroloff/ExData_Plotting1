## Reading the data from .txt(unzipped), we can do that in more optimal way, but not this time.
## On this step all columns are treated as text.
electricity <- read.csv2("household_power_consumption.txt", na.strings = "?",
                         colClasses = "character")
## Now, combining the Date and Time in Datetime object
Datetime <- strptime(paste(electricity$Date, electricity$Time, sep =" "), "%d/%m/%Y %H:%M:%S")
electricity <- data.frame(Datetime, electricity[,3:ncol(electricity)])

## Subsetting the dataframe
lv <- electricity$Datetime >= "2007-02-01 00:00:00" & electricity$Datetime <= "2007-02-02 23:59:00" & !is.na(electricity$Datetime)
el.subset <- electricity[lv, ]

## Doing graphics
hist(as.numeric(el.subset$Global_active_power),
        main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)",
        col = "red")
