The CodeBook
============
The data was obtained at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

These files were used 
---------------------

activity_labels.txt
features.txt, 

###Test set
subject_test.txt
X_test.txt
y_test.txt

###Training set
subject_train.txt
X_train.txt
y_train.txt


The above six files can be viewed upon as two sets of files. The files in each set are related to the
other members by line number, e.g. line# n in subject_test.txt is related to line# n in X_test.txt

"subject"-files: Integers representing each test subject pareticipating in the study. Test and train-sets are disjoint.
"y_"-files: Integers representing the activity done by the test subject.
"X_"-files: The measurements of the activity (features). The measurements are sampled with a 3D-accelerometer, hence the
values are vectors of g-force.  All data has been normalized to the range [-1, 1]. For an in-depth explanation 
of the features, please refer to features_info.txt in the raw data set at the URL above.

Feature Selection
-----------------
In "tidydata.csv", all the columns represents the mean value of the feature recorded in the raw data aggregated by subject and ativity.
Only features conveying the mean value or standard deviation is included.

* Example: Subject 1 has WALKED, WALKING_UPSTAIRS and LYING. Each activity has been measured accordingly (ref. the raw data).
This example will yield three values, i.e. the mean for subject1-WALKING, subject1-WALKING_UPSTAIRS and subject1-LYING.
(Here, tab is used as delimiter to ease human readability)

Subject	activityId	measurements	
1	1		.76		(..)
1	2		.84		(..)
1	3		.23		(..)

The Code Book
-------------

Instead of repeating the information from "features_info.txt" here, please refer to the raw data.

After approprietily labelling the data set with descriptive names, the following abbreviations were expanded:

acc 	= Acceleration
mag 	= Magnitude
std()	= SD
mean()	= MV
t	= Time (when occurring in the beginning of a feature label)
f	= Freq (when occurring in the beginning of a feature label)

The name of the activity is listed in the last column. In the Tidy-set, the labels are identical. For a more in-depth 
explanation of each and every feature, refer to the raw data set.


Study Design
------------

Firstly, the datafiles are read into R and an appropriate label [column header] is added. For the X_-files, the column
names are from "features.txt"- This is possible because row n in this file corresponds to column n in the X_-file. 

Secondly, these 2 x 3 files from the test and train-set respectively are column-bound. Since we are only interested in files
which conveys a SD or MV, we weed out everything irrelevant (grepl). The products from column-binding is merged into a combined
set containing all data. 

Thirdly, to get a descriptive column name for the activity, the activity_labels.txt is merged into this set.

Fourthly, the column names are cleaned up to be human reader friendly (see the beginning of the isection "Code Book").

Finally, an independent set is derived from this set. We aggregate by subject and activity[id] and apply the function mean to
each segment of values, which in turn yields the mean values as described scetion "Feature Selection"
