# retail_sales_analysis_sql_project
## Project Overview

**Project Title**: Retail Sales Analysis   
**Database**: `sqlproject1`

This project is designed to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sqlproject1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database sqlproject1;
use sqlproject1;

# CREATE TBALE

create table retail_sales(
              transactions_id int primary key,	
              sale_date	date,
              sale_time	time,
			        customer_id int,	
              gender varchar(25),	
              age	int,
              category	varchar(25),
              quantiy int,	
              price_per_unit float,	
              cogs	float,
              total_sale float

);
```

##2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select* from retail_sales;
select count(*) from retail_sales;
drop table retail_sales;
select count(*) from retail_sales;
```

**The original CSV file contains 2000 rows, but this file has only 1997 rows because records with null values in the columns quantity, price_per_unit, cogs, and total_sales were automatically removed.
 
##Data Exploration
 
 ```sql
# how many sales we have?
SELECT COUNT(TOTAL_SALE) FROM RETAIL_SALES;
 
# how many unique customers we have?
SELECT COUNT( DISTINCT CUSTOMER_ID) FROM RETAIL_SALES;
 
# how many categories we have?
SELECT DISTINCT CATEGORY FROM RETAIL_SALES;
```

## 3. Data Analysis & Findings

1) Write a SQL query to retrieve all columns for sales made on 2022-11-05:

```sql
SELECT * FROM RETAIL_SALES WHERE SALE_DATE = "2022-11-05";
```


2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

```sql
SELECT*
FROM RETAIL_SALES
WHERE CATEGORY= "CLOTHING" AND QUANTITY<=4
AND DATE_FORMAT(SALE_DATE, '%Y-%m') = '2022-11';


ALTER TABLE RETAIL_SALES RENAME column QUANTIY TO QUANTITY;
DESCRIBE RETAIL_SALES;
```

3) Write a SQL query to calculate the total sales (total_sale) for each category:

```sql
SELECT CATEGORY,SUM(TOTAL_SALE) AS NET_SALES,COUNT(*) AS TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY CATEGORY;
```

4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

```sql
SELECT ROUND(AVG(AGE),2)
FROM RETAIL_SALES
WHERE CATEGORY="BEAUTY";
```

5) Write a SQL query to find all transactions where the total_sale is greater than 1000.:

```sql
SELECT *
FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000;
```

6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

```sql
SELECT 
CATEGORY,
GENDER, COUNT(*)
FROM RETAIL_SALES
GROUP BY
CATEGORY,
GENDER
ORDER BY 1;
```

7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

```sql
SELECT * FROM
  (
  SELECT
  YEAR(SALE_DATE),
   MONTH(SALE_DATE),
   AVG(TOTAL_SALE),
   RANK() OVER(partition by  YEAR(SALE_DATE)ORDER BY AVG(TOTAL_SALE)desc) AS RANK_NO 
FROM RETAIL_SALES
GROUP BY
   YEAR(SALE_DATE),
   MONTH(SALE_DATE)
   ) AS T1
   WHERE RANK_NO = 1;
  #ORDER BY   YEAR(SALE_DATE), AVG(TOTAL_SALE) DESC
```
  
8) Write a SQL query to find the top 5 customers based on the highest total sales 
  
 ```sql
  SELECT 
  CUSTOMER_ID, SUM(TOTAL_SALE)
  FROM RETAIL_SALES
  group by CUSTOMER_ID
  ORDER BY SUM(TOTAL_SALE) DESC
  LIMIT 5;
```
  
9) Write a SQL query to find the number of unique customers who purchased items from each category.:
  
  ```sql
  SELECT
  CATEGORY,
  COUNT(DISTINCT CUSTOMER_ID) AS COUNT_UNIQUE_CUSTOMERS
  FROM RETAIL_SALES
  GROUP BY 
  CATEGORY;
  ```
10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 
 ```sql
WITH HOURLY_SALES
  AS
  (SELECT *,
  CASE
     WHEN hour(SALE_TIME)<12 THEN 'MORNING'
     WHEN HOUR(SALE_TIME) BETWEEN 12 AND 17 THEN "AFTERNOON"
     ELSE "EVENING"
	END AS SHIFT
FROM RETAIL_SALES)
SELECT 
SHIFT,
COUNT(*) AS NUMBER_OF_ORDERS
FROM HOURLY_SALES
GROUP BY SHIFT
```

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
