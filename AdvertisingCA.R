#Step 1: CSV files and libraries loaded in 
library(tidyverse)
library(tibble)
library(dplyr)
advertiser <- read_csv('advertiser.csv', col_names = TRUE)
campaigns <- read_csv('campaigns.csv', col_names = TRUE)
clicks <- read_csv('clicks.csv', col_names= TRUE)
conversions <- read_csv('conversions.csv', col_names = TRUE)
impressions <- read_csv('impressions.csv', col_names = TRUE)

#Step 2: Files are viewed

  #view individually
view(advertiser)
view(campaigns)
view(clicks)
view(conversions)
view(impressions)

#Step 3: Checking for missing data

  #run lines individually
is.na(advertiser)
is.na(campaigns)
is.na(clicks)
is.na(conversions)
is.na(impressions)

#Step 4: Tidying Data and making it usable

  #Function changes the clicks table to show the number of clicks for each unique ID as opposed to its dates
  clicks_num <- clicks %>% count(campaign_id)
view(clicks_num)
  #The column is name 'n' so we change it to clicks for easier future use
colnames(clicks_num) <- c('campaign_id', 'clicks')

  #This process is repeated for impressions and conversions
impressions_num <- impressions %>% count(campaign_id)
view(impressions_num)
colnames(impressions_num) <- c('campaign_id', 'impressions')

  #doing the same for conversions
conversions_num <- conversions %>% count(campaign_id)
view(conversions_num)
colnames(conversions_num) <- c('campaign_id', 'conversions')

#Step 5: Merging Tables

  #inner_join used to drop any unmatched advertiser and campaigns
  #column names of the new tibble are then renamed.
advert_camp1 <- inner_join(advertiser, campaigns, by = c('ID' = 'advertiser_id'))
view(advert_camp1)
colnames(advert_camp1) <- c('advertiser_id', 'company_name', 'campaign_id', 'campaign_name', 'budget')
view(advert_camp1)
 
  #left_join clicks table to new tibble
advert_camp1 <- left_join(advert_camp1, clicks_num, by = c('campaign_id' = 'campaign_id'))
view(advert_camp1)
  #left_join used so as if there is a campaign that does not contain any any clicks, that NA will be returned.
  
  #impressions_num left_joined using tibble
advert_camp1 <- left_join(advert_camp1, impressions_num, by = c('campaign_id' = 'campaign_id'))
view(advert_camp1)

  #conversions_num added to advert_camp1 using left_join

advert_camp1 <- left_join(advert_camp1, conversions_num, by = c('campaign_id' = 'campaign_id'))
view(advert_camp1)

  
#Step 6: Tidying the new tables
    
  #NA values will be changed to zero
advert_camp1[is.na(advert_camp1)] = 0
view(advert_camp1)

  #We should also check that all ID's are unique now that the tables are merged
  #We know that the advertiser ID's may not necessarily be unique as a company can have more than one campaign

ad_counts <- count(advert_camp1, advertiser_id)
filter(ad_counts, n > 1)
  
  #This code returns that the advertiser_id = 11354 is shown three times. 
  #If we refer to the table we know this is correct as Coco Cola have three distinct campaigns

campaign_count <- count(advert_camp1, campaign_id)
filter(campaign_count, n > 1)

  #The above code returns zero as each campaign has there own unique ID

#Step 7: Analysing the Data Set - EDA - Variation


company_occur <- ggplot(data = advert_camp1) + geom_bar(mapping = aes(x= company_name))
company_occur + ggtitle("Number of Company Occurrences in Data Set") + xlab("Company Name") + ylab("Occurrences")

  #The above code shows the amount of times the each of the companies with campaigns occurred in the dataset on a bar chart
  #Next we will plot the campagins on the same chart 

campaign_occur <- ggplot(data = advert_camp1)+ geom_bar(mapping = aes(x=campaign_name))
campaign_occur + ggtitle("Number of Occurrences of the Dataset Campagins") + xlab("Campaign Name") + ylab("Occurrences")

 
  #We will now visualise continuous distributions, i.e budget, clicks, impressions and conversions

budget_hist <- ggplot(data = advert_camp1)+ geom_histogram(mapping = aes(x=budget), binwidth = 1750.0)
budget_hist + ggtitle("Budget Histogram") + xlab("Budget Value") + ylab("Amount")

    #We will use geom_freqpoly to see if we get a better view

