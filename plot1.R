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
epcp1<-rbind(epc2,epc3)

## Open PNG device file, plot histogram and turn device off
png(filename = "plot1.png",width = 480, height = 480, units = "px", type = c("windows"))
hist(epcp1$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()