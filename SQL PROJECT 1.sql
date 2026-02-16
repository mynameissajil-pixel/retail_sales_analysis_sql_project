#SQL PROJECT 1
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

# -----DATA CLEANING-----

select* from retail_sales;
select count(*) from retail_sales;
drop table retail_sales;
select count(*) from retail_sales;

 # in this file the count of row is 1997 and in the csv file the count is 2000 so there null values in  quantity,  price_per_unit, cogs, total_sales 
 # it will be automaticaly deleted
 
 # DATA EXPLORATION
 
 # how many sales we have?
 SELECT COUNT(TOTAL_SALE) FROM RETAIL_SALES;
 
 # how many unique customers we have?
 SELECT COUNT( DISTINCT CUSTOMER_ID) FROM RETAIL_SALES;
 
# how many categories we have?
SELECT DISTINCT CATEGORY FROM RETAIL_SALES;

 
 
 

#-----DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS-----



# 1)Write a SQL query to retrieve all columns for sales made on 2022-11-05:

SELECT * FROM RETAIL_SALES WHERE SALE_DATE = "2022-11-05";


# 2)Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT*
FROM RETAIL_SALES
WHERE CATEGORY= "CLOTHING" AND QUANTITY<=4
AND DATE_FORMAT(SALE_DATE, '%Y-%m') = '2022-11';


ALTER TABLE RETAIL_SALES RENAME column QUANTIY TO QUANTITY;
DESCRIBE RETAIL_SALES;


# 3)Write a SQL query to calculate the total sales (total_sale) for each category:

SELECT CATEGORY,SUM(TOTAL_SALE) AS NET_SALES,COUNT(*) AS TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY CATEGORY;

# 4)Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT ROUND(AVG(AGE),2)
FROM RETAIL_SALES
WHERE CATEGORY="BEAUTY";

# 5)Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT *
FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000;

# 6)Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
CATEGORY,
GENDER, COUNT(*)
FROM RETAIL_SALES
GROUP BY
CATEGORY,
GENDER
ORDER BY 1;

# 7)Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

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
  
# 8)Write a SQL query to find the top 5 customers based on the highest total sales 
  
  SELECT 
  CUSTOMER_ID, SUM(TOTAL_SALE)
  FROM RETAIL_SALES
  group by CUSTOMER_ID
  ORDER BY SUM(TOTAL_SALE) DESC
  LIMIT 5;
  
# 9)Write a SQL query to find the number of unique customers who purchased items from each category.:
  
  SELECT
  CATEGORY,
  COUNT(DISTINCT CUSTOMER_ID) AS COUNT_UNIQUE_CUSTOMERS
  FROM RETAIL_SALES
  GROUP BY 
  CATEGORY;
  
# 10)Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 
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


# ---------END OF PROJECT---------


  
  
 
 




                     




 
 
 
              
           



