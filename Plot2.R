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
with(PwrCon, plot(Date.Time, Global.Active.Power, type = "l", xlab = "", 
                  ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "Plot2.png")
dev.off()
