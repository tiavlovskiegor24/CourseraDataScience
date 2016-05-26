## Readme file

Feature Selection (Code book)
=================

The features (columns) selected for this dataset come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Note!!! All variable names in "mergeddata" and "averageddata" are using lowercase spelling of the following features. 

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean: Mean value

std: Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean

tBodyAccMean

tBodyAccJerkMean

tBodyGyroMean

tBodyGyroJerkMean


How the script run_analysis.r works 
===================================
First we load the test and train datasets ("xtest","xtrain") as well as the correspodning subject identifiers and match the activity labels with the activity names and names the columns of the data sets with the corresponding feature names. We merge the test and train datasets together into "mergeddata" data set. 

We then add three variables for each observation (category(train/test), activity, subject identifier) to "mergeddata". 

Using grep function on the column names of "mergeddata" we only leave features corresponding to mean or standad deviation of each signal. 

gsub function is used to tidy the data set variable (colunm) names.

A column of unique "id" variables is added to "mergeddata", combining the three observation varialbes (category(train/test) + activity + subject identifier). 

We then use ddply function ("plyr" package) on "mergeddata", sorting by uniqie "id" variable to calculate the mean of all observation corresponding to each unique (category + activity + subject) combination. The result is "averageddata" data set with the average of each variable for each activity and each subject. 



