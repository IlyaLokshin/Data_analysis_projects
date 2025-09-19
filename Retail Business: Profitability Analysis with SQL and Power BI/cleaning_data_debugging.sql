-- Correcting an issue with data format
CREATE VIEW orders_corrected AS
(SELECT order_id, 
	customer_id, 	
    postal_code, 
    '1899-12-31' + INTERVAL order_date DAY AS order_date,
    '1899-12-31' + INTERVAL ship_date DAY AS ship_date,
    delivery_duration, ship_mode
FROM orders);

-- Deleting hidden characters
UPDATE retail_business.returned
SET order_id = REPLACE(order_id, '\r', '');

UPDATE retail_business.returned
SET order_status = Replace(order_status, '\r', '');

UPDATE retail_business.customer
SET segment = REPLACE(segment, '\r', '');

UPDATE retail_business.product
SET sub_category = REPLACE(sub_category, '\r', '');