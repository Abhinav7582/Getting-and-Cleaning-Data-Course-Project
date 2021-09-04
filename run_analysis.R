
#Downloading the data

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "./Dataset.zip")


#Unzipping the file
unzip("Dataset.zip",exdir = "C:/Users/Abhinav/OneDrive/Documents")


#Unzipped files are in the folder named UCI HAR Dataset.

path <- "C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset"

filelist <- list.files(path, pattern=NULL)
filelist

#Assigning the database

features <- read.table("C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset/features.txt",col.names = c("id","function"))


activites <- read.table("C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset/activity_labels.txt",col.names = c("code","activity"))


subject_test <- read.table("C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset/test/subject_test.txt",col.names="subject")


x_test <- read.table("C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset/test/X_test.txt", col.names = features$function.)


y_test <- y_test <- read.table("C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset/test/y_test.txt", col.names = "code")


subject_train <- read.table("C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset/train/subject_train.txt",col.names = "subject")


x_train <- read.table("C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset/train/X_train.txt",col.names = features$function.)


y_train <- read.table("C:/Users/Abhinav/OneDrive/Documents/R/UCI HAR Dataset/train/y_train.txt",col.names="code")


#Step 1: Merging the training and the test sets to create one data set.

X <- rbind(x_test,x_train)
Y <- rbind(y_test,y_train)
subject <- rbind(subject_test,subject_train)

merge_data <- cbind(X,Y,subject)

View(head(merge_data))


library(dplyr)


#Step 2: Extracting only the measurements on the mean and standard deviation for each measurement.

tidyData <- merge_data %>% 
  select(subject, code, contains("mean"), contains("std"))


#Step 3: Using descriptive activity names to name the activities in the data set.

tidyData$code <- activites[tidyData$code, 2]


#Step 4:Appropriately labeling the data set with descriptive variable names.

names(tidyData)[2] = "activity"

names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData))

names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData))

names(tidyData)<-gsub("BodyBody", "Body", names(tidyData))

names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))

names(tidyData)<-gsub("^t", "Time", names(tidyData))

names(tidyData)<-gsub("^f", "Frequency", names(tidyData))

names(tidyData)<-gsub("tBody", "TimeBody", names(tidyData))

names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)

names(tidyData)<-gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)

names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)

names(tidyData)<-gsub("angle", "Angle", names(tidyData))

names(tidyData)<-gsub("gravity", "Gravity", names(tidyData))


#Step 5: From the data set in step 4, create a second independent tidy data set with the average of each variable for each activity and each subject.

finalData <- tidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(finalData, "finalData.txt", row.name=FALSE)
str(finalData)
