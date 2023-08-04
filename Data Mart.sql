-- Data Cleansing steps
create table data_mart.clean_weekly_sales as
(
  with data_cte as (
select *, to_date(week_date, 'dd-mm-yy') as formatted_date
from data_mart.weekly_sales)
  
select formatted_date,
extract(week from formatted_date) as week_number,
extract(month from formatted_date) as month_number,
extract(year from formatted_date) as calendar_year,
segment,
case
when right(segment, 1) ='1' then 'Young Adults'
when right(segment, 1) = '2' then 'Middle Aged'
when right(segment, 1) in ('3', '4') then 'Retirees'
else 'Unknown'
end as age_band,
case
when left(segment, 1) = 'C' then 'Couples'
when left(segment, 1) = 'F' then 'Family'
else 'Unknown'
end as demographic,
round(sales::numeric/transactions,2) as avg_transactions
from data_cte);

-- Data Exploration
-- 1. What day of the week is used for each week_date value?
select distinct to_char(formatted_date, 'Day') as distinct_day
from data_mart.clean_weekly_sal

-- 2. What range of week numbers are missing from the dataset?
select distinct week_number as number
from data_mart.clean_weekly_sales
order by week_number

-- 3. How many total transactions were there for each year in the dataset?
select calendar_year, count(avg_transactions) as total_transactions
from data_mart.clean_weekly_sales
group by calendar_year
order by calendar_year

-- 4. What is the total sales for each region for each month?
select region, month_number, sum(sales) as total_sales
from data_mart.clean_weekly_sales
group by region, month_number
order by region, month_number

-- 5. What is the total count of transactions for each platform
select platform, count(avg_transactions) as transaction_count
from data_mart.clean_weekly_sales
group by platform
order by platform

-- 6. kjhkj
