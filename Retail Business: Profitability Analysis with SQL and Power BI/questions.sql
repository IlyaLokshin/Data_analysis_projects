-- QUESTIONS

-- 1. What are the sales, gross profit and profit margin aggegregated by products, 
-- product categories and subcategories, regions, states and time periods? 
-- (Such a table would be especially useful for creating visualizations in Power BI)
SELECT
	product_id, category, sub_category, 
    region, state, 
    EXTRACT(YEAR FROM order_date) AS year, EXTRACT(QUARTER FROM order_date) AS quarter, MONTHNAME(order_date) AS month,
    segment,
    SUM(sales_volume) AS total_sales,
	SUM(gross_profit) AS total_gross_profit,
	SUM(net_profit) AS total_net_profit,
    ROUND(100*(SUM(net_profit) / SUM(sales_volume)), 2) AS margin
FROM integrated_table
GROUP BY product_id, category, sub_category, region, state, 
	EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date), MONTHNAME(order_date), 
    segment;

-- 2. What are the total sales, total net profit and profit margin?
SELECT
    SUM(sales_volume) AS total_sales,
	SUM(gross_profit) AS total_gross_profit,
	SUM(net_profit) AS total_net_profit,
    ROUND(100*(SUM(net_profit) / SUM(sales_volume)), 2) AS margin
FROM integrated_table;

-- 3. What are top 10 products by sales and net profit?
SELECT
	product_id,
    SUM(sales_volume) AS total_sales_by_product
FROM integrated_table
GROUP BY product_id
ORDER BY total_sales_by_product DESC
LIMIT 10;

SELECT
	product_id,
	SUM(net_profit) AS total_net_profit_by_product
FROM integrated_table
GROUP BY product_id
ORDER BY total_net_profit_by_product DESC
LIMIT 10;

-- 4. What are top 10 product subcategories by sales and net profit?
SELECT
	sub_category,
    SUM(sales_volume) AS total_sales_by_subcategory
FROM integrated_table
GROUP BY sub_category
ORDER BY total_sales_by_subcategory DESC
LIMIT 10;

SELECT
	sub_category,
	SUM(net_profit) AS total_net_profit_by_subcategory
FROM integrated_table
GROUP BY sub_category
ORDER BY total_net_profit_by_subcategory DESC
LIMIT 10;

-- 5. What is the order of product categories by sales and net profit?
SELECT
	category,
    SUM(sales_volume) AS total_sales_by_category
FROM integrated_table
GROUP BY category
ORDER BY total_sales_by_category DESC;

SELECT
	category,
	SUM(net_profit) AS total_net_profit_by_category
FROM integrated_table
GROUP BY category
ORDER BY total_net_profit_by_category DESC;

-- 6. What is the order of customer segments by sales, net profit and profit margin?
SELECT
	segment,
    SUM(sales_volume) AS total_sales_by_segment
FROM integrated_table
GROUP BY segment
ORDER BY total_sales_by_segment DESC;

SELECT
	segment,
	SUM(net_profit) AS total_net_profit_by_segment
FROM integrated_table
GROUP BY segment
ORDER BY total_net_profit_by_segment DESC;

SELECT
	segment,
    ROUND(100*(SUM(net_profit) / SUM(sales_volume)), 2) AS margin_by_segment
FROM integrated_table
GROUP BY segment
ORDER BY margin_by_segment DESC;

-- 7. What is the order of regions by sales and net profit?
SELECT
	region,
    SUM(sales_volume) AS total_sales_by_region
FROM integrated_table
GROUP BY region
ORDER BY total_sales_by_region DESC;

SELECT
	region,
	SUM(net_profit) AS total_net_profit_by_region
FROM integrated_table
GROUP BY region
ORDER BY total_net_profit_by_region DESC;

-- 8. What are top 10 states by sales and net profit?
SELECT
	state,
    SUM(sales_volume) AS total_sales_by_state
FROM integrated_table
GROUP BY state
ORDER BY total_sales_by_state DESC
LIMIT 10;

SELECT
	state,
	SUM(net_profit) AS total_net_profit_by_state
FROM integrated_table
GROUP BY state
ORDER BY total_net_profit_by_state DESC
LIMIT 10;

