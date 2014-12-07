setwd("/home/ronnyma/development/DataSciSpec/R-prog/ProgrammingAssignment3")

rankhospital <- function(state, outcome, num = "best") {
  
  
    
  #Find the correct column to sort by
  column <- 0
  if(outcome == "heart attack") column <- 3
  if(outcome == "heart failure") column <- 4
  if(outcome == "pneumonia") column <- 5
  
  
  
  ## Read outcome data
  outcome.data <- read.csv( "outcome-of-care-measures.csv", colClasses="character" )[c(2,7,11,17,23)]
  
  ## Check that state and outcome are valid
  if(column == 0) stop("invalid outcome")
  
  if(!(state %in% outcome.data[,2])) {
    stop("invalid state")
  }

  
  
  
  outcome.data <- outcome.data[outcome.data$State==state,]
  outcome.data <- transform( outcome.data, Hospital.Name = Hospital.Name,
                          outcome = as.numeric(outcome.data[, column]))
  #Prepare: remove NAs and sort DESC    
  outcome.data <- outcome.data[!is.na(outcome.data$outcome),]
  outcome.data <- outcome.data[order(outcome.data$outcome, outcome.data$Hospital.Name),]
  
  outcome.data$Rank <- 1:nrow(outcome.data)
  ## Return hospital name in that state with the given rank
  
  
  
  #Monkeying
  if(num == "best") {
    num <- 1
  } else if(num == "worst") {
    num <- nrow(outcome.data)
  }
  
  t <- outcome.data[num,][,1]
  
  t
  ## 30-day death rate
  
  
}
