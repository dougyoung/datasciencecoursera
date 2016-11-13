# run_analysis.R does the following:
#
#   1)  Merges the training and the test sets to create one data set.
#
#   2)  Extracts only the measurements on the mean and standard deviation for each measurement.
#
#   3)  Uses descriptive activity names to name the activities in the data set
#
#   4)  Appropriately labels the data set with descriptive variable names.
#
#   5)  From the data set in step 4, creates a second, independent tidy data set with the average
#       of each variable for each activity and each subject.

# Load packages
packages <- c("data.table", "reshape2", "dplyr")
sapply(packages, function(package) {
  if (!require(package, character.only=TRUE, quietly=TRUE)) {
    error(paste('could not load package ', package))
  }
})

# Set base path for data directory
dataPath <- file.path(getwd(), 'UCI\ HAR\ Dataset/')
# Read in zipped datasets
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'UCIHARDataset.zip', method = 'curl')
# Unzip files
unzip('UCIHARDataset.zip', overwrite = T)

# Get training datasets
dtXTrain <- fread(file.path(dataPath, 'train', 'X_train.txt'))
dtYTrain <- fread(file.path(dataPath, 'train', 'y_train.txt'))
dtSubjectTrain <- fread(file.path(dataPath, 'train', 'subject_train.txt'))

# Get test datasets
dtXTest <- fread(file.path(dataPath, 'test', 'X_test.txt'))
dtYTest <- fread(file.path(dataPath, 'test', 'y_test.txt'))
dtSubjectTest <- fread(file.path(dataPath, 'test', 'subject_test.txt'))

# Get features
dtFeatures <- fread(file.path(dataPath, 'features.txt'))

###################################################################
# 1) Merge the training and the test sets to create one data set. #
###################################################################

# Merge datasets by row
dtMergedX <- rbind(dtXTrain, dtXTest)
dtMergedY <- rbind(dtYTrain, dtYTest)
dtMergedSubject <- rbind(dtSubjectTrain, dtSubjectTest)

# Set names
setnames(dtMergedSubject, 'V1', 'subjectId')
setnames(dtMergedY, 'V1', 'activityId')
setnames(dtFeatures, c('V1', 'V2'), c('measureId', 'measureName'))

# Merge datasets by column
dtMergedSubjectY <- cbind(dtMergedSubject, dtMergedY)
dtMergedSubjectYX <- cbind(dtMergedSubjectY, dtMergedX)

# Sort by subjectId then activityId
setkey(dtMergedSubjectYX, subjectId, activityId)

###############################################################################################
# 2)  Extracts only the measurements on the mean and standard deviation for each measurement. #
###############################################################################################

dtMeanStdDeviationFeatures <-
  dtFeatures[grepl('(mean|std)\\(\\)', dtFeatures$measureName), ]

# Merge tables
dtMeanStdDeviationFeaturesData <-
  merge(dtMergedSubjectYX, dtMeanStdDeviationFeatures, by.x='activityId', by.y='measureId')

# Get just mean and std deviation features
keysToSelect <- c(key(dtMergedSubjectYX), paste0('V', dtMeanStdDeviationFeatures$measureId))
dtMeanStdDeviationFeaturesData <-
  subset(dtMeanStdDeviationFeaturesData, select = keysToSelect)

###############################################################################
# 3)  Uses descriptive activity names to name the activities in the data set. #
###############################################################################

# Get labels
dtLabels <- fread(file.path(dataPath, 'activity_labels.txt'))

# Set names
setnames(dtLabels, c('V1', 'V2'), c('activityId', 'activityName'))

# Merge names into table
dtMeanStdDeviationFeaturesData <-
  merge(dtMeanStdDeviationFeaturesData, dtLabels, by = 'activityId')

# Sort data table
setkey(dtMeanStdDeviationFeaturesData, subjectId, activityId, activityName)

# Convert from wide to narrow data table
dtMeanStdDeviationFeaturesData <-
  melt(dtMeanStdDeviationFeaturesData,
       id=c('subjectId', 'activityName'),
       measure.vars = c(3:68),
       variable.name = 'measureId',
       value.name='measureValue')

############################################################################
#   4)  Appropriately labels the data set with descriptive variable names. #
############################################################################

dtFeatures <-
  mutate(dtFeatures, measureId = paste0('V', dtFeatures$measureId))

# Merge in feature names
dtMeanStdDeviationFeaturesData <-
  merge(dtMeanStdDeviationFeaturesData, dtFeatures, by = 'measureId')

# Convert activityName and measureName into factors
dtMeanStdDeviationFeaturesData$activityName <-
  factor(dtMeanStdDeviationFeaturesData$activityName)
dtMeanStdDeviationFeaturesData$measureName <-
  factor(dtMeanStdDeviationFeaturesData$measureName)

#################################################################################################
# 5)  From the data set in step 4, creates a second, independent tidy data set with the average #
#     of each variable for each activity and each subject.                                      #
#################################################################################################

dtMeanStdDeviationAverages <-
  dcast(dtMeanStdDeviationFeaturesData,
        subjectId + activityName ~ measureName,
        mean,
        value.var = 'measureValue')

# Write out tidy data file
write.table(dtMeanStdDeviationAverages, file = 'tidyData.txt', row.name = FALSE)