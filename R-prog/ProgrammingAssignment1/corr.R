#corr.R


  
corr <- function(directory, threshold = 0) {
  # Set wd
  setwd("/usr/home/ronnyma/development/DataSciSpec/R-prog/ProgrammingAssignment1")

  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  files <- Sys.glob(paste(directory,"*", sep="/"))
  c <- c()
  tmp <- c()
  alldata <- c()
  for( f in files ) {
    #f <- paste(directory, f, sep="/")
    tmp <- read.csv( f, header=TRUE )
    cc <- sum( complete.cases( tmp ) )
    if( cc > threshold ) {
      #print(sprintf( "Adding %s, threshold < %d", f, cc ) )
      alldata <- rbind( tmp, alldata )
    }
    else {
      #print(sprintf( "Not adding %s, threshold > %d", f, cc ) )
      #alldata <- rbind( c(), alldata )
    }
  }
  if( length( alldata ) == 0) {
    i <- c()
    return( i )
     
  }
  # Strip away the NAs
  all_strip <- alldata[complete.cases(alldata),]
  l <- length(files)
  
  # Iterate all monitors
  for( i in 1:l ) {
    m_i <- all_strip[all_strip$ID==i,]
    c[i] <- cor( m_i$sulfate, m_i$nitrate )
  }
  
  c[complete.cases(c)]
}
