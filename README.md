# A Brief Introduction to This Code
-----------------------------------------------------------------------
This package contains 5 matlab files and a directory named "dataset".

runlmv.m : If you just simply want to run this algorithm and see its performance, then visit this file. You can put your own dataset in the "dataset" directory, and run this file after changing the dataset name in the code.Its performance will be recorded automatically. It is advisable to read the remarks in this file before you run it in matlab.

lmv.m : The core part of the code is implemented in this function. If you are seeking to learn more about the details of the mechanism of LMVSC  and its programming implementation, see this file.

ClusteringMeasure : This function measures the performance of LMVSC with 3 indicators--Accuracy, NMI and Purity.

litekmeans : Perform K-Means clustering.

mySVD : Perform singular value decomposition.

dataset(dir) : Directory for datasets.