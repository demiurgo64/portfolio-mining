library(jsonlite)

api_daily<-function(symbol, key){
  url=c('https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=', symbol, '&outputsize=full&apikey=', key)
  data=fromJSON(paste(url, collapse = ""))
  if(length(data)==2){
  data=data[[2]]
  data=do.call(rbind, lapply(data, data.frame))
  dates=rownames(data)
  data=as.data.frame(apply(data,2,as.numeric), row.names = dates)
  }
  return(data)
}

api_daily_BD<-function(symbol, key, db){
  data=api_daily(symbol,key)
  if(api_error_ctrl(data)){
    data$date=as.Date.character(rownames(data), format="%Y-%m-%d")
    data$symbol=symbol
    rownames(data)=NULL
    colnames(data)=c("open","high","low","close","volume","date","symbol")
    dbWriteTable(db, "Stocks", data, append=TRUE)
  }
  else{
    print(paste(c('Symbol',symbol, "doesn't exist"), collapse = " "))
  }
}
api_error_ctrl<-function(data){
  if(names(data)[1]=="Error Message") {FALSE}
  else if(names(data)[1]=="Information") {FALSE}
  else {TRUE}
} 
test=api_daily('MSFT', 'demo')

