library(jsonlite)

api_daily<-function(symbol, key){
  url=c('https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=', symbol, '&outputsize=full&apikey=', key)
  data=fromJSON(paste(url, collapse = ""))
  data=data[[2]]
  data=do.call(rbind, lapply(data, data.frame))
  dates=rownames(data)
  data=as.data.frame(apply(test,2,as.numeric), row.names = dates)
  return(data)
}
test=api_daily('MSFT', 'demo')
