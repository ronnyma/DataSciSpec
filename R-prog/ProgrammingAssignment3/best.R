best <- function( state, outcome ) {
  
  #Find the correct column to sort by
  column <- 3
  if(outcome == "heart attack") column <- 3
  if(outcome == "heart failure") column <- 4
  if(outcome == "pneumonia") column <- 5
  
  #Get the relevant data
  keydat <- read.csv( "outcome-of-care-measures.csv", colClasses="character" )[c(2,7,11,17,23)]
  
  #Sort by relevant outcome
  relevant <- keydat[sort.list(as.numeric(keydat[, column])),][c(1,2,column)][keydat$State==state,]
  
  #Find out if there is a tie
  run <- TRUE
  i <- 1
  h <- c(relevant[i, 1])
  nxt <- 1
  while( run == TRUE ) {
    curr <- relevant[i, 3]
    if(is.null(relevant[i+1, 3])) break
       
    nxt <- relevant[i+1, 3]
    if(curr == nxt) {
      h <- append(h, relevant[i+1, 1])
    }
    else {
      run <- FALSE
    }

    i = i + 1
  }
  
  #Sort the hospitals alphabetically
  if( length(h) > 1 ) {
    #rint("More than one!")
  }
  
  return(h)
  #Return the first
  #print(head(relevant))
  #return(relevant)
  
}