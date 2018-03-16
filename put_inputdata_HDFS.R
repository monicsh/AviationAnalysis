
library(rhdfs)
hdfs.init()
hdfs.ls("/msharma/data/air_ontime")

# store a csv file on hdfs : /msharma/data/aviation
foldername <- "/Users/msharma/code/AviationAnalysis/data/1988/"
files <- list.files(foldername, pattern = "^TB_Scrub[[:graph:]]+.csv$")
for (f in files){
  file <- paste(foldername, f, sep="")
  hdfs.put(file,"/msharma/data/air_ontime/")
}
hdfs.ls("/msharma/data/air_ontime")
