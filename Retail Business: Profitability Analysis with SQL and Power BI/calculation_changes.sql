-- Calculations for changes in sales and profits (see the Results and Recommendations part of the project description)
SELECT
	EXTRACT(YEAR FROM order_date) AS year, sub_category,
	SUM(net_profit) AS total_net_profit_by_year_subcat
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), sub_category
HAVING sub_category = 'Tables';

SELECT AVG(net_profit_by_year_subcat) AS average
FROM (SELECT
	sub_category, EXTRACT(YEAR FROM order_date) AS year, 
	SUM(
			IF(order_status = 'Returned', 0, 1) * (sales + discount_value + COGS - shipping_cost_per_unit) * quantity -  
		IF(order_status = 'Returned', 1, 0) * quantity * shipping_cost_per_unit) AS net_profit_by_year_subcat
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), sub_category
HAVING sub_category = 'Tables') AS temp;

SELECT AVG(total_net_profit_by_year) AS average_by_year
FROM (SELECT
	EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales_volume) AS total_sales_by_year,
	SUM(gross_profit) AS total_gross_profit_by_year,
	SUM(net_profit) AS total_net_profit_by_year,
    ROUND(100*(SUM(net_profit) / SUM(sales_volume)), 2) AS margin_by_year
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date)) AS temp;

WITH cal_temp AS
(WITH temp AS
(SELECT order_id, state, quantity, shipping_cost_per_unit, order_date
FROM integrated_table)
SELECT state, SUM(7 * quantity) AS cost_of_shipping, EXTRACT(YEAR FROM order_date) AS year
FROM temp
GROUP BY state, EXTRACT(YEAR FROM order_date)
HAVING state = 'California')
SELECT AVG(cost_of_shipping) AS avergate_ship_cost
FROM cal_temp;

WITH cal_temp AS
(WITH temp AS
(SELECT order_id, state, quantity, shipping_cost_per_unit, order_date
FROM integrated_table)
SELECT state, SUM(5 * quantity) AS cost_of_shipping, EXTRACT(YEAR FROM order_date) AS year
FROM temp
GROUP BY state, EXTRACT(YEAR FROM order_date)
HAVING state = 'California')
SELECT AVG(cost_of_shipping) AS avergate_ship_cost
FROM cal_temp;

WITH tex_temp AS
(WITH temp AS
(SELECT order_id, state, quantity, shipping_cost_per_unit, order_date
FROM integrated_table)
SELECT state, SUM(10 * quantity) AS cost_of_shipping, EXTRACT(YEAR FROM order_date) AS year
FROM temp
GROUP BY state, EXTRACT(YEAR FROM order_date)
HAVING state = 'Texas')
SELECT AVG(cost_of_shipping) AS avergate_ship_cost
FROM tex_temp;

WITH tex_temp AS
(WITH temp AS
(SELECT order_id, state, quantity, shipping_cost_per_unit, order_date
FROM integrated_table)
SELECT state, SUM(8 * quantity) AS cost_of_shipping, EXTRACT(YEAR FROM order_date) AS year
FROM temp
GROUP BY state, EXTRACT(YEAR FROM order_date)
HAVING state = 'Texas')
SELECT AVG(cost_of_shipping) AS avergate_ship_cost
FROM tex_temp;

SELECT ROUND(AVG(num_orders), 2) AS avg_num_orders_febr
FROM (SELECT 
	COUNT(DISTINCT order_id) AS num_orders, 
    EXTRACT(YEAR from order_date) AS year, 
    MONTHNAME(order_date) AS month
FROM integrated_table
GROUP BY EXTRACT(YEAR from order_date), 
    MONTHNAME(order_date)
HAVING month = 'February') AS num_orders_febr;

SELECT ROUND(AVG(total_sales_by_year), 1) FROM
(SELECT
	EXTRACT(YEAR FROM order_date) AS year, 
	SUM(sales_volume) AS total_sales_by_year
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date)) AS av_year;

SELECT ROUND(AVG(net_profit_by_year), 1) FROM
(SELECT
	EXTRACT(YEAR FROM order_date) AS year, 
	SUM(net_profit) AS net_profit_by_year
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date)) AS av_year;

SELECT ROUND(AVG(net_profit_by_year), 1) FROM
(SELECT
	EXTRACT(YEAR FROM order_date) AS year, 
	SUM(IF(order_status = 'Returned', 0, 1) * (sales + discount_value + COGS - shipping_cost_per_unit) * quantity -  
		IF(order_status = 'Returned', 1, 0) * quantity * shipping_cost_per_unit) AS net_profit_by_year
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date)) AS av_year;

SELECT ROUND(AVG(num_subcategory), 2) AS average_per_year FROM
(SELECT
	sub_category, EXTRACT(YEAR FROM order_date) AS year, 
	SUM(quantity) AS num_subcategory
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), sub_category
HAVING sub_category = 'Tables') AS temp_table;

SELECT ROUND(AVG(total_sales_subcategory), 1) AS average_per_year FROM
(SELECT
	sub_category, EXTRACT(YEAR FROM order_date) AS year, 
	SUM(sales_volume) AS total_sales_subcategory
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), sub_category
HAVING sub_category = 'Copiers') AS temp_table;

SELECT ROUND(AVG(total_sales_subcategory), 1) AS average_per_year FROM
(SELECT
	sub_category, EXTRACT(YEAR FROM order_date) AS year, 
	SUM(sales_volume) AS total_sales_subcategory
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), sub_category
HAVING sub_category = 'Paper') AS temp_table;

SELECT ROUND(AVG(total_sales_subcategory), 2) AS average_per_year FROM
(SELECT
	sub_category, EXTRACT(YEAR FROM order_date) AS year, 
	SUM(sales_volume) AS total_sales_subcategory
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), sub_category
HAVING sub_category = 'Envelopes') AS temp_table;

SELECT ROUND(AVG(total_sales_subcategory), 1) AS average_per_year FROM
(SELECT
	sub_category, EXTRACT(YEAR FROM order_date) AS year, 
	SUM(sales_volume) AS total_sales_subcategory
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), sub_category
HAVING sub_category = 'Labels') AS temp_table;

SELECT ROUND(AVG(total_sales_region), 2) AS average_per_year FROM
(SELECT
	region, EXTRACT(YEAR FROM order_date) AS year, EXTRACT(QUARTER FROM order_date) AS quarter, 
	SUM(sales_volume) AS total_sales_region
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date), region
HAVING region = 'Central') AS temp_table;

SELECT
	region, EXTRACT(YEAR FROM order_date) AS year, EXTRACT(QUARTER FROM order_date) AS quarter, 
	SUM(net_profit) AS profit_region
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date), region
HAVING region = 'Central';

SELECT ROUND(AVG(net_profit_region), 2) AS average_per_quarter FROM
(SELECT
	region, EXTRACT(YEAR FROM order_date) AS year, EXTRACT(QUARTER FROM order_date) AS quarter, 
	SUM(net_profit) AS net_profit_region
FROM integrated_table
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date), region
HAVING region = 'Central') AS temp_table;