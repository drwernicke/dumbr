# dumbr
## Create dummy datasets based on your own dataset.

Imagine one of the following:

* You have a coding problem and want to ask for help, but you cannot share your data as it contains sensitive information
* You have sensitive and want a dummy set to experiment in a non-secure or not-allowed environment (for instance Rstudio cloud)
* You have level 1000 scietific integrity and want to build your analyses with a dummy set

`dumbr()` may help with this. It simply takes your dataset and creates a new data set with dummy data, **keeping formatting and values*. The dummy data is based on the original values from your dataset which means the distributions will be the same, provided the data is not truncated. The relations between variables is lost though, due to random shuffling for each variable. This means that a baseline table may be meaningful, but a regression model will not.

The point is that you can write and test your code with dummy data and just switch to real data when your are ready.

## Notes
* The function does *not* create new values, it uses those already in the dataset. This means that individual values can still contain sensitive information such as names, social security numbers etc.
* If you create a dummy dataset which is larger than your original dataset, values may be duplicated. This may have to be considered for ID variables, dates and so on.
