Getting and Cleaning Data - Course Project
==========================================

This repository contains the R script and documentation for the John Hopkins University Data Science's track course "Getting and Cleaning data".

The dataset of this project is: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Project Files

`README.md` is this file!

`UCIHARDataset.zip` is an intermediate file that the analysis script will attempt to download the file from a static mirror, namely https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This file is a compressed representation of the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) mentioned above. This compressed file will be automatically uncompressed by the analysis script to a folder in the current working directly called "UCI HAR Dataset".

`CodeBook.md` specifies the structural modifications to the data and indicates all the variables and summaries calculated, along with units, and other relevant information.

`run_analysis.R` is a script to conduct the 5 analysis steps described in the course project assignment.

`tidyData.txt` is the output of `run_anaylsis.R`, which complies with the Tidy Data principles set forward in the class and in compliance with the assignment.
