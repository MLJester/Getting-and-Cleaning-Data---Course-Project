# Load needed packages
library(stringr)
library(reshape2)

features<-read.delim('./UCI HAR Dataset/features.txt',header = F,sep = '')
activity_labels<-read.delim('./UCI HAR Dataset/activity_labels.txt',header = F, sep = '')
train_x<-read.delim('./UCI HAR Dataset/train/X_train.txt',header = F,sep='')
train_y<-read.delim('./UCI HAR Dataset/train/Y_train.txt',header = F, sep='')
train_subject<-read.delim('./UCI HAR Dataset/train/subject_train.txt', header = F, sep = '')
test_x<-read.delim('./UCI HAR Dataset/test/X_test.txt',header = F,sep='') 
test_y<-read.delim('./UCI HAR Dataset/test/Y_test.txt',header = F, sep = '')
test_subject<-read.delim('./UCI HAR Dataset/test/subject_test.txt',header = F, sep = '')

names(features)<-c('columnno','measurementname')
names(activity_labels)<-c('activityid','Activity')
names(train_y)<-c('activityid')
names(train_subject)=c('Subject')
names(test_y)<-c('activityid')
names(test_subject)=c('Subject')

## 1. Merges the training and the test sets to create one data set. ##

testdata<-cbind(test_x,test_y,test_subject)
traindata<-cbind(train_x,train_y,train_subject)
wearabledata<-rbind(testdata,traindata)

## End 1 ##


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. ##

desiredcolumns<-grep('mean\\()|std\\()',features$measurementname)
colnames<-c('Subject','Activity',as.character(features[desiredcolumns,][[2]]))
desiredcolumns[[length(desiredcolumns)+1]]<-562
desiredcolumns[[length(desiredcolumns)+1]]<-563
wearabledata<-wearabledata[,desiredcolumns]
rm(train_x,train_y,train_subject,test_x,test_y,test_subject,testdata,traindata,
        desiredcolumns,features)
gc()

## End 2 ##


## 3. Uses descriptive activity names to name the activities in the data set ##

wearabledata<-merge(wearabledata,activity_labels)
wearabledata$activityid<-NULL
wearabledata<-wearabledata[,c(67:68,1:66)]
rm(activity_labels)
gc()

## End 3 ##


## 4. Appropriately labels the data set with descriptive names. ##

names(wearabledata)<-colnames
names(wearabledata)<-gsub('-','',names(wearabledata))
names(wearabledata)<-gsub('\\.','',names(wearabledata))
names(wearabledata)<-gsub('\\(|\\)','',names(wearabledata))
names(wearabledata)<-gsub("^t", "Time", names(wearabledata))
names(wearabledata)<-gsub("^f", "Frequency", names(wearabledata))
names(wearabledata)<-gsub("Acc", "Acceleration", names(wearabledata))
names(wearabledata)<-gsub("Gyro", "Gyroscope", names(wearabledata))
names(wearabledata)<-gsub("Mag", "Magnitude", names(wearabledata))
names(wearabledata)<-gsub("[Mm]ean", "Mean", names(wearabledata))
names(wearabledata)<-gsub("[Ss]td", "StandardDeviation", names(wearabledata))

## End 4 ##


## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. ##

wearabledata$joined<-paste(wearabledata$Subject,wearabledata$Activity,sep='__')
wearabledata$Subject<-NULL
wearabledata$Activity<-NULL

melted<-melt(wearabledata,id='joined')
newwearable<-dcast(melted, joined ~ variable, mean)

#Split combination of subjectid & activity name back into separate parts
firstelement<-function(x){x[1]}
secondelement<-function(x){x[2]}
newwearable$Subject<-as.numeric(sapply(strsplit(newwearable$joined,'__'),firstelement))
newwearable$Activity<-sapply(strsplit(newwearable$joined,'__'),secondelement)
newwearable$joined<-NULL
newwearable<-newwearable[,c(67:68,1:66)]
write.table(newwearable,'Summarized_Wearable_Data.txt',sep = '\t',row.names = F)

## End 5 ##
