-- =============================================
-- Check quality for gold.dim_customers 
-- =============================================
-- check gender
SELECT DISTINCT gender FROM gold.dim_customers


-- check for duplicates and NULLs in primary key
SELECT 
    customer_id,
    COUNT(*)
FROM gold.dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1


-- =============================================
-- Check quality for gold.fact_sales
-- =============================================
-- Foreign Key Integrity (Dimensions)
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
WHERE p.product_key IS NULL




-- Check if all dimension tables can successfully join  to the fact table


