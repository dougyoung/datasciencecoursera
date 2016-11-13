# CodeBook

This code book specifies the data, variables, and transformations that were performed to clean up the data set in question.

## Source of data set

* Dataset overview and description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* Dataset mirror for download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Information about data set

Quoting from the website referenced in the "Source of data set" section:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

## The data set

The data set contains these files:

* README.txt - Further description and information about the dataset.

* activity_labels.txt: Assigns activity id to human readable activity label.

* features.txt: Mapping from feature ids to human readable feature descriptions.

* features_info.txt: Gives more detailed information about each type of feature variable.

* test/Inertial Signals/total_acc_[x,y,z]_test.txt: The acceleration data from the accelerometer [X,Y,Z] axis in gravity units 'g'. Every row contains a 128 length vector.

* test/Inertial Signals/body_acc_[x,y,z]_test.txt: The acceleration data obtained by subtracting gravity from total acceleration.

* test/Inertial Signals/body_gyro_[x,y,z]_test.txt: The angular velocity vector collected by the gyroscope for each sample. The units are expressed in radians per second.

* test/X_test.txt: Test set.

* test/subject_test.txt: Each row contains the subject that performed an activity for each sample. Range [1, 30].

* test/y_test.txt: Test labels.

* train/Inertial Signals/total_acc_[x,y,z]_train.txt: The acceleration data from the accelerometer [X,Y,Z] axis in gravity units 'g'. Every row contains a 128 length vector.

* train/Inertial Signals/body_acc_[x,y,z]_train.txt: The acceleration data obtained by subtracting gravity from total acceleration.

* train/Inertial Signals/body_gyro_[x,y,z]_train.txt: The angular velocity vector collected by the gyroscope for each sample. The units are expressed in radians per second.

* train/X_train.txt: Training set.

* train/y_train.txt: Training labels.

## Raw data set details

The raw data set was constructed using the following regular expression to match only required features, i.e. metrics on mean and standard deviation for each measurement from the original data set: `(mean|std)\\(\\)`.

The regular expression matches 66 features from the original data set. Including the subject identifiers and activity labels label the total number of variables rises to 68 in this processed raw data set.

## Tidy data set transformation details

1. Merges the training and the test sets to create one complete data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How `run_analysis.R` runs

* Requires "data.table", "reshape2", "dplyr" R packages.
* Loads both test and train data.
* Loads the features and activity labels.
* Extracts the mean and standard deviation column names and data.
* Process the data, test and training sets respectively.
* Merge data set.
