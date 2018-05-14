README 

This file explains the script  for the final project of Getting and Cleaning Data course from JHU on coursera.com.
 
The purpose of this script is to combine, trim and clean the data from the University of California Irvine Human Activity Recognition Using Smartphones Data Set, as described in the instructions of the Getting and cleaning data course project by John Hopkins University on Coursera. 


The script starts with opening packages stringr and dplyr, whose functions will be used later (lines 1-2):
```R {.line-numbers}
library(stringr)
library(dplyr)
```
The next part of the code deals with checking for and obtaining the original data (lines 4-12)
```R
if(!dir.exists("./UCI HAR Dataset")){
    dlmethod <- "curl"
    if(substr(Sys.getenv("OS"), 1, 7) == "Windows"){
        dlmethod <- "wininet"
    }
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, destfile = "UCI.zip", method = dlmethod, mode = "wb")
unzip(zipfile = "UCI.zip")
}
```
First, checking if the folder with it is present in the w.d. (assuming its name was not changed). 
If not, the function downloads it. The download method is set to "curl" (line 5), which is the method used on Mac and Linux operating systems. Next, the code checks if the OS is a Windows, in which case the download method is changed to "wininet" (lines  6-8). 
Then, the URL for the data is put in, to feed into the next function which downloads the data (lines 9-10), naming it "UCI.zip". Other arguments of this function are the download method (dlmethod), as well as mode = "wb", which is the mode for downloading .zip files. Finally the file containing the data is unpacked into the working directory (line 11).

Next, the unzipped folder is set as the new working directory
```R
setwd("./UCI HAR Dataset")
```

The following lines of code merge different files from the training group (lines 15-19)
```R
yTest <- read.table("./test/y_test.txt") ## activity label
xTest <- read.table("./test/X_test.txt") ## test set
subjectTest <- read.table("./test/subject_test.txt") ## subjects that performed tests
test <- cbind(yTest, xTest) 
test <- cbind(subjectTest, test) ## full test df 
```
At first 3 dataframes are read. They are yTest(containing the activity labels), xTest (the test set) and subjestTest(subjects who performed the activities). THey are all .txt files, read using read.table function. These three data frames are part of the same data set, containing different variables (activity, measurements and subjects, respectively). They are then combined horizontally using rbind (lines 18-19) into one data frame, the first column being participants, second being activity, followed by the rest of variables.

The same actions ore repeated for the training data (lines 21-25)
```R
yTrain <- read.table("./train/y_train.txt") 
xTrain <- read.table("./train/X_train.txt") 
subjectTrain <- read.table("./train/subject_train.txt")
train <- cbind(yTrain, xTrain)
train <- cbind(subjectTrain, train) ## full training df
```
Next, the two data frames are combined vertically using rbind to create "data" (line 26)
```R
data <- rbind(test, train) ## all data, training and test
```
The next portion of the script deals with obtaining and changing the variable names of "data" (lines 28-31)
```R
labels <- read.table("./features.txt")
labels <- labels[,2]
labels <- as.character(labels)
names(data) <- c("Participant", "Activity", labels) 
```
At first, file features.txt is read into data frame labels. T
