README 

This file explains the script  for the final project of Getting and Cleaning Data course from JHU on coursera.com.
 
The purpose of this script is to combine, trim and clean the data from the University of California Irvine Human Activity Recognition Using Smartphones Data Set, as described in the instructions of the Getting and cleaning data course project by John Hopkins University on Coursera. 


The script starts by opening packages stringr and dplyr, whose functions will be used later (lines 1-2):
```R 
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
First, the code checks if folder with the data is present in the working directory (assuming its name was not changed). 
If not, the function downloads it. The download method is initially set to "curl" (line 5), which is the method used on Mac and Linux operating systems. Next, the code checks if the OS is in fact a Windows, in which case the download method is changed to "wininet" (lines  6-8). 
Then, the URL for the data is put in, to feed into the next function which downloads the data (lines 9-10), naming it "UCI.zip". Other arguments of this function are the download method (dlmethod), as well as mode = "wb", which is the mode for downloading .zip files. Finally the file containing the data is unpacked into the working directory (line 11).

Next, the unzipped folder is set as the new working directory (line 13)
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
At first 3 data frames are read. They are y_test(containing the activity labels), x_test (the test set) and subjest_test(subjects who performed the activities). They are all .txt files, read using read.table function. These three data frames are part of the same data set, containing different variables (activity, measurements and subjects, respectively). They are then combined horizontally using rbind (lines 18-19) into one data frame, the first column being participants, second being activity, followed by the rest of variables.

The same actions are repeated for the training data (lines 21-25)
```R
yTrain <- read.table("./train/y_train.txt") 
xTrain <- read.table("./train/X_train.txt") 
subjectTrain <- read.table("./train/subject_train.txt")
train <- cbind(yTrain, xTrain)
train <- cbind(subjectTrain, train) ## full training df
```
Next, the two data frames are combined vertically using rbind to create "data" (line 26). This data frame contains all the measurements of training and test, together with the participants and activity.
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
At first, file features.txt is read into data frame "labels". It contains the names of all the variables of xTest and xTrain. The data frame has two columns, first being the index, second, the variable names. Therefore, the second column was extracted (line 29), and its components changet to charactrers (line 30). The last step was performed in order to avoid problems when searching for specific variable names or changing them.
Next, the names of the columns in "data" are changed (line 31), putting "Participant" and "Activity" before the names of measurements from the experiments.

Next, the scrip introduces variable "a", which is an index of all the variable names containing words "std" (standard deviation) "mean" (line 33)
```R
a <- grep(".std|mean.", names(data)) ## index of all columns containing "std" or "mean"
```
A new data frame, "sdmean" is created by extracting variables indexed in "a" (as well as "Participant" and "Activity) from "data" (line 34)
```R
sdmean <- data[, c(1, 2, a)]
```
The new data frame is then rearranged by participant and then activity. This is where the dplyr package is used for its "%>%" operator.
```R
sdmean <- sdmean %>% arrange(Participant, Activity) 
```
The next part of the code changes some the column names (lines 37-38)
```R
names(sdmean) <- gsub("\\()", "", names(sdmean)) 
names(sdmean) <- gsub("([A-Z][a-z]+)\\1", "\\1", names(sdmean))
```
The variable names had some unnecessary characters, as well as repeated words which were removed (in line 37 and 38, respectively), using grep function. Some variables also included  a dash before axis name, these however, were left unchanged to keep the names readable.

The next step changes the factors of variable "Activity" (lines 39-40)
```R
sdmean$Activity <- str_replace_all(sdmean$Activity, c("1" = "Walking", "2" = "Walking Upstairs", 
                                                      "3" = "Walking downstairs", "4" = "Sitting",
                                                      "5" = "Standing", "6" = "Laying"))
```
Numbers 1 to 6 were replaced by descriptive names they were used for. str_replace_all is a function found in stringr package.

Finally, the data was saved to file sdmean.csv (line 42)
```R
write.csv(sdmean, file = "sdmean.csv")
```

In the last step of the project, the data in "sdmean" was summarised (line 44)
```R
datasummarised <- sdmean %>% group_by(Participant, Activity) %>% summarise_all(funs(mean))
```
Each participant performed each activity a few times, so a mean value of each variable was completed for each activity for each participant.
The data frame it produced, called "datasummarised" was then saved into a file datasummarised.csv (line 45)
```R
write.csv(datasummarised, file = "datasummarised.csv")
```
