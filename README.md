Getting and Cleaning Data Project Code Book
========================================================

## Run the run_analysis.R script in your working directon on your computer. The script does the following operations:

## Downloads the zipped data files from the UCI HAR Dataset and unzip

## Reads data into R objects 
### - Stores the R objects in your working directory or define a path from your working directory to the R objects under consideration.  

## Cleans up feature labels, remove `(` and `)` from the labels
### - The feature labels are the same as the R variables which define the data columns.

## Selects columns with mean and std in the feature/variable name
### - Create a smaller train and test data set containing only mean and std related variables. 

## Adds column for subject, i.e. the number code for the smart phones.
### - Does this for both the train and test data set.
### - The data are specified in y_train.txt and y_test.txt

## Adds column for activity according to activity_labels
### - Does this for both the train and test data set.

## Names the columns with the feature label/variable names
### - Does this for both the train and test data set.
### - The subject variables (or columns) are called subject_train and subject_test for the train and test data set, respectively.

## Merges the train and test data sets.

## Writes merged data set to the file mergeddata.csv and mergeddata.txt
#### The mergeddata.txt file is the same with space separated variables/columns, however csv files cannot be attached on Coursera's project submission page so I had to create a file with the txt extension as well.   

