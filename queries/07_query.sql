SELECT 
	CASE
		WHEN supplier.country IN ('Brazil', 'Canada', 'USA') THEN 'America'
		WHEN supplier.country IN ('Denmark', 'Finland','Netherlands', 'Norway', 'Sweden', 'France', 'Germany', 'Italy', 'UK', 'Spain') THEN 'Europe'
		WHEN supplier.country IN ('Japan', 'Singapore', 'Australia') THEN 'Asia Pacific'
	END AS supplier_region,
	c.category_name,
	SUM(p.unit_in_stock) AS tot_units_in_stock,
	SUM(p.unit_on_order) AS tot_units_on_order,
	SUM(p.reorder_level) AS tot_reorder_level
FROM suppliers AS supplier
INNER JOIN products AS p
ON supplier.supplier_id = p.supplier_id 
INNER JOIN categories AS c
ON p.category_id = c.category_id
GROUP BY supplier_region, c.category_name
ORDER BY c.category_name ASC, supplier_region ASC, tot_reorder_level ASC;


