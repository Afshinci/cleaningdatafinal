CODEBOOK

This codebook explains the study design, measurements and variables used to obtain data then modified by the run_analysis.R script found here:
https://github.com/macnast/cleaningdatafinal/blob/master/run_analysis.R

More information on the script itself can be found here:
https://github.com/macnast/cleaningdatafinal/blob/master/README.md

This part comes from the README.txt (first passage) and features_info.txt (second passage) files found in the original data folder, available at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

>The experiments have been carried out on a group of 30 volunteers within an age bracket of 19-48 years. Each person performed >six activities (walking, walking upstairs, walking downstairs, sitting, standing and layin) wearing a smartphone (Samsung >Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope 3-axial linear acceleration and 3-axial angular >velocity, was captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The >obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the >training data and 30% the test data. 
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width >sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and >body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational >force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each >window, a vector of features was obtained by calculating variables from the time and frequency domain.


>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals - tAcc-XYZ and tGyro-XYZ, >respectively. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were >filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. >Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and >tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ >and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm >(tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, >fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
>These signals were used to estimate variables of the feature vector for each pattern:  
>'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
>
>tBodyAcc-XYZ
>tGravityAcc-XYZ
>tBodyAccJerk-XYZ
>tBodyGyro-XYZ
>tBodyGyroJerk-XYZ
>tBodyAccMag
>tGravityAccMag
>tBodyAccJerkMag
>tBodyGyroMag
>tBodyGyroJerkMag
>fBodyAcc-XYZ
>fBodyAccJerk-XYZ
>fBodyGyro-XYZ
>fBodyAccMag
>fBodyAccJerkMag
>fBodyGyroMag
>fBodyGyroJerkMag
>
>The set of variables that were estimated from these signals are: 
>mean(): Mean value
>std(): Standard deviation
>mad(): Median absolute deviation 
>max(): Largest value in array
>min(): Smallest value in array
>sma(): Signal magnitude area
>energy(): Energy measure. Sum of the squares divided by the number of values. 
>iqr(): Interquartile range 
>entropy(): Signal entropy
>arCoeff(): Autorregresion coefficients with Burg order equal to 4
>correlation(): correlation coefficient between two signals
>maxInds(): index of the frequency component with largest magnitude
>meanFreq(): Weighted average of the frequency components to obtain a mean frequency
>skewness(): skewness of the frequency domain signal 
>kurtosis(): kurtosis of the frequency domain signal 
>bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
>angle(): Angle between to vectors.
>
>Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
>gravityMean
>tBodyAccMean
>tBodyAccJerkMean
>tBodyGyroMean
>tBodyGyroJerkMean
>
>Each value was normalized and bounded within [-1,1].


The data was cleaned and processed as required by the assignment criteria. Variables “Participant” and “Activity” were added to the original “test” and “train” datasets. Next, they were merged together to create the full dataset named “data”. From that, the data was trimmed to only contained variables showing mean or standard deviation (as well as “Participant” and “Activity”),  and named “sdmean” (10299 observation by 81 variables).  Furthermore, average of each participant performing each activity was calculated and saved into data frame “datasummarised” (180 observations by 81 variables).
The final dataset contains the following variables:
The first two variables are “Participant” (1-30, showing which participant underwent the given measurement) and “Activity” (walking, walking upstairs, walking downstairs, sitting, standing or laying), showing which activity was measured.
The names of the rest variables are made by joining a few components. The first is a letter t or f. It shows whether the variable is in time domain (t), or frequency domain obtained by applying fast Fourier transform (f). The second part of the variable name is either “Body” (signal based on measurement of the body of the participant) or “Gravity” (measurement based on gravity). They are followed by a combination of the following components: 

Component  |  Description
--------------  |  -------------
Acc  |  measurement of linear acceleration (in m/s^2)
Gyro  |  measurement of angular velocity (in rad/s)
Jerk  |  rate of change of the above
Mag  |  magnitude of the signal, calculated using Euclidian norm
mean  |  mean value
std  |  standard deviation
meanFreq  |  weighted average of the frequency components to obtain a mean frequency
X  |  signal measured in the X
Y  |  signal measured in the Y axis
Z  |  signal measured in the Z axis
