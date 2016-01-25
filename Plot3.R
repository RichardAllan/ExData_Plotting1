file.url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
temp <- tempfile()
download.file(file.url, temp)
VarNames<-c("Date", "Time", "Global Active Power", "Global Reactive Power", "Voltage",
            "Global Intensity", "Sub Metering 1", "Sub Metering 2", "Sub Metering3")
HPC<-read.table(unz(temp, "household_power_consumption.txt"), sep = ";", col.names = VarNames,
                na.strings = "?", nrows = 2880, skip = 66637)
PowerCon <- tbl_df(HPC)
PwrCon <- mutate(PowerCon, Date.Time = paste(PowerCon$Date, PowerCon$Time))
PwrCon$Date.Time <- strptime(PwrCon$Date.Time, "%d/%m/%Y %T")
par(mfrow = c(1,1))
with(PwrCon, plot(Date.Time, Sub.Metering.1, type = "n", xlab = "", 
                  ylab = "Energy sub metering"))
lines(PwrCon$Date.Time, PwrCon$Sub.Metering.1)
lines(PwrCon$Date.Time, PwrCon$Sub.Metering.2, col = "red")
lines(PwrCon$Date.Time, PwrCon$Sub.Metering3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))
dev.copy(png, file = "Plot3.png")
dev.off()