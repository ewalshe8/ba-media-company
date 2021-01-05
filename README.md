# Business Analysis for Media Companies

The following project was to analyse the effectiveness of advertising campaigns and to report back to the advertising partners. The process involved automating this task so as 
the code could be applied to any campaign that was created and so as it could be used by other users throughout the company.

This README.md file will provide an explanation as to how to run the program as well as a description of the analysis that was carried out and why it is appropraite to this 
this project. Output from the sample data set will also be provided as well as a clarification as to how to interpret said output. 

The programming language used for this project was R, and its functions and features will be referred to and explained.

## Step 1: Loading in Libraries and CSV Files

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

## Step 2: Viewing the files/tibbles

This procedure is to simply check that the files have been loaded in as tibbles before we begin prepping the data for analysis.
To do this, we use the *view()* function, and when this is run, the tibble should be shown in a different window from the R file, with all column headers present as well as the relevant data.
This function is very handy further down the line when we've to check whether we have merged tables correctly.
Again, I would suggest running each view function individually and comparing the output with the open original file.
In this instance, the files loaded in as tibbles correctly and we are ok to proceed.

## Step 3: Checking for missing data

The next step is checking for null/NA values in the dataset provided. This is completed using the *is.na()* function whereby a TRUE value will be returned if there is a value of NA,
and FALSE if the opposite is the case. It is good to be aware of potential NA values when tidying data as well as analysing it, in case of errors or problems further down the line when running the code.

Similarly to above, each line is ran individually so as to inspect the output with accuracy in the terminal. 

## Step 4: Tidying Data and making it usable

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

## Step 5: Merging Tables

The following step in the project is arguably the most important in ensuring our data is prepped before the analysis. Here we begin to merge the five tibbles as one, so as when analysing, we can compare the variables from the one tibble, advert_camp1.

1st Join - *inner_join()* function used to merge our advertiser and campaign tables when their keys match (essentailly a foreign key); in this scenario it being                          advertiser_id. Thus the output will be the key and the varaibles from the advertiser and campaign tables. Columns are renamed so as to to distinctly differntiate 
           between the different ID's.
           This function will not include any unmatched observations. In this instance, the advertiser 'Bobo' was not included as they did not have a matching campaign, or 
           any campaign for that matter. Thus they will be excluded from analysis.
           
2nd Join - *left_join()* function used to add the clicks_num table to the newly created tibble from the 1st join. They are joined on the matching key of campaign_id.  
           A left join allows all observations from the first tibble to kept, in this instance, the newly created tibble.

3rd Join - *left_join()* function used to add impressions_num table to the new advert_camp1 tibble. Again they are joined on the campaign_id.

4th Join - *left_join()* function used to add conversion_num table to the advert_camp1 tibble. Matched again on the campaign_id.

It is recommended that you run each of the joins individually and view the advert_camp1 table after each join. This confirms that the tables have merged as you have perceived and familiarise you with the new variable names etc.

## Step 6: Tidying the new tibble

When the table is viewed, it can be seen that there are NA values present. This is often the case when joining various different tibbles together. For the purpose of this analysis, we want to change any NA value to 0 so as we can analyse the dataframe effectively.

To do this, we re-use our *is.na()* function, put it in square brackets and let it equal to zero. i.e. *advert_camp1[is.na(advert_camp1)] = 0* 
The square bracket allows us to change all NA values in the vector to zero.

After dealing with NA values we now check to see if our ID's are unique values. Doing this, we again use our *count* function, call on the tibble we're refferring, and then call on the variable we wish to count. A *filter()* function is then used to find if the advertisement_id count is greater than one.

When counting the advertisement_id, it shows that it is counted three times. However we are not concerned by this as an advertiser can have multiple campaigns.

But when counting the campaign_id, it shows that all of their ID's are unique.

The code for this tidying set can be ran in blocks that are indicated inbetween comments on the R file, under the Step 6 heading.

## Step 7: Analysing the Data Set - EDA - Variation Analysis

Exploratory Data Analysis is a process whereby we generate questions about our data, search for the answers using visualisations and data modelling, and use these answers to refine our questions. To start this process we will look at variation, where we will look at what occurs within each variable. 

It should be noted that to run the code in this step and produce the appropriate graphs, the two lines inbetween comments should be run simulatantiously. The sample output should be analysed the same as the actual dataset in use, and the questions formulated should also be considered when the code is in use.

#### Company Occurences 

- The first variable we will analyse is the company_name variable. We plot the variable on a bar chart to see how many occurrences each of the companies have in the dataset. 

