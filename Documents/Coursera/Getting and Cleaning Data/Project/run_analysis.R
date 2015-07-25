transform <- function() ## don't call it transform
{

## 
##install.packages("dplyr") 
## also need #tidyr
##need to find code to do this
library("dplyr")

##use chaining if possible

activity_labels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",header = FALSE)
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt",header = FALSE)

##train

X_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",header = FALSE)
Y_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt",header = FALSE)
subject_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

##name variables from features file
colnames(X_train)<-features[,2] 
colnames(Y_train)<-"Activity" 
colnames(subject_train) <- "Subject"

X_train <- X_train[, !duplicated(colnames(X_train))] ##remove duplicated columns

X_train <- select(X_train,contains("mean"), contains("std")) 

X_train <- cbind(subject_train,Y_train,X_train)


##
##test

X_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",header = FALSE)
Y_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt",header = FALSE)
subject_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

##name variables from features file
colnames(X_test)<-features[,2] 
colnames(Y_test)<-"Activity" 
colnames(subject_test) <- "Subject"

X_test <- X_test[, !duplicated(colnames(X_test))] ##remove duplicated columns

X_test <- select(X_test,contains("mean"), contains("std")) 

X_test <- cbind(subject_test,Y_test,X_test)

##

merged_set <- rbind(X_test,X_train)
final_set <- group_by(merged_set,Subject,Activity) 

print(summarise_each(final_set,funs( mean)))


##merge(activity_labels, by=("V1"))



##print(final_set)


}

