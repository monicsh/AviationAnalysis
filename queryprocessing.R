library(plyrmr)

library(rmr2)
# map reduce job

map <- function(k, v) {
  key <- v
  key <- do.call(rbind,key )
  keyval(key, 1)
}

reduce <- function(k, v){ return(keyval(k, sum(v)))}

asa.csvtextinputformat <- make.input.format(format = function(line)
{
    values <- unlist(strsplit(line, "\\,"))
     names(values) <- c("RN", "DayOfWeek", "Origin", "Dest", "UniqueCarrier","DepDelayMinutes", "ArrDelayMinutes")
     retrun(keyval(NULL, values))
            })
topPopularAirport <- function(input, output=NULL){
  mapreduce(input=input, output=output, input.format=make.input.format("csv", sep ="\t"),map=map, reduce=NULL,combine=T)
  }
#
## delete previous result if any & ## Submit job
system("/usr/local/opt/hadoop/libexec/bin/hadoop dfs -rmr /tmp/out")
hdfs.root <- '/tmp'
hdfs.data <- file.path(hdfs.root, 'TB_Scrub_On_Time_On_Time_Performance_1988_1.csv') 
hdfs.out <- file.path(hdfs.root, 'out') 
result <- topPopularAirport(hdfs.data, hdfs.out)
from.dfs(result)

