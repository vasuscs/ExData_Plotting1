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

with(crn,
     plot(Global_active_power~Datetime, type= "l", ylab = "Global Active Power (kilowatts)", xlab ="")   ## Type l is for the lines
  )

dev.copy(png, file="plot2.png",  width=480, height = 480)
dev.off()

