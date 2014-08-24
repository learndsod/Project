
run_analysis <- function()
{

  #read all the files into R objects
  features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

  #Add column name to the object
  colnames(subject_train) <- "Subject"

  #Read data files for training
  X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

  #Add column name
  colnames(y_train) <- "Activity"

  #read data files for test
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

  #Add column name
  colnames(subject_test) <- "Subject"

  #read data files for test
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

  #Add column name
  colnames(y_test) <- "Activity"

  #combine the training and the test data frames
  raw_comb <- rbind(X_train,X_test)

  #get the column names to be added to the combined dataset from the features object
  col_names <- as.character(features$V2)

  col_names_df <- data.frame(as.character(features$V2),stringsAsFactors=FALSE)

  #name the columns in the combined dataset as per the features object
  names(raw_comb) <- col_names

  #combine the subject train,subject test,y_train,y_test data frames
  comb_sub <- rbind(subject_train,subject_test)
  comb_act <- rbind(y_train,y_test)

  #find only those column names that are mean and std
  tt <- grep("mean\\(\\)|std\\(\\)", features$V2, perl=TRUE)

  #create new dataframe from combined dataframe that has only the mean/std columns
  filt <-raw_comb[tt]

  #add the subject and the y data frames
  combined <- cbind(comb_sub,comb_act,filt)

  #following steps convert the activity column from number to the mapped character value
  get_sub <- combined$Activity
  #get the character values for the corresponding numeric values
  named_sub <- activity_labels[get_sub,2]

  char_named <- as.character(named_sub)

  char_named <- data.frame(as.character(named_sub),stringsAsFactors=FALSE)
  #add column name
  colnames(char_named) <- "ActivityName"
  #Add this dataset which has the character values to the combined dataset
  comb_name <- cbind(char_named,combined)
  #Drop the column that has the numeric activity values
  comb_name$Activity <- NULL
 
  library(reshape2)
  #melt the dataset based on keys "ActivityName", "Subject"
  clean2 <- melt(comb_name, id = c("ActivityName", "Subject"), na.rm = TRUE)

  #cast the dataset using the mean function which will calculate the meand for
  #a given activity/subject/variable
  #this is a tidy dataset as per the rules
  clean3 <- dcast(clean2,ActivityName + Subject ~ variable,mean)
  #write to a file
  write.table(clean3, file = "Project.txt",row.name=FALSE)

}
