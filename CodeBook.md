## CodeBook

Package "dplyr" was used

1. Files were downloaded and unzipped. Commands: download.file(), unzip()

2. Files of activity labels and names of features were read. Commands: read.table()

3. Train, test and subject datasets were read. Commands: read.table()

4. Columns in train and test sets were renamed, using factor variable of features to get names. Commands: as.character(), names()

5. Train and test parts were merged for all sets: measurements, activities, subjects. Commands: rbind()

6. All three sets were binded together and columns of the whole dataset were renamed. Commands: cbind(), names()

7. All columns that did not contain "mean()" or "std()" were removed from the dataset. Commands:
grepl(), names()

8. Names of activities instead of numbers were added. Commands: merge(), reassigning (<-)

9. Unnecessary variables were removed. Commands: rm()

10. Inertial signals were read for both training and test sets. Then train and test sets merged together. Commands: read.table(), rbind()

11. Again, all unnecessary variables were removed. Commands: rm()

12. Mean was calculated for each 128 element vector for each observarion. This left us with 9 vectors (data.frames) of 10299 observations and 1 variables. Commands: rowMeans()

13. Those vectors were attached to the initial dataset. After that the order of the columns was changed, so that "subject" and "activity" are first two. Commands: cbind(), reassigning

14. All unnecessary variables were removed. Commands: rm()

15. Dataset was ordered by subject and activity. Commands: arrange()

Step 4 has ended here

16. Dataset was grouped by subject and activity, then the mean of each variable calculated according to this grouping. This created the tidy dataset, which is the result of the whole cleaning. Commands: group_by(), summarize_each()

17. The dataset was saved into the text file "step5data.txt". Commands: write.table() with row.name = FALSE.

The task has ended here. Comments are also left in the code (run_analysis.R) itself. It might be easier to read, then from here.
