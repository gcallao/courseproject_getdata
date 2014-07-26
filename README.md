README - GETTING AND CLEANING DATA COURSE PROJECT

TIDYDATA02 SET - HUMAN ACTIVITY RECOGNITION USING SMARTPHONES
JULY 2014

gcallao
https://github.com/gcallao/courseproject_getdata

"The purpose of this project is to demostrate the capacity to collect, work with, and clean a data set. The goal is to prepare tidy data sets that can be used for later analysis."

The data used as input for this project are from the Human Activity Recognition Using Smartphones project found in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and its description available in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

For the purpose of this project it was used only the following data sets from the Human Activity Recognition project:       
-train/Subject_train.txt: Each row identifies the subject who performed the activity for each window sample in the train set. Its range is from 1 to 30.             
-test/Subject_test.txt: Each row identifies the subject who performed the activity for each window sample in the test set. Its range is from 1 to 30.          
-train/X_train.txt: Training set.         
-train/Y_train.txt: Training labels.          
-test/X_test.txt: Test set.         
-test/Y_test.txt: Test labels.        
-features.txt: List of all features.      
-activity_labels.txt: Links the class labels with their activity name.

In the github repository for this project it should be find the following files:        
-README.md        
-CodeBook.md: The variable dictionary.        
-run_analysis.R: The R script for processing the data.      
-tidydata01.txt: The first tidy data requested.     
-tidydata02.txt: The second tidy data requested.      

The data process procedure is detailed with comments in run_analysis.R. The general picture goes like this:     
1. Read all the data listed previously.       
2. Merge the test and train set independently (X,Y and Subject sets) to finally merge the complete test and train set to create one data set.      
3. Label all the variables in the data set.       
4. Assigned descriptive activity names to the activities in the data set.     
5. Extract only the measurements of the mean and standard deviation in the data set using the grep command.     
6. Create the first tidy data set(tidydata01.txt).      
7. Calculate the average value for each variable for each activity and each subject using as input the first tidy data set(tidydata01.txt) using the functions split and sapply.     
8. Give form to the second tidy data set using t(transpose), text connection among others functions.      
9. Rename the variable names adding a "-mean" string to the original names, and ordering the data set by the subject variable.       
10. Create the second tidy data set(tidydata02.txt).      
