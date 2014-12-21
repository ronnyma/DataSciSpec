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
colnames(test.activity) = "activityId"
colnames(test.msr) = feat[,2] 

# The same for the training data
colnames(train.subject) = "TestSubject"
colnames(train.activity) = "activityId"
colnames(train.msr) = feat[,2]

# Same colnames for test- and train-sets. Get only std() and mean()

wc <- grep("std\\(\\)|mean\\(\\)", feat[,2])

test.set <- cbind(test.subject, test.activity, test.msr[wc])

train.set <- cbind(train.subject, train.activity, train.msr[wc])

# Now, merge the test and training set (Step #1 of the project. Step #2 is a corollary of this (see lines 35 & 37))

merged <- rbind(test.set, train.set)

# Read the activity labels
al <- read.csv("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")
colnames(al) <- c("activityId", "ActivityName")

# Step #3: Use descriptive names for activities, i.e. set feature names as column headers
descrSet <- merge(merged, al, by="activityId", all.x=TRUE)


# Step 4: Give the columns meaningful names

n <- colnames(descrSet)

n <- sub("acc", "Acceleration", n, ignore.case=TRUE)
n <- sub("mag", "Magnitude", n, ignore.case=TRUE)
n <- sub("std\\(\\)", "SD", n, ignore.case=TRUE)
n <- sub("mean\\(\\)", "MV", n, ignore.case=TRUE)
n <- sub("^t", "Time-", n)
n <- sub("^f", "Freq-", n)
n <- sub("BodyBody", "Body", n) #I did not have time to make this general! :-(

# Re-assign names to the set
colnames(descrSet) <- n

# Step 5: Summary of all features per subject and per activity
columns <- colnames(descrSet)
tidy.set <- aggregate(descrSet[,c(3:68)], by=list(descrSet$activityId,descrSet$TestSubject), mean)
colnames(tidy.set) <- columns[1:68]
# Merge tidy.set with activity names

final.set <- merge(tidy.set, al, by="activityId", all.x=TRUE)


write.table(final.set, "./tidydata.csv", row.names=FALSE, sep="\t")