budget_freq <- ggplot(data = advert_camp1)+ geom_freqpoly(mapping = aes(x = budget), binwidth = 700)
budget_freq + ggtitle("Budget Freqpoly") + xlab("Budget Value") + ylab("Amount")

  #The freqpoly function shows 4 different spikes. The first spike appears to be wider then the rest, thus potentially there are 
  #two different observations here. Note the abnormally large binwidths for both of the above graphs due to the large variance in the budget value.

click_hist <- ggplot(data = advert_camp1)+ geom_histogram(mapping = aes(x = clicks), binwidth = 0.5)
click_hist + ggtitle("Clicks Histogram") + xlab("Number of Clicks") + ylab("Occurences")

  #The histogram for the number of clicks shows the data clearly. It can be seen that there were two occurences of the number of clicks being 0 and 2.
  #There was one occurence where the number of clicks was 6.
  #We will also display this data using geom_freqpoly

click_freq <- ggplot(data = advert_camp1) + geom_freqpoly(mapping = aes(x = clicks), binwidth = 0.5)
click_freq + ggtitle("Clicks Freqploy") + xlab("Number of Clicks") + ylab("Occurrences")

  #We will repeat the same process for impressions

impressions_hist <- ggplot(data = advert_camp1) + geom_histogram(mapping = aes(x = impressions), binwidth = 0.5)
impressions_hist + ggtitle("Impressions Histogram") + xlab("Number of Impressions") + ylab("Occurrences")

  #The above code displays a histogram showing what seems to be one occurrence for 0,4,7,10,13 number of impressions.
  #This will data will also be displayed using freqpoly

impressions_freq <- ggplot(data = advert_camp1) + geom_freqpoly(mapping = aes(x = impressions), binwidth = 0.5)
impressions_freq + ggtitle("Impressions Freq") + xlab("Number of Impressions") + ylab("Occurrences")

  #And finally this process will be repeated for conversions

conversions_hist <- ggplot(data = advert_camp1) + geom_histogram(mapping = aes(x = conversions), binwidth = 0.5)
conversions_hist + ggtitle("Conversions Histogram") + xlab("Number of Conversions") + ylab("Occurrences")

  #The histogram displays two occurrences/observations at 0 and 3 number of conversions and one occurrence at 2. 
  #This data will then be shown on freqpoly.

conversions_freq <- ggplot(data = advert_camp1) + geom_freqpoly(mapping = aes(x = conversions), binwidth = 0.5)
conversions_freq + ggtitle("Conversions Freq") + xlab("Number of Conversions") + ylab("Occurrences")

  #Now that we have analysed what variation occurs within each variable, we will now analyse what happens between varaibles using covariation

#Step 8: EDA - Covariation

  #Take a look and see what variables we would like to compare first

view(advert_camp1)

  #Comparing the companies and their budgets using histogram

comp_budg <- ggplot(data = advert_camp1) + geom_histogram(mapping = aes(x = budget, colour = company_name), binwidth = 600)
comp_budg + ggtitle("Company and Budget Comparison") + xlab("Budget") + ylab("Count")

  #We can see that there are no budgets that have the same price (i.e count = 1)
  #Lever Bows and Nintendo have 1 budget, however Coco Cola have 3. We will explore what these three separate budgets mean
  #In a larger dataset, you would see a lot more budgets with the same value.
  #We can use freqpoly to see if it makes the graph any clearer

comp_budg_freq <- ggplot(data = advert_camp1) + geom_freqpoly(mapping = aes(x = budget, colour = company_name), binwidth = 1500)
comp_budg_freq + ggtitle("Company and Budget Comparison") + xlab("Budget") + ylab("Count")

  #As you can see despite using a large binwidth it is difficult to read the graph
  #However we can see three different Coco Cola Budgets as well as one for both Lever Brows and Ninetendo
  #We will now have a look at the campagin variable.

camp_bar <- ggplot(data = advert_camp1) + geom_bar(mapping = aes(x = campaign_name))
camp_bar + ggtitle("Bar Chart of Campaign") + xlab("Campaign") + ylab("Campaign Occurences")

  #It can be seen from the graph that the Run of the Network Campaign appears twice.
  #Is the campaign ran twice by the same company or did a different company cover the same campaign?

