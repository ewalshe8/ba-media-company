# Business Analysis for Media Companies

The following project was to analyse the effectiveness of advertising campaigns and to report back to the advertising partners. The process involved automating this task so as 
the code could be applied to any campaign that was created and so as it could be used by other users throughout the company.

This README.md file will provide an explanation as to how to run the program as well as a description of the analysis that was carried out and why it is appropraite to this 
this project. Output from the sample data set will also be provided as well as a clarification as to how to interpret said output. 

The programming language used for this project was R, and its functions and features will be referred to and explained.

**Step 1: Loading in Libraries and CSV Files**

The first step in the project is to load in the libraries/packages that are going to be used throughout the project using the *library()* function. The three libraries 
that were loaded in individually were *tidyverse, tibble,* and *dplyr*. These will help analysing data and merging dataframes together. 
It is not uncommon that you may get an error when trying to load theses libraries, so ensure that they are installed first with *install.packages()* as well as checking
that you are on the most up to date version of R Studio. 

After this, the appropriate CSV files where the data will be analysed from need to be loaded in. To do this, the *read_csv* function reads in the file as a tibble, and then allows us to store it 
under a variable name. 
A tibble is simply a more modern take on a dataframe.

For example *advertiser <- read_csv('advertiser.csv', col_names = TRUE)* will load the advertiser.csv file and store it under the variable name advertiser.
The *col_names = TRUE* just lets R Studio know that it should account that there will be headers in the columns of the file. This should be checked before the file is loaded. 
I would recommend running each line of code when loading the files individually so as to ensure they are stored in R Studio properly.

**Step 2: Viewing the files/tibbles**

This procedure is to simply check that the files have been loaded in as tibbles before we begin prepping the data for analysis.
To do this, we use the *view()* function, and when this is run, the tibble should be shown in a different window from the R file, with all column headers present as well as the relevant data.
This function is very handy further down the line when we've to check whether we have merged tables correctly.
Again, I would suggest running each view function individually and comparing the output with the open original file.
In this instance, the files loaded in as tibbles correctly and we are ok to proceed.

**Step 3: Checking for missing data**

The next step is checking for null/NA values in the dataset provided. This is completed using the *is.na()* function whereby a TRUE value will be returned if there is a value of NA,
and FALSE if the opposite is the case. It is good to be aware of potential NA values when tidying data as well as analysing it, in case of errors or problems further down the line when running the code.

Similarly to above, each line is ran individually so as to inspect the output with accuracy in the terminal. 

**Step 4: Tidying Data and making it usable**

When viewing the data that was imported, we noticeed that three of the tibbles *impressions*, *clicks*, and *conversions*, displayed their data using a date, time and timezone columns.
i.e. in the click tibble it can be seen that an advertised campaign was clicked on  X date, at Y time and in Z timezone. While this is interesting to note, it is difficult to compare and analyse this data
to other variables due to the it's nature.

To tidy these tibbles, we implement a line of code that counts the number of times the campaign ID is in the tibble (i.e. how many impressions,clicks or conversions for that unique campaign ID)
and places this count in a new a column called 'n'. This column is then added to a new tibble along with the campaign ID's, to new tibbles depending on which of the three original tibbles you were working with.
The columns in this new tibble are then renamed appropriately using *colnames()* function.

When these new tibbles are viewed, all that should be displayed is the campaign ID and its appropriate count.
eg. *view(clicks_num)* will display a column with the various campaign ID's and then a column 'clicks' with their corresponding number of clicks. 

The code for this process is broken up into three line sections for each of the tibbles of impressions, clicks and conversions. These lines can be ran individually or altogether as a single section.
It is also recommended to again use the *view()* function to ensure your columns have been renamed.
