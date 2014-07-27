# Stores activities names for later use
activities <- c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING')

# Prepare to only use columns we want: those with mean and standard deviations
col.names <- read.table('./UCI HAR Dataset/features.txt')
col.which.mean <- grep('mean',col.names$V2,fixed=T)
col.names.mean <- as.character(col.names$V2[col.which.mean])
col.which.std <- grep('std',col.names$V2,fixed=T)
col.names.std <- as.character(col.names$V2[col.which.std])

# A function to load the data
merge.temp <- function(testortrain) {
  subt <- read.table(paste('./UCI HAR Dataset/',testortrain,'/','subject_',testortrain,'.txt',sep=''),col.names='subject')
  xt <- read.table(paste('./UCI HAR Dataset/',testortrain,'/','X_',testortrain,'.txt',sep=''))
  xt <- xt[c(col.which.mean,col.which.std)]
  names(xt) <- c(col.names.mean,col.names.std)
  yt <- read.table(paste('./UCI HAR Dataset/',testortrain,'/','Y_',testortrain,'.txt',sep=''),col.names = c('activity'))
  cbind(subt,yt,xt)
}

# Loads the data
train <- merge.temp('train')
test <- merge.temp('test')

# Combines train and test into one data frame
merged.data <- rbind(train,test)

# Reduce size of data
tidy.data <- ddply(merged.data,c('subject','activity'),colMeans)

# Change column with activity from number to word description 
tidy.data$activity <- activities[tidy.data$activity]

# Write to file
write.table(tidy.data,file='output.txt')
