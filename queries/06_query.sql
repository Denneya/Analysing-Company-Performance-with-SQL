SELECT c.category_name,
	CASE WHEN p.unit_price < 20 THEN '1. Below $20'
		WHEN p.unit_price BETWEEN 20 AND 50 THEN '2. $20 - $50'
		WHEN p.unit_price > 50 then '3. Over $50'
	END AS price_range,
	CAST(SUM((od.unit_price * od.quantity) - od.discount) AS INT) AS total_amount,
	COUNT(DISTINCT od.order_id) AS total_volume_orders
FROM categories c 
INNER JOIN products AS p
ON p.category_id = c.category_id 
INNER JOIN order_details od
ON od.product_id = p.product_id 
GROUP BY c.category_name, price_range
ORDER BY c.category_name, price_range ASC;
