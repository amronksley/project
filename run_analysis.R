activity<-read.table("activity_labels.txt")
activity<-activity[,2]
activity<-as.character(activity)

subject_train<-read.table("train/subject_train.txt")
y_train<-read.table("train/Y_train.txt")
x_train<-read.table("train/X_train.txt")
ntrain<-length(x_train[,1])
train.label<-array("Train",dim=ntrain)

subject_test<-read.table("test/subject_test.txt")
y_test<-read.table("test/Y_test.txt")
x_test<-read.table("test/X_test.txt")
ntest<-length(x_test[,1])
test.label<-array("Test",dim=ntest)

Test_or_Train_label<-c(test.label,train.label)

idata.mean <- grep("mean()", features$V2)
idata.std <- grep("std()", features$V2)

idata<-union(idata.mean,idata.std)
ncol=length(idata)

x_test_short<-x_test[,idata]
x_train_short<-x_train[,idata]

testdat<-cbind(subject_test,y_test,x_test_short)
traindat<-cbind(subject_train,y_train,x_train_short)

bothdata<-rbind(testdat,traindat)

#Label all the columns
colnames(bothdata)[1]<-"Subject"
colnames(bothdata)[2]<-"Activity_Labels"
colnames(bothdata)[3:(ncol+2)]<-as.character(features[idata,2])
colnames(bothdata)

#Make Column for activity Name and Insert as 3rd column
Activity_labels<-bothdata[,2]
nrow=length(bothdata[,1])
Activity_Name<-array(0,dim=nrow)
for (i in 1:nrow){Activity_Name[i]<-activity[Activity_labels[i]]}
data<-cbind(bothdata,Activity_Name)

#Make Column to Label whether it is test or train data
data<-cbind(data,Test_or_Train_label)
data<-data[,c(1:2,82:83,3:81)]

#Find unique subjects and Activities
USubject<-unique(data$Subject)
nsubject<-length(USubject)
USubject<-rep(USubject,6)
Activities<-c()
for (act in 1:6) {Activities<-c(Activities,rep(activity[act],nsubject))}
for (act in 1:6) {Actlab<-c(Actlab,rep(1:6,nsubject))}


#data[data$Subject==2]
#tes<-mean(data[data$Subject==2 & data$Activity_Labels==1,])

#Make empty dataframe
tidy<-cbind(USubject,Activities)

for (subj in 1:length(USubject) ) {

isub=USubject[subj]
iact=Actlab[subj]

for (nvar in 3:ncol+2){

temp.dat<-data[data$Subject==isub & data$Activity_Labels==iact,]

val<-mean(temp.dat[,nvar])



} }  }
