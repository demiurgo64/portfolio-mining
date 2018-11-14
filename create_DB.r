#Conect with DB
create_DB<-function(){
  db=dbConnect(SQLite(), dbname="archivos/stock_db.sqlite")
  dbSendQuery(conn = db, "CREATE TABLE Symbols ( 
              symbol CHARACTER(6) NOT NULL,
              name CHARACTER(100) NOT NULL,
              market CHARACTER(10) NOT NULL,
              PRIMARY KEY(symbol, market))")
  
  dbSendQuery(conn = db, "CREATE TABLE Stocks(
              symbol CHARACTER(6) NOT NULL,
              date DATETIME NOT NULL,
              open NUMERIC NOT NULL,
              high NUMERIC NOT NULL,
              low NUMERIC NOT NULL,
              close NUMERIC NOT NULL,
              volume NUMERIC NOT NULL,
              PRIMARY KEY(symbol, date)")
  dbListTables(db)
  dbDisconnect(db)
}
