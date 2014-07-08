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
  dat$wday=wday(dat$Time,T,F)
  save(dat,file='subset.RData')
}
png('plot1.png',bg='transparent')
hist(sd$Global_active_power,col='red',main='Global Active Power',xlab='Global Active Power (kilowats)')
dev.off()

