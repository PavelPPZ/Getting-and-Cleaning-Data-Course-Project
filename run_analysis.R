## Getting and Cleaning Data Course Project

## You should create one R script called run_analysis.R that does the following. 
##  1.	Merges the training and the test sets to create one data set.
##  2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3.	Uses descriptive activity names to name the activities in the data set
##  4.	Appropriately labels the data set with descriptive variable names. 
##  5.	From the data set in step 4, creates a second, independent tidy data set
##      with the average of each variable for each activity and each subject.

run_analysis <- function() {
        
        library(dplyr)
        
        ## set working directory with data files
        
        setwd("~/Data Science materials/Getting and Cleaning Data/Project")
        
        # merge participant lists - test + train
        
        p_test <- read.table("getdata_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
        p_train <- read.table("getdata_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
        
        participants <- rbind(p_test,p_train) ## merge rows 
        colnames(participants) <- "Subject" ## assign column name
        
        write.csv(participants,"Subject.csv") ## save to file
        print("Subjects merged and saved")
        
        # merge activity id lists - test + train
        
        a_test <- read.table("getdata_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
        a_train <- read.table("getdata_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
        
        activities <- rbind(a_test,a_train) ## merge rows 
        colnames(activities) <- "Activity"  ## assign column name
        
        # replace Activity id with Activity name
        
        labels <- read.table("getdata_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
        
        ## replacing activity ids with labels
        for (i in 1:6) {activities$Activity[activities$Activity == i] <- labels[i,2]} 
        
        write.csv(activities,"activity.csv") ## save to file
        print("Activities merged and saved")
        
        ## select columns with mean and std
        features <- read.table("getdata_UCI HAR Dataset/UCI HAR Dataset/features.txt")
        
        v_mean <- grep("mean",features$V2,ignore.case=TRUE) ## get columns with mean
        v_std <- grep("std",features$V2,ignore.case=TRUE)   ## get columns with get
        v_ms <- c(v_mean,v_std) ## vector with column numbers to select
        
        features_sel <- features[v_ms,2] ## list of column names
        
        #merge data - test + train
        data_test <- read.table("getdata_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
        data_train <- read.table("getdata_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
        
        data <- rbind(data_test,data_train) ## merge rows  
        
        data_sel <- select(data,all_of(v_ms)) ## selection of columns with mean and std
        
        colnames(data_sel) <- features_sel ## assign column names
        
        write.csv(data_sel,"data_sel.csv") ## save to file
        print("Data merged and saved")
        
        
        ## create final data set - merge of participants + activities + data_sel
        
        data_final <- cbind(participants,activities,data_sel)  ## merge columns
        
        write.csv(data_final,"data_final.csv") ## save to file
        print("Final data set created")
        
        ## create of independent data set
        data_grouped <- group_by(data_final,Subject,Activity) ## grouping
        
        ## aggregation and calculation of mean by group
        aggr_data <- summarise(data_grouped, across(everything(), mean),.groups="keep") 
        
        write.csv(aggr_data,"aggr_data.csv") ## save to file
        write.table(aggr_data,"aggr_data.txt",row.name=FALSE)
        print("Aggregated data set created")
}
