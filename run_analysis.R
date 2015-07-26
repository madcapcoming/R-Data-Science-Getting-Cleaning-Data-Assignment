
library(plyr)

# Question 1
################# Merge Data Into One Set##################

merg_ytrain <- read.table("train/Y_train.txt")
merg_xtrain <- read.table("train/X_train.txt")

merg_train <- read.table("train/subject_train.txt")


merg_ytest <- read.table("test/Y_test.txt")
merg_xtest <- read.table("test/X_test.txt")

merg_test <- read.table("test/subject_test.txt")


xdata <- rbind(merg_xtrain, merg_xtest)
ydata <- rbind(merg_ytest, merg_ytrain)

finaldata <- rbind(merg_train, merg_test)

# Question 2
#################### Extract Mean and SD ##################

features <- read.table("features.txt")

# mean() or std() only columns
mean_sd_data <- grep("-(mean|std)\\(\\)", features[, 2])

# subset columns
xdata <- xdata[, mean_sd_data]

#column names
names(xdata) <- xdata[mean_sd_data, 2]

# Question 3
########################## Moding Acticies Names in Data Set #################

# Pull Names
activities <- read.table("activity_labels.txt")

# Input Data
ydata[, 1] <- activities[ydata[, 1], 2]

names(ydata) <- "activity"


#Question 4
######################## Label the Rest ################

names(finaldata) <- "subject"

alldata <- cbind(finaldata, ydata, xdata)

# Question 5
###################### Averages Per Person, Activity ###############
library(dplyr)

grouped <- ddply(alldata, .(subject, activity), function(x) colMeans(x[, 3:66]))

write.table(grouped, "grouped_data.txt", row.name=FALSE)