camp_comp <- ggplot(data = advert_camp1, aes(x = company_name, fill = campaign_name)) + geom_bar(position = 'stack')
camp_comp + ggtitle("Company vs Campaigns") + xlab("Company") + ylab("Campaign Count")

  #This chart confirms again for use that Coco Cola clearly has three campaigns and Lever Browns and Ninetendo each have one.
  #However, more interestingly is that both Ninetendo and Coco Cola have campaigns by the name of 'Run the network'.
  #We will now look at the campaign budgets

camp_budget <- ggplot(data = advert_camp1, aes(x = budget, colour = campaign_name)) + geom_freqpoly(binwidth = 1000)
camp_budget + ggtitle("Campaign vs Budget Freqpoly") + xlab("Budget")

  #This freqpoly makes it difficult to see two distinctly different 'Run of Network' campaigns.
  #We will use the xlim function to limit the x axis (budget) to 20000 and see what shows

camp_budget <- ggplot(data = advert_camp1, aes(x = budget, colour = campaign_name)) + geom_freqpoly(binwidth = 1000) + xlim(0,20000)
camp_budget + ggtitle("Campaign vs Budget Freqpoly") + xlab("Budget")

  #We now see that there are two different 'Run of network' campaigns.
  #It should be noted that they showed separately as opposed to the count increasing to 2.0 as they each have different budget values.

  #Impressions vs Clicks

imp_click <- ggplot(data = advert_camp1) + geom_point(mapping = aes(x = impressions, y = clicks, colour = campaign_name))
imp_click + ggtitle("Scatter Graph of Clicks vs Impressions") + xlab("Impressions") + ylab("Clicks") + labs(fill = "Campaign")

  #The scatter graph displays the number of clicks plotted against the number of impressions. There is also a legend of the campaigns.
  #There is a strong positive trend whereby the greater number of impressions equates to the greater number of clicks.
  #It can also be seen after the 'Q4 Performance Trend', this then slightly decreases.
  #Changing the legend/colour to company name

imp_click2 <- ggplot(data = advert_camp1) + geom_point(mapping = aes(x = impressions, y = clicks, colour = company_name))
imp_click2 + ggtitle("Scatter Graph of Clicks vs Impressions") + xlab("Impressions") + ylab("Clicks") + labs(fill = "Campaign")

  #This alternative graph provides an interesting insight as it shows that while Coco Cola had more campaings, this does not necessarily correlate with more clicks 

ggplot(data = advert_camp1)+ geom_smooth(mapping = aes(x = impressions, y = clicks))

  #The above code shows a graph with a smoothed line confirming the strong positive trend with a slight tail off after 10 impressions

  #We will then compare the number of Impressions to the number of conversions before we compare Clicks vs Conversions

imp_conv <- ggplot(data = advert_camp1) + geom_point(mapping = aes(x = impressions, y = conversions, colour = campaign_name))
imp_conv + ggtitle("Scatter Graph of Impressions vs Conversions") + xlab("Impressions") + ylab("Conversions")

#geom_smooth for a better look at trend

ggplot(data = advert_camp1)+ geom_smooth(mapping = aes(x = impressions, y = conversions ))

  #Similarly to the previous chart, there is a strong positive trend, with more impressions leading to more conversions.
  #'Run of Network' and 'Q4 Perfromance' had the most conversions with 3 and 'Christmas Cheer' behind with 2.
  #changing the colour to company_name

imp_conv2 <- ggplot(data = advert_camp1) + geom_point(mapping = aes(x = impressions, y = conversions, colour = company_name))
imp_conv2 + ggtitle("Scatter Graph of Impressions vs Conversions") + xlab("Impressions") + ylab("Conversions")

  #It can be confirmed that it was the Ninetendo 'Run of Network' campaign with the most impressions and clicks
  #Comparing clicks to the number of conversions

click_conversion <- ggplot(data = advert_camp1) + geom_point(mapping = aes(x = clicks, y = conversions, colour = campaign_name))
click_conversion + ggtitle("Scatter graph of Clicks vs Conversions") + xlab('Clicks') + ylab('Conversions')

  #smooth graph to see trend

ggplot(data = advert_camp1) + geom_smooth(mapping = aes(x = clicks, y = conversions))

  #strong positive correlation
  #now comparing budget to conversions

budg_conversion <- ggplot(data = advert_camp1) + geom_point(mapping = aes(x = budget, y = conversions, colour = company_name), size = 3, stroke = 3)
budg_conversion + ggtitle("Scatter Plot Comparison of Budget vs Conversions") + xlab("Budget") + ylab("Conversions")

