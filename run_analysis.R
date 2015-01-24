### R script for parsing Human Activity Recognition dataset
### Produces a tidy dataset of mean and std data, grouped by activiy and test subject.
### 
###

# Required libraries 
require(dplyr)


# Check input data. If it looks like HAR data directory is not there, print a message
# and return from script. 
source_dir <- "UCI HAR Dataset"
if(!file.exists(source_dir)){
  print(paste("Missing source directory: ",source_dir))
  return()
}else{ # Source data seems to be be there, so continue processing. 
  
  # Determine which colums contain mean or st-dev data. Doing matching any columns that
  # that have either "mean()" or "std()" in the colulmn name. 
  col_names <- read.table(file.path(source_dir,"features.txt",fsep = .Platform$file.sep))  
  mean_std_col_nums<- grep("mean\\(|std\\(",col_names[,2])
  mean_std_col_names<- col_names[mean_std_col_nums,2]
  
  # Read all data for test and train, but drop colulmns other than mean and std data.
  all_test_data <- read.table(file.path(source_dir,"test","X_test.txt",fsep = .Platform$file.sep))  
  test_data <- all_test_data[,mean_std_col_nums]
  all_test_data <- NULL
  test_y <- read.table(file.path(source_dir,"test","y_test.txt",fsep = .Platform$file.sep))  
  test_subject <- read.table(file.path(source_dir,"test","subject_test.txt",fsep = .Platform$file.sep))  
  
  all_train_data <- read.table(file.path(source_dir,"train","X_train.txt",fsep = .Platform$file.sep))  
  train_data <- all_train_data[,mean_std_col_nums]
  all_train_data <- NULL
  train_y <- read.table(file.path(source_dir,"train","y_train.txt",fsep = .Platform$file.sep))  
  train_subject <- read.table(file.path(source_dir,"train","subject_train.txt",fsep = .Platform$file.sep))  
  
  
  
  # Merge datasets and cleanup unused data structures
  all_data <- rbind(train_data,test_data)
  train_data <- NULL
  test_data <- NULL
  subject <- rbind(train_subject,test_subject)
  train_subject <- NULL
  test_subject <- NULL
  activity_codes <- rbind(train_y,test_y)
  train_y <- NULL
  test_y <- NULL
  
  # Read activity labels and join to activity codes
  names(activity_codes) <- c("act_id")
  activity_labels <- read.table(file.path("UCI HAR Dataset","activity_labels.txt",fsep = .Platform$file.sep))
  names(activity_labels) <- c("act_id","activity")
  activity <- merge(activity_codes,activity_labels)
  
  # Add column names, drop the parenthesis from the names
  mean_std_col_names_clean <- gsub("\\(\\)","",mean_std_col_names)
  names(all_data) <- mean_std_col_names_clean
  
  # Add columns to indicate activity and  subject for each observation
  final_data1 <- cbind(activity[,2],subject,all_data)
  names(final_data1)[1] <- 'Activity'
  names(final_data1)[2] <- 'SubjectID'
  
  # Group and summarize
  final_data1_grp <- group_by(final_data1,Activity,SubjectID)
  final_data <- summarise_each(final_data1_grp,funs(mean))
  
  # Write results to a file in working directory
  write.table(final_data,file="HAR_mean_results.txt",append=F,row.names=F,col.names=T);
  
}


