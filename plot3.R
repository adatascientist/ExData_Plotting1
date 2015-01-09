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

## Combine into single dataframe, epcp2
epcp2<-rbind(epc2,epc3)

## Subset for Date, Time and Sub Metering 1, 2, and 3
esm<-epcp2[,c(1,2,7,8,9)]

## Paste together Date and Time and convert from character to DateTime
esm$DateTime <- paste(esm$Date, esm$Time)
esm$DateTime <- strptime(esm$DateTime, format = "%d/%m/%Y %H:%M:%S")

## Open PNG device file, plot first variable, then add second and third variable, 
## add legend, and turn device off
png(filename = "plot3.png",width = 480, height = 480, units = "px", type = c("windows"))
plot(esm$DateTime,esm$Sub_metering_1,type="l", ylab="Energy sub metering ", xlab= "")
lines(esm$DateTime,esm$Sub_metering_2, type = "l", col = "red")  
lines(esm$DateTime,esm$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1), col=c("black","red","blue"))
dev.off()