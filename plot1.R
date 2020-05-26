library(lubridate)
library(dplyr)

alldat <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
head(alldat)
crn<-tbl_df(alldat)
crn
crn<-mutate(crn,Date = dmy(Date),Time = hms(Time))
crn<-filter(crn, Date==ymd(20070201) | Date==ymd(20070202) )
hist(crn$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")

dev.copy(png, file="plot1.png", width=480, height = 480)
dev.off()
