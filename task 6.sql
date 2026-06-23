# TASK 6: Sales Trend Analysis Using Aggregations
# Objective: Analyze monthly revenue and order volume.
# Tools: MySQL 

CREATE DATABASE online_sales_db;
USE online_sales_db;
SELECT * FROM orders;

-- 1. Calculate Monthly Revenue
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    SUM(amount) AS Revenue
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY Month;

-- 2. Calculate Monthly Order Volume
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY Month;

-- 3. Analyze Monthly Revenue and Order Volume Together
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    EXTRACT(YEAR FROM order_date) AS Year,
    SUM(amount) AS Revenue,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date),year
ORDER BY Month;

-- 4. Find Revenue and Order Volume for Jan–Mar 2024
SELECT
    EXTRACT(YEAR FROM order_date) AS Year,
    EXTRACT(MONTH FROM order_date) AS Month,
    SUM(amount) AS Revenue,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY Year, Month
ORDER BY Year, Month;

-- 5. Find Months with Highest Revenue First
SELECT
    EXTRACT(YEAR FROM order_date) AS Year,
    EXTRACT(MONTH FROM order_date) AS Month,
    SUM(amount) AS Revenue,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM orders
GROUP BY Year, Month
ORDER BY Revenue DESC;

-- 6. Which month had the highest revenue?
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    SUM(amount) AS Revenue
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY revenue DESC
LIMIT 1;

-- 7. Which month had the lowest revenue?
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    SUM(amount) AS Revenue
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY Revenue ASC
LIMIT 1;

-- 8. Find months where revenue exceeded ₹2000.
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    SUM(amount) AS Revenue
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
HAVING SUM(amount) > 2000
ORDER BY Revenue DESC;

-- 9. Find months with more than 3 orders.
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
HAVING COUNT(DISTINCT order_id) > 3
ORDER BY Order_Volume DESC;

-- 10. Calculate average revenue per order each month.
SELECT 
	EXTRACT(MONTH FROM order_date) AS Month,
    AVG(amount) AS average_revenue
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY month;

-- 11. Find total revenue generated in the first quarter (Jan-Mar).
SELECT
    SUM(amount) AS Total_Revenue
FROM orders
WHERE EXTRACT(MONTH FROM order_date) BETWEEN 1 AND 3;

-- 12. Rank months based on revenue.
SELECT
    EXTRACT(MONTH FROM order_date) AS Month,
    SUM(amount) AS Revenue,
    RANK() OVER(ORDER BY SUM(amount) DESC) AS Revenue_Rank
FROM orders
GROUP BY Month;

-- 13. Top 3 Products by Revenue
SELECT
	product_id AS product,
	SUM(amount) AS Revenue
FROM orders
GROUP BY product_id
ORDER by revenue DESC
LIMIT 3;

-- 14. Total Orders per Product
SELECT
    product_id AS Product,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY product_id
ORDER BY Total_Orders DESC;

-- 15. Find the top 3 months with the highest order volume.
SELECT
    EXTRACT(YEAR FROM order_date) AS Year,
    EXTRACT(MONTH FROM order_date) AS Month,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM orders
GROUP BY Year, Month
ORDER BY Order_Volume DESC
LIMIT 3;











