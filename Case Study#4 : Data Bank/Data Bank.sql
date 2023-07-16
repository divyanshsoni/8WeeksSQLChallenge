-- Customer Nodes Exploration
-- 1. How many unique nodes are there on the Data Bank system?
select count(distinct node_id) from data_bank.customer_nodes

-- 2. What is the number of nodes per region?
select cm.region_id, region_name, 
count(distinct node_id) as node_count 
from data_bank.customer_nodes as cm
join data_bank.regions as r
on cm.region_id = r.region_id
group by cm.region_id, region_name

-- 3. How many customers are allocated to each region?
select cm.region_id, region_name, 
count(distinct customer_id) as customer_count 
from data_bank.customer_nodes as cm
join data_bank.regions as r
on cm.region_id = r.region_id
group by cm.region_id, region_name

-- 4. How many days on average are customers reallocated to a different node?
with cte as (select customer_id, node_id, lead(node_id) over(partition by customer_id order by start_date) as next_node, start_date, lead(start_date) over (partition by customer_id order by start_date) as next_start_date
from data_bank.customer_nodes)

select avg(next_start_date - start_date) as avg_days 
from cte 
where node_id <> next_node

-- 5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
with cte as (
  select customer_id, region_id, node_id, 
  lead(node_id) over(partition by customer_id order by start_date) as next_node,     start_date, 
  lead(start_date) over (partition by customer_id order by start_date) as next_start_date
from data_bank.customer_nodes),

cte2 as (
  select region_id,
  percentile_cont(0.5) within group(order by (next_start_date - start_date)) as "50th_perc",
  percentile_cont(0.8) within group(order by (next_start_date - start_date)) as "80th_perc",
  percentile_cont(0.95) within group(order by (next_start_date - start_date)) as "95th_perc"
  from cte
  where node_id <> next_node
group by region_id)

select region_id,
ceil("50th_perc") as "median",
ceil("80th_perc") as "80th_percentile",
ceil("95th_perc") as "95th_percentile"
from cte2

-- Customer Transactions
-- 1. What is the unique count and total amount for each transaction type?
select txn_type, count(*) as total_count,
sum(txn_amount) as total_amount
from data_bank.customer_transactions
group by txn_type

-- 2. What is the average total historical deposit counts and amounts for all customers?
with cte as (
select customer_id,
count(*) as total_count,
sum(txn_amount) as total_amount
from data_bank.customer_transactions
where txn_type = 'deposit'
group by customer_id)

select round(avg(total_count),2) as average_deposit_count, round(avg(total_amount),2) as average_deposit_amount
from cte

-- 3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
with deposit_count as (select extract(month from txn_date) as month_num, customer_id, count(*) as deposit_count
from data_bank.customer_transactions
where txn_type = 'deposit'
group by month_num, customer_id),

purchase_count as (select extract(month from txn_date) as month_num, customer_id, count(*) as purchase_count
from data_bank.customer_transactions
where txn_type = 'purchase'
group by month_num, customer_id),

withdrawal_count as (select extract(month from txn_date) as month_num, customer_id, count(*) as withdrawal_count
from data_bank.customer_transactions
where txn_type = 'withdrawal'
group by month_num, customer_id)

select dc.month_num, count(distinct(dc.customer_id))
from deposit_count as dc
join purchase_count as pc
on dc.customer_id = pc.customer_id
join withdrawal_count as wc
on pc.customer_id = wc.customer_id
where deposit_count > 1 and (purchase_count = 1 or withdrawal_count = 1)
group by dc.month_numa
