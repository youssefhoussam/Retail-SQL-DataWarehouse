-- Query 1: Top 5 Customers by Total Spending
SELECT 
    c.customer_id,
    c.company_name,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_spent
FROM 
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
GROUP BY 
    c.customer_id, c.company_name
ORDER BY 
    total_spent DESC
LIMIT 5;

SELECT 
    cat.category_name,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_sales
FROM 
    categories cat
    JOIN products p ON cat.category_id = p.category_id
    JOIN order_details od ON p.product_id = od.product_id
GROUP BY 
    cat.category_name
ORDER BY 
    total_sales DESC;


SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(MONTH FROM o.order_date) AS month,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS monthly_revenue
FROM 
    orders o
    JOIN order_details od ON o.order_id = od.order_id
GROUP BY 
    year, month
ORDER BY 
    year, month;

SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    c.company_name,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS yearly_revenue,
    RANK() OVER (
        PARTITION BY EXTRACT(YEAR FROM o.order_date) 
        ORDER BY SUM(od.unit_price * od.quantity * (1 - od.discount)) DESC
    ) AS revenue_rank
FROM 
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
GROUP BY 
    year, c.customer_id, c.company_name
ORDER BY 
    year, revenue_rank;

WITH monthly_sales AS (
    SELECT 
        EXTRACT(YEAR FROM o.order_date) AS year,
        EXTRACT(MONTH FROM o.order_date) AS month,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS monthly_revenue
    FROM 
        orders o
        JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 
        year, month
)
SELECT 
    year,
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY year, month 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM 
    monthly_sales
ORDER BY 
    year, month;

WITH customer_order_totals AS (
    SELECT 
        c.customer_id,
        c.company_name,
        o.order_id,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS order_total
    FROM 
        customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 
        c.customer_id, c.company_name, o.order_id
)
SELECT 
    customer_id,
    company_name,
    order_id,
    order_total,
    AVG(order_total) OVER (PARTITION BY customer_id) AS avg_order_value,
    order_total - AVG(order_total) OVER (PARTITION BY customer_id) AS difference_from_avg
FROM 
    customer_order_totals
ORDER BY 
    company_name, order_id;