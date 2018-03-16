
Sys.setenv("HADOOP_PREFIX"="/usr/local/opt/hadoop/libexec")
Sys.setenv("HADOOP_CMD"="/usr/local/opt/hadoop/libexec/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/usr/local/opt/hadoop/libexec/share/hadoop/tools/sources/hadoop-streaming-2.8.0-sources.jar")
Sys.setenv(HADOOP_STREAMING='/usr/local/opt/hadoop/libexec/share/hadoop/tools/lib/hadoop-streaming-2.8.0.jar')
library(rmr2) 
library(rhdfs)

hdfs.init()``
## map function
map <- function(k,lines) {
  words.list <- strsplit(lines, '\\s') 
  words <- unlist(words.list)
  return( keyval(words, 1) )
}

## reduce function
reduce <- function(word, counts) { 
  keyval(word, sum(counts))
}

wordcount <- function (input, output=NULL) { 
  mapreduce(input=input, output=output, input.format="text", 
            map=map, reduce=reduce)
}


## delete previous result if any
system("/Users/hadoop/hadoop-1.1.2/bin/hadoop fs -rmr /msharma/wordcount/out")

## Submit job
hdfs.root <- '/msharma/wordcount'
hdfs.data <- file.path(hdfs.root, 'wordsfile') 
hdfs.out <- file.path(hdfs.root, 'out') 
out <- wordcount(hdfs.data, hdfs.out)

## Fetch results from HDFS
results <- from.dfs(out)

## check top 30 frequent words
results.df <- as.data.frame(results, stringsAsFactors=F) 
colnames(results.df) <- c('word', 'count') 
head(results.df[order(results.df$count, decreasing=T), ], 30)