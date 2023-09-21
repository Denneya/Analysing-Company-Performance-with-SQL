WITH sales_kpi AS (

SELECT c.category_name,
CONCAT(e.first_name,' ',e.last_name) AS employee_full_name,
ROUND(
    SUM((1 - od.discount)*(od.quantity * od.unit_price))::NUMERIC,2) AS total_sales_incl_discount

FROM employees AS e 
INNER JOIN orders AS o 
ON e.employee_id = o.employee_id 
INNER JOIN order_details AS od 
ON o.order_id = od.order_id 
INNER JOIN products AS p 
ON od.product_id = p.product_id 
INNER JOIN categories AS c 
ON c.category_id = p.category_id 
GROUP BY 
category_name, employee_full_name 

)

SELECT *,

ROUND(
    SUM(total_sales_incl_discount) /
    SUM(SUM(total_sales_incl_discount))
        OVER(PARTITION BY category_name) * 100, 5
) AS percent_of_category_sales,
ROUND(
    SUM(total_sales_incl_discount) /
    SUM(SUM(total_sales_incl_discount))
        OVER(PARTITION BY employee_full_name) * 100, 5
) AS percent_of_employee_sales

FROM sales_kpi 
GROUP BY 
category_name, employee_full_name, total_sales_incl_discount
ORDER BY
category_name ASC, total_sales_incl_discount DESC

;
