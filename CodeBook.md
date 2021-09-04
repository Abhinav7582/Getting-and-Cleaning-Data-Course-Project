The run_analysis.R script performs the functions given below.

Download the Dataset

After the Dataset is downloaded and extracted under the folder called UCI HAR Dataset. Assign each data to variables

1. features <- features.txt
2. subject_test <- test/subject_test.txt
3. x_test <- test/X_test.txt
4. y_test <- test/y_test.txt
5. subject_train <- test/subject_train.txt
6. x_train <- test/X_train.txt
7. y_train <- test/y_train.txt

Merge the training and the test sets to create one dataset

1. X is created by merging x_train and x_test using rbind() function
2. Y is created by merging y_train and y_test using rbind() function
3. Subject is created by merging subject_train and subject_test using rbind() function
4. merged_Data is created by merging Subject, Y and X using cbind() function

Extract only the measurements on the mean and standard deviation for each measurement

1. tidyData is created by subsetting merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Use descriptive activity names to name the activities in the data set

1. Entire numbers in code column of the tidyData replaced with corresponding activity taken from second column of the activities variable

Appropriately label the data set with descriptive variable names

Code column in TidyData renamed into activities

1. All Acc in column’s name replaced by Accelerometer
2. All Gyro in column’s name replaced by Gyroscope
3. All BodyBody in column’s name replaced by Body
4. All Mag in column’s name replaced by Magnitude
5. All start with character f in column’s name replaced by Frequency
6. All start with character t in column’s name replaced by Time

From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

1. FinalData is created by sumarizing tidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
2. Export finalData into finalData.txt file.
