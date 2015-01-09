## Set to working directory

## Download zip file, unzip and save source file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp<-tempfile()
download.file(fileURL,temp,mode="wb")
unzip(temp,exdir=".")
unlink(temp)

## Document date and time of download in "dateDownloaded"
dateDownloaded<-Sys.time()

## Read source file into dataframe, epc
epc<-read.table("./household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

## Subset for required date range
epc2<-epc[epc$Date =="1/2/2007",]
epc3<-epc[epc$Date =="2/2/2007",]

## Combine into single dataframe, epcp1
epcp2<-rbind(epc2,epc3)

## Subset for Date, Time and Global Active Power
gap<-epcp2[,c(1,2,3)]

## Paste together Date and Time and convert from character to DateTime
gap$DateTime <- paste(gap$Date, gap$Time)
gap$DateTime <- strptime(gap$DateTime, format = "%d/%m/%Y %H:%M:%S")

## Open PNG device file, plot and turn device off
png(filename = "plot2.png",width = 480, height = 480, units = "px", type = c("windows"))
plot(gap$DateTime,gap$Global_active_power,type="l", ylab="Global Active Power (kilowatts)", xlab= "")
dev.off()