![company_occur_bar](https://user-images.githubusercontent.com/68699458/103651673-e1911f00-4f59-11eb-862b-85f36da03b5a.png)

**Sample Output:** The bar chart generated shows us that in the dataset, Coco Cola appears three times while the remaining companies appear once. From this output we should ask does this correlate with the amount of campaigns the companies had?

- The next variable to look at is the campaign_name variable. It will again be on a bar chart and will tell us the amount of times each campaign occurred in the dataset.

![campaign_occur_bar](https://user-images.githubusercontent.com/68699458/103652185-a5aa8980-4f5a-11eb-998d-64b474e163ce.png)

**Sample Output:** The sample dataset shows that each campaign appeared once in the dataset with the exception of "Run of network" which appeared twice. This is an interesting outcome as we concluded when preparing the data that each campaign had its own unique ID. This leads us to the question, did the same company run the same campaign on two occassions? Alternatively, did two different companies run the same campaign? This will be analysed further when we move onto covariation analysis. 

- We now will begin analysing the continuous distributions, beginning with budget. We will first plot the data using a histogram. 

![budget_hist](https://user-images.githubusercontent.com/68699458/103652990-c9ba9a80-4f5b-11eb-9324-f50b35803b18.png)

**Sample Output:** The histogram shows us that each budget amount is 1, i.e. there are no two campaigns with the same budget. The first bin in the graph looks slightly larger then the rest and thus begging the question, is there more than one there? This can happen where a histogram does not provide a clear picture and we will instead use geom_freqpoly. It should also be noted that in the code you may have to play around with smaller and larger binwidths as with a small sample dataset like this, abnormally large binwidths are used.

![budget_freqpoly](https://user-images.githubusercontent.com/68699458/103653388-5cf3d000-4f5c-11eb-95b5-603e48fe862b.png)

**Sample Output:** This graph also shows a wider first spike in comparison to the rest so we can thus confirm that there are more than one observation there. It also shows the huge variance in the different budgets and is worth noting for future analysis.

- The next variable to explore is clicks, which will be first plotted on a histogram. 

![clicks_hist](https://user-images.githubusercontent.com/68699458/103653828-fde28b00-4f5c-11eb-8c77-3b3ac79791df.png)

**Sample Output:** Here we can clearly see the number of occurences for each click, with there being two observations for 0 and 4 clicks and one for 6 clicks. This graph may get difficult to read with a larger dataset due to the varying number of clicks per campaign, so we will also plot the same variable using geom_freqpoly.

![clicks_hist](https://user-images.githubusercontent.com/68699458/103653828-fde28b00-4f5c-11eb-8c77-3b3ac79791df.png)

**Sample Output:** This graph also visualises the clicks occurrences well. It is difficult with it being such a small dataset to confirm any trends, but with larger datasets, positive and negative trends should be kept an eye on.

- The same process will be repeated for the impressions variable as the previous two variables, with both a histogram and a freqpoly graph being created so as to see which displays the data with more clarity.

![impressions_hist](https://user-images.githubusercontent.com/68699458/103665975-f4145400-4f6b-11eb-9492-7b627fa2b717.png)


![impressions_freq](https://user-images.githubusercontent.com/68699458/103666036-01314300-4f6c-11eb-949d-8cbd8acf0a5b.png)

**Samply Output:** These two graphs show the amount of occurrences of a particular number of impressions. As we can see there is only one observation per number of impressions. Currently this data is somewhat meaningless until we compare it to other variables.

- Finally the last variable we individually analyse is conversions, again producing the same two graphs. 


![conversions_hist](https://user-images.githubusercontent.com/68699458/103666470-98969600-4f6c-11eb-94ae-4d030dc47a6e.png)


![conversions_freq](https://user-images.githubusercontent.com/68699458/103666518-a5b38500-4f6c-11eb-9684-52b19cf51c44.png)

**Sample Output:** From these graphs we can see that there are two observations/occurrences at 0 and 3 number of conversions. With a larger dataset in use, the use of geom_freqpoly could show an insight into how many of the campaigns were successful in getting conversions against how many weren't.

- We have now explored the variables individually and will now move onto covariation to compare them and provide more context to the dataset.

#### Step 8: EDA - Covariation

- The first two variables we will compare is companies and their budget. Similarly to the variation analysis, the two lines of code in between comments will be run simultaneously to produce the individual graphs. Observations or questions made on the sample output should also be applied and adjusted to the actual dataset of choice. 


![comp_budg_hist](https://user-images.githubusercontent.com/68699458/103668022-8f0e2d80-4f6e-11eb-8cc2-82ebf2e5081e.png)

**Sample Output:** The first thing that is noticable from the graph is that none of the budgets occur more than once. It can also be seen Coco Cola have three different budgets and Lever Brows and Ninetendo each have one. In a larger data set you would see a lot more budgets of the same value (bigger count on y-axis) as well as many more companies. It would be recommended that if you are looking for more specific results to restrict the output by the company name.


![comp_budg_freq](https://user-images.githubusercontent.com/68699458/103668654-3c814100-4f6f-11eb-9a58-be944abad0ce.png)

**Sample Output:** This is an alternative way of displaying the data. It should be noted again that the binwidths are quite large due to the nature of the small dataset and this figure should be adjusted appropriately.

- From our variation analysis, we remember that there were two 'Run of network' campaigns. To answer our question made (who ran these campaigns?), we will compare the company with their campaigns on a bar chart. 


![comp_camp_bar](https://user-images.githubusercontent.com/68699458/103669083-cd581c80-4f6f-11eb-86e0-aa1eac869f35.png)

**Sample Output:** The graph confirms for us that Coco Cola indeed has three different campaigns. What's even more interesting that the 'Run of network' campaign was ran by both Coco Cola and Ninetendo. Further into the analysis it will become apparent which of the campaigns performed better. This graph will be useful with larger datasets and will allow you to select various campaigns to create comparisons.

- The next comparison we will make is looking at the campaigns and their budgets.


![camp_budg_freq](https://user-images.githubusercontent.com/68699458/103670826-03969b80-4f72-11eb-8ae3-8963da7181c7.png)

**Sample Output:** The chart shows that 'Q4 Performance' had the biggest budget, and the rest of the campaign budgets were 20,000. We know from previous analysis that there are more than one of some of the campaigns in the dataset, so to get a clearer look at the lower end of the axis, we will use the xlim() function which allows us to limit the x-axis (in this case, the budget) to a certain amount.


![camp_budg_xlim](https://user-images.githubusercontent.com/68699458/103671254-90d9f000-4f72-11eb-84ef-6864ee955b7b.png)

**Sample Output:** We can now see the two different 'Run of Network' campaigns, with one of the budgets being >10,000 and the other 2,500<. It will become aparent later which is which. It should also be noted that the 'Test campaign' seems to have a budget of 0. 

- We will now begin to compare the variables that arguably deem whether a campaign is successful or not. Firstly, a scatter graph comparing the impressions to the number of clicks. 


![click_vs_imp](https://user-images.githubusercontent.com/68699458/103672909-dac3d580-4f74-11eb-9831-2a3b573a57ed.png)

**Sample Output:** As we can see, the graph shows a positive relationship between impressions and clicks, i.e. as the number of impressions increase, the number of clicks do the same. It can also be seen after the 'Q4 Performance Trend', this then slightly decreases. To see which company had the greatest amount of impressions and clicks, we can just change the legend/colour to company_name.


![click__imp_camp](https://user-images.githubusercontent.com/68699458/103673699-cfbd7500-4f75-11eb-93d2-bc4a4a2525cd.png)

**Sample Output:** This variation on the previous graphs shows that the campaign with the most number of clicks belongs to Lever Brows. It can also be noted that it is Ninetendo's 'Run of Network' campaign that is performing the best as opposed to Coca Cola's. It also shows that despite Coco Cola having more campaigns, this did not correlate with more clicks. 

- The following graph is shows a smoothed line, and confirms the positive trend and tail off after 10 impressions. 


![smooth](https://user-images.githubusercontent.com/68699458/103674273-77d33e00-4f76-11eb-9520-486d0934c700.png)

- Impressions vs Conversions


![imp_conv](https://user-images.githubusercontent.com/68699458/103674524-c41e7e00-4f76-11eb-82ef-dd61cfb02de0.png)
![imp_smooth](https://user-images.githubusercontent.com/68699458/103674525-c4b71480-4f76-11eb-8746-6979f27b0dcd.png)

**Sample Output:** Similarly to the previous chart, there is a strong positive trend, with more impressions leading to more conversions.'Run of Network' and 'Q4 Perfromance' had the most conversions with 3 and 'Christmas Cheer' behind with 2. To find out which company the 'Run of network' with the most conversions belongs to, we again will simply change the colour to display the company_name. 


![imp_vs_conv_comp](https://user-images.githubusercontent.com/68699458/103676522-1791cb80-4f79-11eb-9231-6bf45e02d473.png)

**Sample Output:** It can be confirmed that it was the Ninetendo 'Run of Network' campaign with the most impressions and clicks.

- Clicks vs Conversions


![click_conv_scatter](https://user-images.githubusercontent.com/68699458/103676883-8a02ab80-4f79-11eb-97e9-5ae2dfecbb05.png)

![click_conv_smooth](https://user-images.githubusercontent.com/68699458/103677078-c0d8c180-4f79-11eb-9ed1-c5d9d6670a77.png)


**Sample Output:** We again see that there is a strong positive correlation with a greater number of clicks equating to a greater number of conversions. When geom_smooth is used, it throws an error as the span is too small however with a larger dataset this would not be an issue. Now compare budget to conversions to see what the correlation is like, and see does a bigger budget mean more conversions. 
