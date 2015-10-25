## Installing and loading "dplyr" package

# install.packages("dplyr")
# library(dplyr)

## Downloading, unzipping and reading the files

if(!file.exists("./data")) {dir.create("./data")}
dateDownloaded = date() ## "Sun Oct 25 14:31:41 2015"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./data/dataset.zip", mode='wb')
unzip("./data/dataset.zip", overwrite = TRUE, exdir = "./data")

## Activity labels and names of features

actLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")
features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE, sep = " ")

## Train dataset

trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainY <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
people_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)

## Test dataset

testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
testY <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
people_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## Renaming columns in train and test sets

featureN <- as.character(features$V2)
names(trainX) <- featureN
names(testX) <- featureN

## Merging training and test sets

acceleration <- rbind(trainX, testX)
activities <- rbind(trainY, testY)
people <- rbind(people_train, people_test)

## Merging measurements with subjects and activities

acceleration <- cbind(people, activities, acceleration)
names(acceleration)[1:2] = c("subject", "activity")

## Removing variables from the dataset that do not contain "mean()" and "sd()", excluding variables of subject and activity

NeededVars <- grepl("mean()", names(acceleration)) | grepl("std()", names(acceleration)) | grepl("activity", names(acceleration)) | grepl("subject", names(acceleration))
acceleration <- acceleration[NeededVars]
rm(NeededVars)

## Adding names of activities

acceleration <- merge(acceleration, actLabels, by.x = "activity", by.y = "V1")
acceleration$activity <- acc$V2
acceleration$V2 <- NULL

## Removing unnecessary variables

rm(trainY, testY, activities, actLabels, featureN, features, people, people_test, people_train, testX, trainX)

## Reading inertial signals for both training and test sets and merging them

## Inertial signals for train dataset

body_acc_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE)
body_acc_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE)
body_acc_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE)

body_gyro_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE)
body_gyro_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE)
body_gyro_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE)

total_acc_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE)
total_acc_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE)
total_acc_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE)

## Inertial signals for test dataset

body_acc_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE)
body_acc_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE)
body_acc_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE)

body_gyro_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE)
body_gyro_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE)
body_gyro_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE)

total_acc_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE)
total_acc_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE)
total_acc_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE)

## Merging inertial signals sets

body_acc_x <- rbind(body_acc_x_train, body_acc_x_test)
body_acc_y <- rbind(body_acc_y_train, body_acc_y_test)
body_acc_z <- rbind(body_acc_z_train, body_acc_z_test)

body_gyro_x <- rbind(body_gyro_x_train, body_gyro_x_test)
body_gyro_y <- rbind(body_gyro_y_train, body_gyro_y_test)
body_gyro_z <- rbind(body_gyro_z_train, body_gyro_z_test)

total_acc_x <- rbind(total_acc_x_train, total_acc_x_test)
total_acc_y <- rbind(total_acc_y_train, total_acc_y_test)
total_acc_z <- rbind(total_acc_z_train, total_acc_z_test)

rm(body_acc_x_train, body_acc_x_test, body_acc_y_train, body_acc_y_test, body_acc_z_train, body_acc_z_test)
rm(body_gyro_x_train, body_gyro_x_test, body_gyro_y_train, body_gyro_y_test, body_gyro_z_train, body_gyro_z_test)
rm(total_acc_x_train, total_acc_x_test, total_acc_y_train, total_acc_y_test, total_acc_z_train, total_acc_z_test)

## Calculating means of 128 elements in each observarion in inertial signals sets

bodyAccX_mean <- rowMeans(body_acc_x)
bodyAccY_mean <- rowMeans(body_acc_y)
bodyAccZ_mean <- rowMeans(body_acc_z)

bodyGyroX_mean <- rowMeans(body_gyro_x)
bodyGyroY_mean <- rowMeans(body_gyro_y)
bodyGyroZ_mean <- rowMeans(body_gyro_z)

totalAccX_mean <- rowMeans(total_acc_x)
totalAccY_mean <- rowMeans(total_acc_y)
totalAccZ_mean <- rowMeans(total_acc_z)

## Attaching them to the main dataset and changing the order of columns

acceleration <- cbind(bodyAccX_mean, bodyAccY_mean, bodyAccZ_mean, bodyGyroX_mean, bodyGyroY_mean, bodyGyroZ_mean, totalAccX_mean, totalAccY_mean, totalAccZ_mean, acceleration)
acceleration <- acceleration[ , c(11, 10, 1:9, 12:90)]

## Removing unnecessary variables

rm(bodyAccX_mean, bodyAccY_mean, bodyAccZ_mean, bodyGyroX_mean, bodyGyroY_mean, bodyGyroZ_mean, totalAccX_mean, totalAccY_mean, totalAccZ_mean)
rm(body_acc_x, body_acc_y, body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y, total_acc_z)

## Ordering the dataset by subject and activity

acceleration <- arrange(acceleration, subject, activity)

## Tidy dataset is ready

## Creating summarized data for Step 5

summarySet <- group_by(acceleration, subject, activity)
summarySet <- summarize_each(summarySet, funs(mean))

## Step 5 is done

write.table("step5data.txt", row.name = FALSE)
