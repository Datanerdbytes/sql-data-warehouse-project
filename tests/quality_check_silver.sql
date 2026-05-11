/*
=============================================================================
Quality Checks

Script Purpose:
	This script peforms various quality checks for data consistency, accuracy,
	and standardization across  the 'silver' schemas .It includes  check for:
	- Null or Duplicates primary Keys.
	- Unwanted spaces in string fields.
	- Data standardization and consistency.
	- Invalid date ranges and orders.
	- Data consistency between related fields.

Usage Notes:
	- Run these checks after loading Silver Layer.
	- Investigate and resolve any descrepancies found during  the checks.
=============================================================================
*/

-- =========================================================================
-- Checking 'silver.crm_cust-info'
-- =========================================================================
-- Check for NULLs or duplicates in Primary Key
-- Expection: No Result
SELECT 
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwanted spaces
-- Expection: No Result
SELECT 
    cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

--CHeck for Nulls or Negative Numbers in prd_cost
-- Expection: No Result
SELECT 
	prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0

-- Data Standardization * Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Check for Invalid Date Orders
SELECT 
	*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

SELECT *
FROM silver.crm_prd_info


--Check for Calculations
SELECT DISTINCT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0  OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

SELECT *
FROM silver.crm_sales_details


-- Identify Out-of-Range Dates
SELECT 
	bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-10' OR bdate > GETDATE()

SELECT DISTINCT 
	gen
FROM silver.erp_cust_az12


SELECT DISTINCT 
	cid,
	COUNT(*)
FROM silver.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL

SELECT distinct
	cntry
FROM silver.erp_loc_a101
ORDER BY cntry



