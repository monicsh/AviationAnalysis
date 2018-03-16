#setup working directory
setwd("/Users/msharma/code/AviationAnalysis/data")

# Step_1 :: Scrub year data
foldername <- "1988/"
files <- list.files(path=foldername, pattern ="*.csv")
for (filename in files){
  raw_data <- read.csv(paste(foldername,filename, sep=""))
  scrub_data <- subset(raw_data, Cancelled == 0 , select = c("DayOfWeek" ,"Origin", "Dest", "UniqueCarrier",  "DepDelayMinutes",  "ArrDelayMinutes"))
  #scrubfilepath <- paste(filepath, "Scrub_",filename, sep ="")
  write.table(scrub_data,file=paste(foldername, "TB_Scrub_",filename, sep=""), sep=",")
}


# Step_? :: Merge scrub data yearly
#multmerge <- function(foldername){filenames<-list.files(path=foldername, pattern ="^Scrub[[:graph:]]+.csv$")
 #datalist <- lapply(filenames, function(x){read.csv(file=paste(foldername, x, sep=""),header=T)})
  #Reduce(function(x,y) {merge(x,y)}, datalist)}
  
#mergeddata <- multmerge("1988/")

head(scrub_data)
