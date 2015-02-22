#Assumptions:
#	1. The following file has been downloaded and extracted in the working directory: (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
#	2. The "data.table" and "dplyr" packages have been installed

#Load libraries
	library(data.table)
	library(dplyr)

#Read auxiliary data / train data / test data
	featureNames <- read.table("UCI HAR Dataset/features.txt")
	activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
	subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
	activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
	featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
	subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
	activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
	featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)


#Part 1: Merge the training and the test sets to create one data set
	#Bind the train and test data
		subject <- rbind(subjectTrain, subjectTest)
		activity <- rbind(activityTrain, activityTest)
		features <- rbind(featuresTrain, featuresTest)
	#Name the column names from the features file in variable featureNames
		colnames(features) <- t(featureNames[2])
	#Add activity and subject as a column to features
		colnames(activity) <- "Activity"
		colnames(subject) <- "Subject"
		completeData <- cbind(features,activity,subject)


#Part 2: Extract only the measurements on the mean and standard deviation for each measurement
	#Subset the completed dataset
		columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
	#Add activity and subject columns
		requiredColumns <- c(columnsWithMeanSTD, 562, 563)
	#Apply subset requirements to completeData
		extractedData <- completeData[,requiredColumns]


#Part 3: Use descriptive activity names to name the activities in the data set
	#Utilize the activity_labels.txt information
		extractedData$Activity <- as.character(extractedData$Activity)
		for (i in 1:6){
		  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
		}
	#Set Activity to be read as factor
		extractedData$Activity <- as.factor(extractedData$Activity)


#Part 4: Appropriately label the data set with descriptive variable names 
	#Please refer to the Code Book for an explanation of label substitutes
		names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
		names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
		names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
		names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
		names(extractedData)<-gsub("^t", "Time", names(extractedData))
		names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
		names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
		names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
		names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
		names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
		names(extractedData)<-gsub("angle", "Angle", names(extractedData))
		names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))
		

#Part 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
	#Set the extractedData subject variable as a factor
		extractedData$Subject <- as.factor(extractedData$Subject)
		extractedData <- data.table(extractedData)
	#Create a dataset named tidyData with average for each activity and subject
		tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
	#Order tidayData according to subject and activity
		tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
	#Write tidyData into a text file with write.table() using row.name=FALSE
		write.table(tidyData, file = "TidyData.txt", row.names = FALSE)
