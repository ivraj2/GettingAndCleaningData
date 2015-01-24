# Getting And Cleaning Data
Coursera course project - HD
This repo contains an R script for parsing Human Activity Recognition dataset into a summary containing mean values for all of the raw data mean and standard deviation columns, grouped by Activity and Subject.  

More information on the  HAR project can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


# Running the script

Required R libraries: dplyr

1) Download the source data from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2) Uncompress the source data into your R working directory. (for example: /User/jsmith/rprojects/) After doing this, you should have new directory "UCI HAR Dataset" directly under you R working directory. (for example: "/User/jsmith/rprojects/UCI HAR Dataset")

3) Download R script run_analysis.R from this Git repository into your working directory. (for example: /User/jsmith/rprojects/)

4) Open Rstudio or R and set your working directory. (for example: setwd("/Users/jsmith/rprojects/")

5) Source and execute the run_analysis.R script. 

6) If everything was set correctly, you should have new file "HAR_mean_results.txt" in your working directory. This file contains the mean values of the test variables by Activity and Subject. 

