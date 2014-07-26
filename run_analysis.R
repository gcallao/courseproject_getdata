#Set the working directory in the UCI HAR Dataset folder found in the unzipped file downloaded

#Read the x_train and x_test
x_train <- read.csv("./train/x_train.txt", header = FALSE, sep = "", colClasses = "numeric")
x_test <- read.csv("./test/x_test.txt", header = FALSE, sep = "", colClasses = "numeric")

#Read the y_train and y_test (activity indicators)
y_train <- read.csv("./train/y_train.txt", header = FALSE,colClasses = "integer")
y_test <- read.csv("./test/y_test.txt", header = FALSE, colClasses = "integer")

#Read the subjects IDs
subject_train <- read.csv("./train/subject_train.txt", header = FALSE, colClasses = "factor")
subject_test <- read.csv("./test/subject_test.txt", header = FALSE, colClasses = "factor")

#Read the variables names and the activity labels data sets
var_names <- read.csv("features.txt", header = FALSE,sep = "", colClasses = "character")
act_label <- read.csv("activity_labels.txt", header = FALSE, sep = "", colClasses = "factor")

#Eliminate V1 columms in var_names and act_label
var_names$V1 <- NULL
act_label$V1 <- NULL


### MERGING PROCESS ###
#Merge the x_train and x_test with their respective subject and activity data frame
xy_train <- data.frame(subject_train, y_train, x_train)
xy_test <- data.frame(subject_test, y_test, x_test)

#Merge the training and the test sets to create one data set
xy_train_test <- rbind(xy_train, xy_test)


### LABELING THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES ###
#Create the label variable data frame
var_names <- rbind("Subject","Activity", var_names)

#Label the variables in xy_train_test with var_names
colnames(xy_train_test) <- var_names$V2


### USING DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET ###
xy_train_test$Activity <- as.factor(xy_train_test$Activity)
levels(xy_train_test$Activity) <- act_label$V2


### EXTRACT THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT ###
tidydata01 <- xy_train_test[, grep("*mean()|std()", names(xy_train_test))]
tidydata01 <- tidydata01[, -grep("meanFreq()", names(tidydata01))] 
tidydata01 <- cbind(xy_train_test[, 1:2], tidydata01)

#Create the first tidy data set
write.table(tidydata01, "tidydata01.txt")


### CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE 
### FOR EACH ACTIVITY AND EACH SUBJECT
#Split and calculate the mean of tidydata01 considering the subject and activity as factors
split <- split(tidydata01[,3:68], list(tidydata01$Subject, tidydata01$Activity))
tidydata02 <- sapply(split, colMeans)

#Transpose tidydata02 and transform it as a data frame
tidydata02 <- t(tidydata02)
tidydata02 <- as.data.frame(tidydata02)

#Create a text connection separate the subject and activity values in row.names(tidydata02)
y <-row.names(tidydata02)
con <- textConnection(y)
Subject_activity <- read.table(con, sep = ".")
close(con)

#Give appropiate names to the variables in tidydata02
colnames <- paste(names(tidydata02), "-mean",sep="")
colnames(tidydata02) <- colnames

#Bind the subject and activity data with tidydata02 an label its variable names
tidydata02 <- cbind(Subject_activity, tidydata02)
names(tidydata02)[names(tidydata02) == "V1"] <- "Subject"
names(tidydata02)[names(tidydata02) == "V2"] <- "Activity"

#Order tidydata02 by subject and eliminate its row names
tidydata02 <- tidydata02[order(tidydata02$Subject), ]
row.names(tidydata02) <- NULL

#Create the second tidy data set
write.table(tidydata02, "tidydata02.txt")