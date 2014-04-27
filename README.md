TidyDataActivity
================

Assignment for Getting and Cleaning Data Course 

The script assumes that it is run in the directory where the features.txt and activity_labels.txt files are located. 
The test and train datasets are further included in the folders with the test and train, respectively.

The code uses the library reshape2, so it initially loads this library. The script also prints some descriptive info 
about the process and the steps while the script is run.

The code does not include any function. So, some parts of the code could have been written in a neater way with functions, especially the part where reading of the datasets takes place.

In the first part, the script reads labels, features, and test and train directories. After following some discussions in 
the form and because the assignment requests the mean of some of the feature values, I opted for not making the script read the signals in the "Inertial Signals" folder. Instead, the script reads the X_, y_, subject_ files in the train and test folders.  The names for the columns of the X_ data frame are copied from the earlier features data frame. 

Afterwards, descriptive activity names are added. Indices for mean() and std() are found with grep. I saw some discussions on the forum that whether we should get all the features with sub-parts of these tags, for example "mean" instead of "mean()."   These are possible choices. But, for the core of the assignment, I believe these are not essential parts. Depending on further request, one can easily modify the code to get additional features. In my case, only those features having names "mean()" and "std()" are included.
