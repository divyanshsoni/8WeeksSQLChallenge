# 8WeeksSQLChallenge - Case Study 5
https://8weeksqlchallenge.com/images/case-study-designs/5.png

# Introduction
Data Mart is Danny’s latest venture and after running international operations for his online supermarket that specialises in fresh produce - Danny is asking for your support to analyse his sales performance.
In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.
Danny needs your help to quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.
The key business question he wants you to help him answer are the following:
What was the quantifiable impact of the changes introduced in June 2020?
Which platform, region, segment and customer types were the most impacted by this change?
What can we do about future introduction of similar sustainability updates to the business to minimise impact on sales?

# Dataset
Key datasets for this case study

1. Weekly Sales : Weekly sales data with Region, Platform and Segment type information

# Entity Relationship Diagram
[[![image](https://github.com/divyanshsoni/8WeeksSQLChallenge-Case-Study-3/assets/35307737/326188b7-5799-4848-a8c2-092cd2d68f16)](https://8weeksqlchallenge.com/images/case-study-4-erd.png)](https://8weeksqlchallenge.com/images/case-study-5-erd.png)

# Case Study Questions
**A. Data Exploration**
1. What day of the week is used for each week_date value?
2. What range of week numbers are missing from the dataset?
3. How many total transactions were there for each year in the dataset?
4. What is the total sales for each region for each month?
5. What is the total count of transactions for each platform
6. What is the percentage of sales for Retail vs Shopify for each month?
7. What is the percentage of sales by demographic for each year in the dataset?
8. Which age_band and demographic values contribute the most to Retail sales?
9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
