
## This is the constructor

myData <- c()

cstruct <- function(directory) {
  #Create a data frame from all files. Include header from only the first file
  setwd("/home/ronnyma/development/DataSciSpec/R-prog/Assignment1")
        
  #Get all files in directory
  files <- Sys.glob("specdata/*")
    myData <- read.csv(files[1], header=TRUE)
    for( f in files[-1] ) {
      print(f)
    tmp_frm <- read.csv(f, header=TRUE)
    myData <- rbind(myData, tmp_frm)
  }
  #myData
}
        
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
                        
              
            ## 'pollutant' is a character vector of length 1 indicating
            ## the name of the pollutant for which we will calculate the
            ## mean; either "sulfate" or "nitrate".
            

            ## 'id' is an integer vector indicating the monitor ID numbers
            ## to be used
            #print( id )

            ## Return the mean of the pollutant across all monitors list
            ## in the 'id' vector (ignoring NA values)

}


