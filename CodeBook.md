

##Information about variables and data
The data set is the Human Activity Recognition Using Smartphones Dataset Version 1.0

The data can be obtained at this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

More information about the data can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#


All records include the following information:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

##Information about transformations and summary choices
Input files/raw data:
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent:
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

The following were generated from the raw data files:
- 'featureNames' is generated from 'features.txt'
- 'activityLabels' is generated from 'activity_labels.txt'
- 'subjectTrain' is generated from 'subject_train.txt'
- 'activityTrain' is generated from 'y_train.txt'
- 'featuresTrain' is generated from 'X_train.txt'
- 'subjectTest' is generated from 'subject_test.txt'
- 'activityTest' is generated from 'y_test.txt'
- 'featuresTest' is generated from 'X_test.txt'
The following were generated from declared elements:
- 'subject' is generated from binding 'subjectTrain' & 'subjectTest'
- 'activity' is generated from binding 'activityTrain' & 'activityTest'
- 'features' is generated from binding 'featuresTrain' & 'featuresTest'
- The column names in 'features' are named using the descriptions in 'featureNames'
- The completeData set is a compilation of 'features', 'activity' and 'subject'
- 'requiredColumns' combines columns that contain 'mean' or 'std' with activity and subject
- 'extractedData' is created using the columns in 'requiredColumns'
- The 'Activity' column in 'extractedData' is updated using the information in 'activity_labels.txt'

The following data labels were updated with more appropriate/descriptive/consistent names:
* Acc to Accelerometer
* Gyro to Gyroscope
* BodyBody to BodyBodyMag to Magnitude
* ^t to Time
* ^f to Frequency
* tBody to TimeBody
* -mean() to Mean
* -std() to STD
*  -freq() to Frequency
* angle to Angle
* gravity to Gravity

'tidyData' is generated using the activity and subject from extractedData
	
The output data 'TidyData.txt' is a space-delimited file that contains the mean and standard deviation information for the input data. It is generated from 'tidyData' with write.table() using row.name=FALSE


##Information about the experimental study design

Notes taken from the Human Activity Recognition Using Smartphones Dataset pertaining to study design:

	*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

	The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.*
