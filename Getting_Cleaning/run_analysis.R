#run_analysis.R

setwd("/home/ronnyma/development/DataSciSpec/Getting_Cleaning")



# Load the test sets
test.msr <- read.csv("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
test.subject <- read.csv("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
test.activity <- read.csv("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="")


# Load the training sets
train.msr <- read.csv("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
train.subject <- read.csv("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
train.activity <- read.csv("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="")

# Load the feature set
feat <- read.csv("UCI HAR Dataset/features.txt", header=FALSE, sep="") # feat[,2] returns a vector with all activity names.

# Set column headers before merging
colnames(test.subject) = "TestSubject"
colnames(test.activity) = "Activity"
colnames(test.msr) = feat[,2] 

# The same for the training data
colnames(train.subject) = "TestSubject"
colnames(train.activity) = "Activity"
colnames(train.msr) = feat[,2]

# Same colnames for test- and train-sets. Get only std() and mean()

wc <- grep("std\\(\\)|mean\\(\\)", feat[,2])

test.set <- cbind(test.subject, test.activity, test.msr[wc])

train.set <- cbind(train.subject, train.activity, train.msr[wc])

# Now, merge the test and training set (Step #1 of the project. Step #2 is a corollary of this (see lines 35 & 37))

merged <- rbind(test.set, train.set)





stop("Nok")
# Step #1: merge the test- and training-set to one set

all.sets <- rbind(test.set, train.set)


# Create proper names for the columns - steal from features.txt - only features
# that contain mean() or std()
feat <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
selected <- grep("mean\\(\\)|std\\(\\)", feat[,2])

# Give both sets meaningful names
colnames(test.set) <- c(as.character(feat$V2), "TestSubject", "Activity")
colnames(train.set) <- c(as.character(feat$V2), "TestSubject", "Activity")


