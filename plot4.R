library(lubridate)
library(dplyr)

alldat <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
head(alldat)
crn<-tbl_df(alldat)
crn

crn<-mutate(crn,Date = dmy(Date))
crn<-filter(crn, Date==ymd(20070201) | Date==ymd(20070202) )

datetime<- paste(crn$Date,crn$Time)

crn<- mutate(crn,Datetime = as.POSIXct(datetime))

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(crn, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})


dev.copy(png, file="plot4.png",  width=480, height = 480)
dev.off()
