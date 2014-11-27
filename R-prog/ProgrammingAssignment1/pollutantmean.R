intToFile <- function( num ) {
  paste( sprintf( "%03d", num ), ".csv", sep='' )
}

pollutantmean <- function( directory, pollutant, id = 1:332 ) {

            alldata <- c()
            # go to working dir
            setwd( "/home/ronnyma/development/DataSciSpec/R-prog/Assignment1" )
  
            # Determine which files to read
            files <- intToFile( id )
            
            # Merge all files into one data frame
            for( f in files ) {
              f <- paste(directory, f, sep="/")
              tmp <- read.csv(f, header=TRUE)
              alldata <- rbind(tmp,alldata)
            }
            
            mean( alldata[[pollutant]], na.rm=TRUE )
}
