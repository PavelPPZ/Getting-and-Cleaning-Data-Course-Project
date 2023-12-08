# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project for Coursera

TASK
You should create one R script called run_analysis.R that does the following. 
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

DATA SOURCE
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

PROJECT DESCRIPTION
Data was loaded from data source mentioned above and extracted to local drive
Data structure was studied based on README and information file provided with data

Based on project task the files relevant to the project were identified: 
- features - list of 561 variables
- activity_labels - table with activity ID and full title
- subject - info on participant/subject
- y_... - info on activity
- X_... - table with variables
Last 3 data sets are divided in data set into train and test subsets. 

KEY STEPS
Data sets that were divided into train and test subsets (subject..., X_ ..., y_...) were merged together by rows to form single data set. 

Based on project task only variables/columns with mean and std were selected for final data set. 

This data set was merged by column with data on Subject and Activity explanation. That created one single data set with all required data.
Created data set meets the requirements to tidy data.
Results were saved in "data_final.csv" file.

In addition the aggregated data set was created with data grouped by Subject and Activity. 
Foe each group combination average was calculated for each variable. 
Results were saved in "aggr_data.csv" file.

*******




