


# Test Configuration : run a test script

small.ints <- to.dfs(keyval(1, 1:10000))
# mapreduce job with map and reduce function
out <- mapreduce(
  input = small.ints, 
  map = function(k, v){
    keyval(ifelse(v > 10, 0, 1), v)
  },
  reduce = function(k,v){
    keyval(k, length(v))
  }
)
res <- from.dfs(out)
head(res$key)
head(res$val)


# Test Configuration : run a test script having text data on hdfs WORDCOUNT
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


