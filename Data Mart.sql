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
1
