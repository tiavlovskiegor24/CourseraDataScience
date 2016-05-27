library(plyr)

## Load the data from files into R 
xtest <- read.table("./GettindAndCleaningData/UCI HAR Dataset/test/X_test.txt")
xtrain <- read.table("./GettindAndCleaningData/UCI HAR Dataset/train/X_train.txt")

## Load the column names
colnames <- read.table("./GettindAndCleaningData/UCI HAR Dataset/features.txt")#,stringsAsFactors = FALSE)

## Assing the column names to data sets
names(xtest) <- colnames$V2
names(xtrain) <- colnames$V2

## Load the activity labels and subject labels
activitylabels <- read.table("./GettindAndCleaningData/UCI HAR Dataset/activity_labels.txt")#,stringsAsFactors = FALSE)
testlabels <- read.table("./GettindAndCleaningData/UCI HAR Dataset/test/y_test.txt")#,stringsAsFactors = FALSE)
trainlabels <- read.table("./GettindAndCleaningData/UCI HAR Dataset/train/y_train.txt")#,stringsAsFactors = FALSE)
testsubjects <- read.table("./GettindAndCleaningData/UCI HAR Dataset/test/subject_test.txt",col.names = c("subject"))#,stringsAsFactors = FALSE)
trainsubjects <- read.table("./GettindAndCleaningData/UCI HAR Dataset/train/subject_train.txt",col.names = c("subject"))#,stringsAsFactors = FALSE)

## Assign activity names to lables and tidy the names
testlabels$activity <- tolower(activitylabels[testlabels$V1,2])
testlabels$activity <- gsub("_","",testlabels$activity)
trainlabels$activity <- tolower(activitylabels[trainlabels$V1,2])
trainlabels$activity <- gsub("_","",trainlabels$activity)


## Creat category columns: test and training
testcategories <- sample("test",size = nrow(xtest),replace = TRUE)
traincategories <- sample("train",size = nrow(xtrain),replace = TRUE)

## add the test/train,activities and subjects columns to the dataframes to uniquely identify each record
xtest <- cbind(category = testcategories, subject=testsubjects, activity=testlabels$activity,xtest)
xtrain <- cbind(category = traincategories,subject=trainsubjects,activity=trainlabels$activity,xtrain)

## Merges the training and the test sets to create one data set
mergeddata <- rbind(xtest,xtrain)

## Extracts only the measurements on the mean and standard deviation for each measurement
mergeddata <- mergeddata[,c(1:3,grep("[Mm]ean|[Ss]td",names(mergeddata)))]

## Tidy the column names
names(mergeddata) <- tolower(names(mergeddata))
names(mergeddata) <- gsub("\\-","",names(mergeddata))
names(mergeddata) <- gsub("\\()","",names(mergeddata))
names(mergeddata) <- gsub("\\(","",names(mergeddata))
names(mergeddata) <- gsub("\\)","",names(mergeddata))
names(mergeddata) <- gsub("\\,","",names(mergeddata))

##order the data set
mergeddata <- mergeddata[order(mergeddata$activity,mergeddata$subject),]

##create and add a unique id for each record composing of category, activity and subject number
id <- paste0(mergeddata$category,mergeddata$activity,mergeddata$subject)
mergeddata <- cbind(id,mergeddata)

##create a final tidy data set with the average of each variable for each activity and each subject 
averageddata <- ddply(mergeddata,.(id),function(x){ cbind(x[1,1:4],as.list(colMeans(x[,5:ncol(x)]))) })

## order the final data set for the output
averageddata <- averageddata[order(averageddata$activity,averageddata$subject),]


