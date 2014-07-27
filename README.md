GetDataCourseProject
====================

This README describes how run_analysis.R works and what it does.

The first command prepares the activities variable, which will be used later to add the names of the activities in place of the corresponding numbers.

The next section uses the features.txt file to get the column names and numbers for the X train and X test files. These will be used because we only want a small section of the data, not all of it. We only want the columns that heave means and standard deviations.

The merge.temp function will be used to load the train and test data. A function is used so that the same code won't have to be repeated where the only change is replacing train with test. This function is then called to get the variables train and test, which have the data from the train and test folders.

merged.data combines the test and train data into a single data frame, since we want all of it together.

Then ddply is used to only get one data point for each subject and activity pair using the mean to collapse the rest of the values. After this the activity name is put in place of the number using the variable activities stored at the beginning.

This is then written to an output file, output.txt, using the write table function.
