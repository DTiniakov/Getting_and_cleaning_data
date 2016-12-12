#Codebook

This code book contains description of original dataset (shortly), data processing steps and new variables

## Original dataset
Human Activity Recognition Using Smartphones Data Set

Source url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data set contains data of sensor signals from smartphones of 30 volunteers while performing different types of activities.

There are following files in dataset:

* 'README.txt'

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Steps of processing

* loading needed data from files of HARUS dataset to R objects
* creating dataframe with data on subjects, activity types and different features by c- and rbinding data from train and test sets
* subsetting features with measurements of mean or standard deviation only
* renaming features' names and activity types, using full labels
* computing mean values for features of interest by subject and activity type and saving final result

## Variables emereged while processing
* xpath - character vector with path to directory containing original files
* subjectTrain; subjectTest - numeric vectors containing subjects' IDs from train and test set respectively
* testActtype; trainActtype - numeric vectors containing coded information about activity type from train and test set respectively
* actLabel - dataframe containing info about activity type coding
* featureNames - dataframe containing info about names of different features
* testVals;trainVals - dataframes with numeric data for different features from train and test set respectively
* test, train - merged data frames with information about subjects' IDs, coded activity types and different features' values from test and train datasets respectively
* full - dataframe with data on both - train and test- datasets

* meansd - logical vector checking which elements of featureNames do measure mean or standard deviation
* selected - character vector of elements of featureNames which measure mean or standard deviation
* newfull - dataframe containing only those features which measure mean or standard deviation

* avgdata - dataframe with information of meanvalue of each feature by subject ID and by activity type