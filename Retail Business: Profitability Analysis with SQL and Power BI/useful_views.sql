-- Creating a united view of orders and returns status 
CREATE VIEW orders_with_returns AS
(SELECT 
	oc.order_id, 
    oc.customer_id, 
    oc.postal_code, 
    oc.order_date, 
    oc.ship_date, 
    oc.delivery_duration, 
    oc.ship_mode, 
    COALESCE(
		CASE
			WHEN TRIM(LOWER(r.order_status)) = 'yes' THEN 'Returned'
            ELSE 'Not returned'
		END,
        'Not returned') AS order_status
FROM orders_corrected AS oc
LEFT JOIN returned AS r
USING(order_id));

-- Creating a view of an integrated table
CREATE VIEW integrated_table AS
(SELECT 
	orr.order_id,
    orr.postal_code,
    a.state,
    a.region,
    orr.order_date,
    orr.ship_date,
    product_id, 
    p.category,
    p.sub_category,
    sales, 
    quantity, 
    discount, 
    discount_value, 
    profit, 
    COGS,
    shipping_cost_per_unit,
    c.customer_id,
    c.segment,
    orr.order_status,
    IF(orr.order_status = 'Returned', 0, 1) * sales * quantity AS sales_volume,
    IF(orr.order_status = 'Returned', 0, 1) * profit * quantity AS gross_profit,
    IF(orr.order_status = 'Returned', 0, 1) * (profit - shipping_cost_per_unit) * quantity -  
		IF(order_status = 'Returned', 1, 0) * quantity * shipping_cost_per_unit AS net_profit
FROM retail_business.order_item
LEFT JOIN orders_with_returns AS orr
USING(order_id)
LEFT JOIN retail_business.address AS a
USING(postal_code)
LEFT JOIN retail_business.shipping_cost
USING(state)
LEFT JOIN product AS p
USING(product_id)
LEFT JOIN customer AS c
USING(customer_id));

-- Creating a view of customers cohorts table
CREATE VIEW customers_cohorts AS
(SELECT 
	DISTINCT customer_id,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(SUM(sales * quantity) / COUNT(DISTINCT order_id), 2)  AS av_order_value_per_customer,
    CASE 
		WHEN COUNT(DISTINCT order_id) BETWEEN 1 AND 3 THEN 1
        WHEN COUNT(DISTINCT order_id) BETWEEN 4 AND 6 THEN 2
		WHEN COUNT(DISTINCT order_id) BETWEEN 7 AND 9 THEN 3
		WHEN COUNT(DISTINCT order_id) > 9 THEN 4
	END AS customer_cohort
FROM integrated_table
GROUP BY customer_id
ORDER BY num_orders DESC);