-- 9. What is the total average order value (AOV)?
SELECT ROUND(SUM(sales_volume) / COUNT(DISTINCT order_id), 2) AS av_order_value
FROM integrated_table;

-- 10. What are AOVs by time periods?
SELECT 
	MONTHNAME(order_date) AS month,
    ROUND(SUM(sales_volume) / COUNT(DISTINCT order_id), 2) AS av_order_value_by_month
FROM integrated_table
GROUP BY MONTHNAME(order_date);

SELECT 
	EXTRACT(QUARTER FROM order_date) AS quarter,
    ROUND(SUM(sales_volume) / COUNT(DISTINCT order_id), 2) AS av_order_value_by_quarter
FROM integrated_table
GROUP BY EXTRACT(QUARTER FROM order_date);

SELECT 
	EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales_volume) / COUNT(DISTINCT order_id), 2) AS av_order_value_by_year
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date);

SELECT 
	MONTHNAME(order_date) AS month, EXTRACT(YEAR FROM order_date) AS year, 
    ROUND(SUM(sales_volume) / COUNT(DISTINCT order_id), 2) AS av_order_value_by_year_month
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), MONTHNAME(order_date);

-- 11. What are AOVs by region, by region and year?
SELECT 
	region,
    ROUND(SUM(sales_volume) / COUNT(DISTINCT order_id), 2) AS av_order_value_by_region
FROM integrated_table
GROUP BY region;

SELECT 
	region, EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales_volume) / COUNT(DISTINCT order_id), 2) AS av_order_value_by_region_year
FROM integrated_table
GROUP BY region, EXTRACT(YEAR FROM order_date);

-- 12. What are AOVs by state (for states with more than 20 orders)?
SELECT 
	state, COUNT(DISTINCT order_id) AS num_orders,
    ROUND(SUM(sales_volume) / COUNT(DISTINCT order_id), 2) AS av_order_value_by_state
FROM integrated_table
GROUP BY state
HAVING num_orders > 20;

-- 13. What are AOVs by customer cohorts (in terms of the number of purchases, 
-- with cohort 1 including customers with small number of purchases and cohort 4 a large number of purchases)?
SELECT 
	customer_cohort,
    ROUND(AVG(av_order_value_per_customer), 2) AS av_order_value_per_cohort
FROM customers_cohorts
GROUP BY customer_cohort
ORDER BY customer_cohort;

-- 14. Does the AOV of one-off customers differ from the AOV of customers who made more than one purchase?
SELECT 
	customer_type,
    ROUND(AVG(av_order_value_per_customer), 2) AS av_order_value_per_cust_type
FROM
(SELECT 
	av_order_value_per_customer,
    CASE 
		WHEN customer_cohort > 1 THEN 'regular'
		ELSE 'one_time' 
    END AS customer_type
FROM customers_cohorts) AS customer_type_table
GROUP BY customer_type;

-- 15. What is the relationship between discount values and the quantities of products sold, 
-- conditioned by a product category and a customer segment? (Data for a scatter plot in Power BI)
SELECT 
    product_id,
    category,
    segment,
    discount,
    sales, 
    quantity, 
    sales * quantity AS total_sales,
    -discount_value AS discount_value, 
    -COGS AS COGS,
    profit
FROM integrated_table;

-- 16. What is the ratio of returned orders by state and by customer segment?
WITH unique_orders AS
(SELECT DISTINCT order_id, order_status, state
FROM integrated_table) 
SELECT 
	state,
    ROUND(AVG(IF(order_status = 'Returned', 1, 0)), 2) AS ratio_returned
FROM unique_orders
GROUP BY state
ORDER BY ratio_returned DESC;

WITH unique_orders AS
(SELECT DISTINCT order_id, order_status, segment
FROM integrated_table) 
SELECT 
	segment,
    ROUND(AVG(IF(order_status = 'Returned', 1, 0)), 2) AS ratio_returned
FROM unique_orders
GROUP BY segment
ORDER BY ratio_returned DESC;

-- 17. What are top 10 states by total shipping cost?
WITH temp AS
(SELECT order_id, state, quantity, shipping_cost_per_unit
FROM integrated_table)
SELECT state, SUM(shipping_cost_per_unit * quantity) AS total_cost_of_shipping
FROM temp
GROUP BY state
ORDER BY total_cost_of_shipping DESC
LIMIT 10;