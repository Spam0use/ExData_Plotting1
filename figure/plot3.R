#load pre-subsetted data if available
if(file.exists('subset.RData')){
  load('subset.RData')
}else{  #otherwise read dates of interest
  library(sqldf)
  library(lubridate)
  dat=read.csv.sql('household_power_consumption.txt',sql='select * from file where Date in ("1/2/2007","2/2/2007")',sep=';')
  dat$Date=as.Date(dat$Date,"%d/%m/%Y")
  dat$Time=strptime(paste(dat$Date,dat$Time),format='%Y-%m-%d %H:%M:%S')
  dat=dat[,-1]  #date incorporated into time
  dat$wday=wday(dat$Time,T,F) #necessary?
  save(dat,file='subset.RData')
}
png('plot3.png',bg='transparent')
plot(dat$Time,dat$Sub_metering_1,type='l',xlab='',ylab='Energy sub metering')
lines(dat$Time,dat$Sub_metering_2,col=2)
lines(dat$Time,dat$Sub_metering_3,col=4)
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c(1,2,4),lty=1)
dev.off()

