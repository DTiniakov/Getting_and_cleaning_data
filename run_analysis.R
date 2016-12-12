##downloading the file and unarchiving its content to the folder 'data' in wd
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl,destfile='./data.zip') #on mac add "method='curl'"
unzip(zipfile='./data.zip',exdir='./data')

#checking the content of archive and saving path from wd to it
xpath='./data/UCI HAR Dataset'
list.files(xpath,recursive=T)

#according to readme file, files of interest are:
#- 'features.txt': List of all features.
#- 'activity_labels.txt': Links the class labels with their activity name.
#- 'train/X_train.txt': Training set.
#- 'train/y_train.txt': Training labels.
#- 'test/X_test.txt': Test set.
#- 'test/y_test.txt': Test labels.
#- 'test/subject_test.txt": info about test subjects
#- 'train/subject_train.txt" : info about train subjects


##saving data into r objects

#info about subject id
subjectTrain<-read.table(paste(xpath,'/train/subject_train.txt',sep=''),header=F)
subjectTest<-read.table(paste(xpath,'/test/subject_test.txt',sep=''),header=F)
#info about activity type
actLabel<-read.table(paste(xpath,'/activity_labels.txt',sep=''),header=F)
trainActtype<-read.table(paste(xpath,'/train/y_train.txt',sep=''),header=F)
testActtype<-read.table(paste(xpath,'/test/y_test.txt',sep=''),header=F)
#values of different features
featureNames<-read.table(paste(xpath,'/features.txt',sep=''),header=F)
testVals<-read.table(paste(xpath,'/test/X_test.txt',sep=''),header=F)
trainVals<-read.table(paste(xpath,'/train/X_train.txt',sep=''),header=F)

# to understand, where are data of interest we want to know
# structure of each variable with str() function


## merging data. first cbinding data for test and train datasets, then rbinding them

test<-cbind(subjectTest,testActtype,testVals)
names(test)<-c('subjectID','activity',as.character(featureNames[,2]))
head(test[,1:10])

train<-cbind(subjectTrain,trainActtype,trainVals)
names(train)<-c('subjectID','activity',as.character(featureNames[,2]))
head(train[,1:10])

full<-rbind(test,train)

##extracting measurments with mean or sd only
#first defining which fe0ature names are of interest with grepl()
meansd<-grepl('mean\\(\\)|std\\(\\)',featureNames[,2])
selected<-featureNames[,2][meansd]
#subsetting data
newfull<-full[,c('subjectID','activity',as.character(selected))]
str(newfull)

##making activity variable a factor with level from actLabel
# to use descriptive activity names
newfull$activity<-factor(newfull$activity)
levels(newfull$activity)=actLabel[,2]

## renaming features with full names, according ot features_info.txt file
# to do this we replace literals using gsub()
names(newfull[,-(1:2)])
names(newfull)<-gsub('^t','time',names(newfull))
names(newfull)<-gsub('Acc','Accelerometer',names(newfull))
names(newfull)<-gsub('Gyro','Gyroscope',names(newfull))
names(newfull)<-gsub('^f','frequency',names(newfull))
names(newfull)<-gsub('Mag','Magnitude',names(newfull))
names(newfull)<-gsub('BodyBody','Body',names(newfull))
names(newfull)

## applying mean() for dataset by activity and subject, ordering final set,saving data as text file
library(plyr)
avgdata<-aggregate(.~subjectID+activity,newfull, mean)
avgdata<-arrange(avgdata,subjectID,activity)
write.table(avgdata, file = './finaldataset.txt',row.name=FALSE)
