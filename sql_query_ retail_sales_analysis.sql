-- sql Retail Sales Analysis - P1

use retail_sales_analysis2;

-- Create Table 
Drop TABLE IF EXISTS reatil_sales;
Create table retail_sales
			(
				transiction_id INT Primary key,
                Sale_date DATE,
                Sale_time Time,
                Customer_id INT,
                gender VARCHAR(15),
                age INT,
                category VARCHAR(15),
                quantity INT,
                price_per_unit FLOAT,
                cogs FLOAT,
                total_sale FLOAT
			);
	SELECT * FROM retail_sales;
    
    SELECT 
    COUNT(*)
    FROM retail_sales;
    
 
 -- CHECK NULL values or data cleaning
 
SELECT * FROM retail_sales
where Transiction_id is null; 

SELECT * FROM retail_sales
where Sale_date is null; 

SELECT * FROM retail_sales
where Sale_time is null; 

SELECT * FROM retail_sales
where Customer_id is null; 
 
 Select * from retail_sales
 where 
	transiction_id IS NULL
    OR
    Sale_date IS NULL
    OR
    Sale_time IS NULL
    OR
    gender IS NULL
    OR
    Quantity IS NULL
    OR
    Cogs IS NULL
    OR
    total_sale IS NULL;
    
 SELECT 
 COUNT(*)
 FROM retail_sales;
 
 
 -- DATA EXPOLRATION
 
 -- HOW MANY SALES WE HAVE ?
select count(*) as total_sale FROM retail_sales;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE ?
select count(distinct customer_id) as total_sale FROM retail_sales;

-- HOW MANY UNIQUE CATEGORY WE HAVE ?
select count(distinct category) as total_sale FROM retail_sales;

-- WHAT ARE THE 3 CATEGORIES
select distinct category from retail_sales;


-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWER

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022            
SELECT *  
FROM retail_sales  
WHERE category = 'Clothing'  
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
and quantity >= 4;

-- Q.3  Write a SQL query to calculate the total sales (total_sale) for each category.?

Select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

  select avg(age) as avg_age
  from retail_sales
  where category = 'beauty';   -- this show 40.4157 to lenthy insted use this 
  
  select round(avg(age) ,2) as avg_age
  from retail_sales
  where category = 'beauty';  -- this show better result 40.42
  
  -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
  
 SELECT * 
FROM retail_sales  
WHERE total_sale > 1000; 
##### i want count than use 
SELECT count(*) as total_sales
FROM retail_sales  
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
category,
gender,
count(*) as total_trans
from retail_sales
group by category,
gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

  SELECT  
    DATE_FORMAT(sale_date, '%Y-%m') AS month,  
    round(AVG(total_sale) ,2) AS average_sale  
FROM retail_sales  
GROUP BY month  
ORDER BY month ; ###### this code is from chat gpt (bcoj other code like (extract not work in my sql workbench)

SELECT  
    DATE_FORMAT(sale_date, '%Y-%m') AS month,  
    round(AVG(total_sale),2)AS average_sale,  
    RANK() OVER (ORDER BY AVG(total_sale) DESC) AS rank_avg_sale  
FROM retail_sales  
GROUP BY month  
ORDER BY rank_avg_sale;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales ?

select 
customer_id,
SUM(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT  
    category,  
    COUNT(DISTINCT customer_id) AS unique_customers  
FROM retail_sales  
GROUP BY category  
ORDER BY unique_customers DESC;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

  SELECT  
    CASE  
        WHEN HOUR(sale_time) <= 12 THEN 'Morning'  
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'  
        ELSE 'Evening'  
    END AS shift,  
    COUNT(*) AS total_orders  
FROM retail_sales  
GROUP BY shift  
ORDER BY total_orders DESC;


### End of project