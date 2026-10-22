-- Project 4: SQL Sales Analysis
-- Compatible with SQLite after importing sales.csv as a table named sales.

-- 1. Total revenue and order count
SELECT COUNT(*) AS order_count, ROUND(SUM(revenue), 2) AS total_revenue
FROM sales;

-- 2. Revenue by product
SELECT product, ROUND(SUM(revenue), 2) AS revenue
FROM sales
GROUP BY product
ORDER BY revenue DESC;

-- 3. Revenue by region
SELECT region, ROUND(SUM(revenue), 2) AS revenue
FROM sales
GROUP BY region
ORDER BY revenue DESC;

-- 4. Monthly revenue
SELECT substr(order_date, 1, 7) AS month,
       ROUND(SUM(revenue), 2) AS revenue
FROM sales
GROUP BY substr(order_date, 1, 7)
ORDER BY month;

-- 5. Average order value by product
SELECT product, ROUND(AVG(revenue), 2) AS average_order_value
FROM sales
GROUP BY product
ORDER BY average_order_value DESC;

-- 6. Rank products by revenue (window function)
SELECT product, revenue,
       DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM (
    SELECT product, SUM(revenue) AS revenue
    FROM sales
    GROUP BY product
);

-- 7. Running monthly revenue total
WITH monthly AS (
    SELECT substr(order_date, 1, 7) AS month, SUM(revenue) AS revenue
    FROM sales
    GROUP BY substr(order_date, 1, 7)
)
SELECT month, ROUND(revenue, 2) AS revenue,
       ROUND(SUM(revenue) OVER (ORDER BY month), 2) AS running_revenue
FROM monthly
ORDER BY month;
