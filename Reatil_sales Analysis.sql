-- SQL Retalil Sales analysis - p1

DROP TABLE IF EXISTS sales_data;
CREATE TABLE sales_data (
    transactions_id INT PRIMARY KEY ,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(16),
    age INT,
    category VARCHAR(50),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);


SELECT * FROM sales_data

SELECT 
	COUNT(*)
FROM sales_data


SELECT * FROM sales_data
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL

DELETE FROM sales_data
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL

-- Data Exploration 

-- How many sales we have?

SELECT COUNT(*) AS 
FROM sales_data

-- How many cusotmers we have?
SELECT count(DISTINCT customer_id) as total_sale FROM sales_data

-- How many unique category we have?

SELECT COUNT(DISTINCT category) as total_sale FROM sales_data;


-- Name of Distinct Category:
SELECT DISTINCT category 
	FROM sales_data

-- Data Analysis 7 Business key problem & Answers:

-- Q.1 Write a SQL query to retrive all columns for sales made on '2022-11-05' 

SELECT*
FROM sales_data
WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transations where the category is 'Clothing' and the quantity sold is more than 10 in 
-- month of Nov-2022

SELECT *
FROM sales_data 
WHERE category = 'Clothing'
	AND	
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND 
	quantity >=4

-- method-2

SELECT *
FROM sales_data
WHERE category = 'Clothing'
	AND sale_date BETWEEN DATE '2022-11-01' AND DATE '2022-11-30'
	AND quantity >=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) fro each category.

SELECT
	category,
	sum(total_sale) as net_sale,
	COUNT(*) AS total_orders
FROM sales_data
group by category

-- Q.4 Wrtie a SQL query to find the average age of cusotmers who purchased items from the 'Beauty' category.
select * from sales_data
SELECT
	ROUND(avg(age),2) AS avg_age
FROM sales_data 
where category= 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT
	*
FROM sales_data 
where total_sale > 1000

--Q.6 Write  A SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
	category,gender, count(transactions_id)
FROM
	sales_data
GROUP BY category,gender
ORDER BY category

-- Q.7 Write a SQL query to calculate the average sale for each month. find out best selling month in each year

SELECT
	TO_CHAR(sale_date,'YYYY-MM') AS Year_month,sum(total_sale) as Total_Sales
FROM sales_data
group by TO_CHAR(sale_date,'YYYY-MM')
ORDER BY TO_CHAR(sale_date,'YYYY-MM') asc


-- real teacher method

SELECT * 
FROM(
SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	avg(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) desc ) as rank
FROM
	sales_data
GROUP BY 1,2
)
WHERE rank =1


-- Q. 8 Write a SQL query to find the top 5 customers based on the highest total sales


select * from sales_data



SELECT customer_id, sum(total_sale)
FROM sales_data
group by customer_id
order by sum(total_sale) desc
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique cusotmers who purchased items from each category.

select category,
	   count(distinct customer_id) as NO_of_Unique_customer
from sales_data
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (example morning <=12, afternoon between 12 & 17, evening >17)

WITH Hourly_sales
AS(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM sales_data
)
SELECT
	shift,
	count(*) as total_orders
from Hourly_sales
group by shift


End Project..



