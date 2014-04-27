# Cleaning the data for the assignment 1

#folder = "UCI HAR Dataset\\test"
# Read the features and labels
print("run_analysis.R :  makes the activity dataset tidy")
print("Assumptions :  working folder has the features.txt and activity_labels.txt files")
print("Assumptions :  in the test and train folders, results from train and test datasets")

library(reshape2)
print("---- Reading label and feature files ----")
folder = ".//"
labelFilename <- file.path(folder, "activity_labels.txt")
labels <- read.table(labelFilename, header = F, col.names =c("ActivityIndex", "ActivityLabel"))
featuresFilename <- file.path(folder, "features.txt")
features <- read.table(featuresFilename, header = F, col.names =c("FeatureIndex", "FeatureLabel"))

print("---- Reading files in the test folder ----")
# Read the test data
folder = "test"
stFilename <- file.path(folder, "subject_test.txt")
testst1 <- read.table(stFilename, header=F, col.names=c("SubjectID"))
xtestFname <- file.path(folder, "X_test.txt")
testxtest <- read.table(xtestFname, header = F, col.names = features$FeatureLabel)
ytestFname <- file.path(folder, "y_test.txt")
testytest <- read.table(ytestFname, header=F, col.names=c("ActivityID"))


#folder = "UCI HAR Dataset\\train"
print("---- Reading files in the train folder ----")
# Read the train data
folder = "train"
stFilename <- file.path(folder, "subject_train.txt")
trainst1 <- read.table(stFilename,  header=F, col.names=c("SubjectID"))
xtestFname <- file.path(folder, "X_train.txt")
trainxtest <- read.table(xtestFname, header = F, col.names = features$FeatureLabel)
ytestFname <- file.path(folder, "y_train.txt")
trainytest <- read.table(ytestFname, header=F, col.names=c("ActivityID"))

# merged dataset
print("---- Merging train and test datasets ----")
st1 <- rbind(trainst1, testst1)
ytest <- rbind(trainytest, testytest)
xtest <- rbind(trainxtest, testxtest)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 

print("---- Finding indices of features for mean() and std() ----")
indmeanfeatures <- features$FeatureIndex[grep("mean()", features$FeatureLabel)]
indstdfeatures <- features$FeatureIndex[grep("std()", features$FeatureLabel)]
indMeanAndStdFeatures <- c(indmeanfeatures,indstdfeatures)
print("---- Attaching descriptive names for the activity indices ----")
actnames = factor(ytest$ActivityID, labels=labels$ActivityLabel)
activitynames <- as.data.frame(actnames)
names(activitynames) <- "ActivityLabel"

print("---- Generating data frame (named data) having descriptive activity names and, mean and std features ----")
data <- cbind(st1, ytest, activitynames, xtest[,indMeanAndStdFeatures])

# 5. Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
varsdesc = c("ActivityID", "ActivityLabel", "SubjectID")
varsmeasurements = setdiff(colnames(data), varsdesc)

meltdata <- melt(data, id=varsdesc, measure.vars=varsmeasurements)
resultdata <- dcast(meltdata, ActivityLabel + SubjectID ~ variable, mean)
tidyfilename = "tidydata.txt"
write.table(resultdata, tidyfilename)
