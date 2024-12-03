![image](https://github.com/user-attachments/assets/c8f046f8-8850-4e27-929a-f1348912688a)# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project-p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `sales_data` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```
![image](https://github.com/user-attachments/assets/998b1cb3-ef1a-4b34-a5b2-1e370d39b41d)



### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT 
	COUNT(*)
FROM sales_data
```
![image](https://github.com/user-attachments/assets/e961dede-4bed-4a85-8654-96a9338adae2)

```sql

SELECT count(DISTINCT customer_id) as total_unique_customer FROM sales_data
```
![image](https://github.com/user-attachments/assets/f4449a54-fd66-4497-b479-7cbf63a78233)

```sql
SELECT COUNT(DISTINCT category) as unique_category FROM sales_data;
```
![image](https://github.com/user-attachments/assets/c1791bc3-9e2c-4a7a-bf05-31820ce272d7)

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```
** Because of deleting Null values
![image](https://github.com/user-attachments/assets/e75d74cc-6094-4de6-b072-fdd6aacc9210)

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
--Method -1
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
```
![image](https://github.com/user-attachments/assets/e4bf215e-6a5c-4812-8c27-7b3b0c94686a)


3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT
	category,
	sum(total_sale) as net_sale,
	COUNT(*) AS total_orders
FROM sales_data
group by category
```
![image](https://github.com/user-attachments/assets/9b870217-4cc8-4bc1-b9cd-30b7d0ac8535)

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
	ROUND(avg(age),2) AS avg_age
FROM sales_data 
where category= 'Beauty'
```
![image](https://github.com/user-attachments/assets/c59c1d80-191b-4ff0-b9a9-b14a528d2d90)

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT
	*
FROM sales_data 
where total_sale > 1000

```
![image](https://github.com/user-attachments/assets/dd032c92-c427-4cb6-aae8-bbfd6086f6ef)


6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT
	category,gender, count(transactions_id)
FROM
	sales_data
GROUP BY category,gender
ORDER BY category
```
![image](https://github.com/user-attachments/assets/7aee4869-e1de-43f9-910b-a8ba5e970a86)

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```
![image](https://github.com/user-attachments/assets/393b0c2e-7069-4c52-a28a-efc16f53cddd)

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id, sum(total_sale)
FROM sales_data
group by customer_id
order by sum(total_sale) desc
LIMIT 5;
```
![image](https://github.com/user-attachments/assets/030f01a8-6135-406e-a7c4-836eb10f31ea)


9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select category,
	   count(distinct customer_id) as NO_of_Unique_customer
from sales_data
group by category
```
![image](https://github.com/user-attachments/assets/ac2f7b83-8099-4894-b664-7d79a5f1d6df)


10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
Step-1
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM sales_data

Step-2

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


```
![image](https://github.com/user-attachments/assets/4e6fa9f8-e5ed-46e4-a582-467e1b484d96)
![image](https://github.com/user-attachments/assets/e5ede476-232c-49d4-8ac1-8623705475e1)


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Rajdeep

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!



- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/rajdeep-kumar-74607a254/)

