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
p4<-rbind(epc2,epc3)


## Paste together Date and Time and convert from character to DateTime
p4$DateTime <- paste(p4$Date, p4$Time)
p4$DateTime <- strptime(p4$DateTime, format = "%d/%m/%Y %H:%M:%S")

## Open PNG device file and format for 2x2 graphs
png(filename = "plot4.png",width = 480, height = 480, units = "px", type = c("windows"))
par(mfrow=c(2,2))

## plot Global Active Power
plot(p4$DateTime,p4$Global_active_power,type="l", ylab="Global Active Power (kilowatts)", xlab= "")

## plot Voltage
plot(p4$DateTime,p4$Voltage,type="l", ylab="Voltage", xlab= "datetime")

## plot Energy Submetering
plot(p4$DateTime,p4$Sub_metering_1,type="l", ylab="Energy sub metering ", xlab= "")
lines(p4$DateTime,p4$Sub_metering_2, type = "l", col = "red")  
lines(p4$DateTime,p4$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1), col=c("black","red","blue"),bty="n",cex=0.9)

## plot Global Reactive Power
plot(p4$DateTime,p4$Global_reactive_power,type="l", ylab="Global_reactive_power",xlab= "datetime")

## Turn device off
dev.off()