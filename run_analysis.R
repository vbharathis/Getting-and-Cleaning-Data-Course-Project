##Step1
##Merge test and training data set into one merged data set

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data_Set <- cbind(Subject, Y, X)

##Step2
##Extract only mean and std deviation for each measurement

TidyData_set <- Merged_Data_Set %>% select(subject, code, contains("mean"), contains("std"))


##Step 3
## Uses descriptive activity names to name the activities in the data set.

TidyData_set$code <- activities[TidyData_set$code, 2]

##Step4
##Labels the data set with descriptive variable names.

names(TidyData_set)[2] = "activity"
names(TidyData_set)<-gsub("Acc", "Accelerometer", names(TidyData_set))
names(TidyData_set)<-gsub("Gyro", "Gyroscope", names(TidyData_set))
names(TidyData_set)<-gsub("BodyBody", "Body", names(TidyData_set))
names(TidyData_set)<-gsub("Mag", "Magnitude", names(TidyData_set))
names(TidyData_set)<-gsub("^t", "Time", names(TidyData_set))
names(TidyData_set)<-gsub("^f", "Frequency", names(TidyData_set))
names(TidyData_set)<-gsub("tBody", "TimeBody", names(TidyData_set))
names(TidyData_set)<-gsub("-mean()", "Mean", names(TidyData_set), ignore.case = TRUE)
names(TidyData_set)<-gsub("-std()", "STD", names(TidyData_set), ignore.case = TRUE)
names(TidyData_set)<-gsub("-freq()", "Frequency", names(TidyData_set), ignore.case = TRUE)
names(TidyData_set)<-gsub("angle", "Angle", names(TidyData_set))
names(TidyData_set)<-gsub("gravity", "Gravity", names(TidyData_set))


##Step5
## create an independent tidy data set with the average of each variable for each activity and each subject

FinalData_set <- TidyData_set %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData_set, "FinalData_Set.txt", row.name=FALSE)

##Testing of  variable name
str(FinalData_set)

