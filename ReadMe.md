## Getting and Cleaning Data - Course Project
This is the course project for the Getting and Cleaning Data Coursera course. The R script, `run_analysis.R`, does the following:

Download the dataset if it does not already exist in the working directory
1. Merges the training and test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
   * These measurements are defined as those ending in either "mean()" or std() as defined in the file `features_info.txt` available for download as part of the complete data package [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

3. Uses descriptive activity names to name the activities in the data set.


4. Appropriately labels the data set with descriptive variable names.


5. From the data set in step 4, creates a second, independently tidy data set with the average of each variable for each activity and each subject.
	

The end result is shown in the file `Summarized_Wearable_Data.txt`. Data in this final table is considered tidy because it meets the three criteria of tidy data: each variable forms a column, each row in the table represents a single observation and each observational unit forms a single table. In addition the variable names are desciptive of the measurement in each column.

In this repository you will find:
* __ReadMe.md:__ this file
* __Code Book.md:__ an explanation of the fields contained in `Summarized_Wearable_Data.txt`
* __run_analysis.R:__ R script that processes the raw data and outputs the file `Summarized_Wearable_Data.txt`.
* __Summarized_Wearable_Data.txt:__ a tidy data set showing the average for each variable for each activity and subject
