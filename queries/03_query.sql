SELECT 
	CONCAT(e.first_name,' ',e.last_name) AS employee_full_name, 
	e.title AS employee_title, 
	DATE_PART('year',AGE(e.hire_date,e.birth_date))::INT AS employee_age,
	DATE_PART('year',AGE(CURRENT_DATE,e.hire_date))::INT AS employee_tenure,
	CONCAT(m.first_name,' ',m.last_name) AS manager_full_name, m.title AS manager_title
FROM 
employees AS e 
INNER JOIN employees AS m 
ON m.employee_id = e.reports_to
ORDER BY employee_age, employee_full_name;