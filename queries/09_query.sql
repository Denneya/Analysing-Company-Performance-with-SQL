WITH emp_kpi AS (
    SELECT 
        CONCAT(e.first_name , ' ' , e.last_name) AS employee_full_name,
        e.title AS employee_title,
        ROUND(SUM(od.unit_price * od.quantity)::NUMERIC, 2) AS total_sales_excl_discount,
        COUNT(DISTINCT od.order_id) AS tot_unique_orders,
        COUNT(od.order_id) AS tot_orders,
        ROUND(AVG((od.product_id * od.quantity))::NUMERIC, 2) AS avg_product_amount,
        ROUND((SUM(od.quantity * od.product_id)/COUNT(DISTINCT od.order_id)):: NUMERIC, 2) AS avg_order_amount,
        ROUND(SUM(od.quantity * od.unit_price * od.discount)::NUMERIC, 2) AS tot_discount_amount,
        ROUND(SUM(od.quantity * od.unit_price * (1-od.discount))::NUMERIC, 2) AS tot_sales_incl_discount,
        ROUND(((SUM(od.unit_price * od.quantity * od.discount)/SUM(od.unit_price * od.quantity))*100)::NUMERIC, 2) AS tot_discount_perc
    FROM orders AS o
    INNER JOIN employees AS e ON o.employee_id = e.employee_id
    INNER JOIN order_details AS od ON od.order_id = o.order_id
    INNER JOIN products AS p ON od.product_id = p.product_id
    GROUP BY employee_full_name, employee_title
)
SELECT 
    employee_full_name,
    employee_title,
    total_sales_excl_discount,
    tot_unique_orders,
    tot_orders,
    avg_product_amount,
    tot_discount_amount,
    tot_sales_incl_discount,
    tot_discount_perc
FROM emp_kpi
ORDER BY tot_sales_incl_discount DESC;