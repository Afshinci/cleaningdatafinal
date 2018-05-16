library(dplyr)
library(stringr)

if(!dir.exists("./UCI HAR Dataset")){
    dlmethod <- "curl"
    if(substr(Sys.getenv("OS"), 1, 7) == "Windows"){
        dlmethod <- "wininet"
    }
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, destfile = "UCI.zip", method = dlmethod, mode = "wb")
    unzip(zipfile = "UCI.zip")
}
setwd("./UCI HAR Dataset")

yTest <- read.table("./test/y_test.txt") ## activity label
xTest <- read.table("./test/X_test.txt") ## test set
subjectTest <- read.table("./test/subject_test.txt") ## subjects that performed tests
test <- cbind(yTest, xTest) 
test <- cbind(subjectTest, test) ## full test df 

yTrain <- read.table("./train/y_train.txt") 
xTrain <- read.table("./train/X_train.txt") 
subjectTrain <- read.table("./train/subject_train.txt")
train <- cbind(yTrain, xTrain)
train <- cbind(subjectTrain, train) ## full training df
data <- rbind(test, train) ## all data, training and test

labels <- read.table("./features.txt")
labels <- labels[,2]
labels <- as.character(labels)
names(data) <- c("Participant", "Activity", labels) 

a <- grep(".std|mean.", names(data)) ## index of all columns containing "std" or "mean"
sdmean <- data[, c(1, 2, a)] ## only variables containing stdev and mean, as well as 
                            ##participant and activity
sdmean <- sdmean %>% arrange(Participant, Activity) 
names(sdmean) <- gsub("\\()", "", names(sdmean)) 
names(sdmean) <- gsub("([A-Z][a-z]+)\\1", "\\1", names(sdmean))
sdmean$Activity <- str_replace_all(sdmean$Activity, c("1" = "Walking", "2" = "Walking Upstairs", 
                                                      "3" = "Walking downstairs", "4" = "Sitting",
                                                      "5" = "Standing", "6" = "Laying"))
write.table(sdmean, file = "sdmean.txt", row.names = FALSE)

datasummarised <- sdmean %>% group_by(Participant, Activity) %>% summarise_all(funs(mean))
write.table(datasummarised, file = "datasummarised.txt", row.names = FALSE)
