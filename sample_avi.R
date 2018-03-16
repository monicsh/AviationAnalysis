
setwd("/Users/msharma/code/AviationAnalysis")

raw_data <- read.csv("ontime.csv")
scrub_data <- subset(raw_data, CANCELLED == 0 ,select = c(UNIQUE_CARRIER, ARR_DELAY_NEW ))
write.csv(scrub_data, "scrub_ontime.csv")

# Install dependents packages 
#"rJava", 
install.packages(c("Rcpp", "RJSONIO", "bitops", "digest", "functional", "stringr", 
                   "plyr", "reshape2", "dplyr",  "R.methodsS3", "caTools", "Hmisc"))

install.packages("memoise") # prerequisite fr plyrmr


Sys.setenv("HADOOP_PREFIX"="/usr/local/Cellar/hadoop/2.8.0")
Sys.setenv("HADOOP_CMD"="/usr/local/Cellar/hadoop/2.8.0/bin/hadoop")

# Install RHadoop packages


install.packages("/Users/msharma/Downloads/rhdfs_1.0.8.tar.gz", repos=NULL, type="source")

#???hdfs.init()

install.packages("/Users/msharma/Downloads/rmr2_3.3.0.tar.gz", repos=NULL, type="source")
install.packages("/Users/msharma/Downloads/plyrmr_0.5.0.tar.gz", repos=NULL, type="source")
