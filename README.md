Project
=======

Project Submission Getting and cleaning data

Note: The output file Project.txt has 180 rows and 68 columns with the means calculated
The R file run_analysis.R has plenty of comments explaining the steps

the column naming conventions are not standardized completely, hence have used the feature names 
as they do not contain dots, there are upper cases but since we are not going to type the column names, this does not matter

The files in the repo
CodeBook.md
run_analysis


A detailed explanation of steps in the code
Project
=======

Project Submission Getting and cleaning data

Note: the column naming conventions are not standardized completely, hence have used the feature names 
as they do not contain dots, there are upper cases but since we are not going to type the column names, this does not matter

the code does the following

reads the files into r objects
the object names have been named the same as the file names without extension
combine the X_train,X_test datasets
Add column names to the above combined dataframe using the features dataframe (used the names command)-
names(raw_comb) <- col_names

create a new dataset from the combined dataset that contains only mean/std
Used grep for this

tt <- grep("mean\\(\\)|std\\(\\)", features$V2, perl=TRUE)

Combine all the dataframes including y_/subject_

Convert the activity column from numeric to the corresponding character values based on the activity_labels dataframe

melt the dataframe based on "ActivityName", "Subject"
clean2 <- melt(comb_name, id = c("ActivityName", "Subject"), na.rm = TRUE)

then cast the melted dataframe using function mean
clean3 <- dcast(clean2,ActivityName + Subject ~ variable,mean)

write the dataframe to a table
