## R script run_analysis.R for project in Coursera course Getting and Cleaning data 

## Download data

if (!file.exists("UCI HAR Dataset")) {
  if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
    stop("was expecting HAR Dataset folder or zip file")
  } else {
    unzip("getdata_projectfiles_UCI HAR Dataset.zip")
  }
}

## fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## download.file(fileUrl, destfile = "getdata_projectfiles_UCI HAR Dataset.zip")

## Read data into R objects

x_test = read.table("UCI HAR Dataset/test/X_test.txt", sep = "")
y_test = read.table("UCI HAR Dataset/test/y_test.txt", sep = "")
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", sep = "")

x_train = read.table("UCI HAR Dataset/train/X_train.txt", sep = "")
y_train = read.table("UCI HAR Dataset/train/y_train.txt", sep = "")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", sep = "")

activity_labels = read.table("UCI HAR Dataset/activity_labels.txt", sep = "")
features = read.table("UCI HAR Dataset/features.txt", sep = "")

## Clean up feature labels, remove `(` and `)`.

features$V2 = gsub("\\(", "", features$V2)
features$V2 = gsub("\\)", "", features$V2)

## Pick up column indices and labels for mean and std.

column.indices.mean.std = features[c(grep("mean", features$V2), grep("std", features$V2)),]$V1
column.labels.mean.std = features[c(grep("mean", features$V2), grep("std", features$V2)),]$V2

## Select columns with mean and std

x_train.mean.std = x_train[,column.indices.mean.std]
x_test.mean.std = x_test[,column.indices.mean.std]

## Add column for subject, i.e. the number code for the smart phones.

x_train.mean.std.subject = cbind(subject_train, x_train.mean.std)
x_test.mean.std.subject = cbind(subject_test, x_test.mean.std)

## Add column for activity according to activity_labels.

y_train.labels = y_train
for (i in 1:6)
y_train.labels$V1 = gsub(i, activity_labels$V2[i], 
                    y_train.labels$V1) 
y_test.labels = y_test
for (i in 1:6)
  y_test.labels$V1 = gsub(i, activity_labels$V2[i], 
                           y_test.labels$V1)

x_train.mean.std.subject.activity = cbind(y_train.labels$V1, x_train.mean.std.subject)
x_test.mean.std.subject.activity = cbind(y_test.labels$V1, x_test.mean.std.subject)

## Name the columns

colnames(x_train.mean.std.subject.activity) = c("activity", "subject_train", column.labels.mean.std)
colnames(x_test.mean.std.subject.activity) = c("activity", "subject_test", column.labels.mean.std)

## Merge training and testing data sets.

merged.data = merge(x_train.mean.std.subject.activity, 
                    x_test.mean.std.subject.activity, all = TRUE)

## Write merged.data to file mergeddata.csv

write.csv(merged.data, "mergeddata.csv")

## Note that Coursera does not accept attached .csv files!
## This file is space separated by default in R.
write.table(merged.data, "mergeddata.txt") 


