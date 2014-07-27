

merge.temp <- function(testortrain) {
  subt <- read.table(paste('./UCI HAR Dataset/',testortrain,'/','subject_',testortrain,'.txt',sep=''),col.names='subject')
  xt <- read.table(paste('./UCI HAR Dataset/',testortrain,'/','X_',testortrain,'.txt',sep=''))
  xt <- xt[c(col.which.mean,col.which.std)]
  names(xt) <- c(col.names.mean,col.names.std)
  yt <- read.table(paste('./UCI HAR Dataset/',testortrain,'/','Y_',testortrain,'.txt',sep=''),col.names = c('Y'))
  cbind(subt,xt,yt)
}

train <- merge.temp('train')
test <- merge.temp('test')

d <- rbind(train,test)

col.names <- read.table('./UCI HAR Dataset/features.txt')
col.which.mean <- grep('mean',col.names$V2,fixed=T)
col.names.mean <- as.character(col.names$V2[col.which.mean])
col.which.std <- grep('std',col.names$V2,fixed=T)
col.names.std <- as.character(col.names$V2[col.which.std])
cbind(colMeans(test),apply(test,2,sd))
