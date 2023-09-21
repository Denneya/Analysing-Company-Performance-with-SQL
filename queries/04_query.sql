WITH perf_date AS (
	select CONCAT(EXTRACT(YEAR FROM order_date), '-', EXTRACT(MONTH FROM order_date), '-', '01') AS year_month,
	COUNT(order_id) AS total_num_orders,
	FLOOR(SUM(freight))::INT AS total_freight
	FROM orders
	WHERE EXTRACT(YEAR FROM order_date) >= 1997 AND EXTRACT(YEAR FROM order_date) <= 1998
	GROUP BY year_month
)
SELECT * FROM perf_date WHERE total_num_orders > 35
ORDER BY total_freight DESC;

