
intToFile <- function( num ) {
  paste( sprintf( "%03d", num ), ".csv", sep='' )
}

complete <- function(directory, id = 1:332) {
  
  # go to working dir
  setwd( "/home/ronnyma/development/DataSciSpec/R-prog/Assignment1" )
  m <- c()
  # Determine which files to read
  files <- intToFile( id )
  
  # Merge all files into one data frame
  for( i in 1:length(files) ) {
    f <- paste(directory, files[i], sep="/")
    m[i] <- sum(complete.cases(read.csv(f, header=TRUE)))
  }
  
  
  h <- c(id, nobs)
  df <- data.frame(id, m)
  
  names(df) <- c("id","nobs")
 
 print( df )
  
 
  
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
}