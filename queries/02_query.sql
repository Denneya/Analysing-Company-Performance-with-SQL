WITH avg_date_cte AS (
	SELECT ship_country,
	ROUND(AVG(EXTRACT(DAY FROM (shipped_date - order_date) * INTERVAL '1 DAY')):: NUMERIC,2) 
	AS avg_days_order_shipped,
	COUNT(DISTINCT order_id) AS tot_volume_orders
	FROM orders
	WHERE EXTRACT(YEAR from order_date) = 1998
	GROUP BY ship_country
)
SELECT * FROM avg_date_cte
WHERE
avg_days_order_shipped >= 5 AND
tot_volume_orders > 10
ORDER BY
ship_country ASC;