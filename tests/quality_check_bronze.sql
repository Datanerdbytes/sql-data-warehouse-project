/*
=============================================================================
Quality Checks

Script Purpose:
	This script peforms various quality checks for data consistency, accuracy,
	and standardization across  the 'bronze' schemas .It includes  check for:
	- Null or Duplicates primary Keys.
	- Unwanted spaces in string fields.
	- Data standardization and consistency.
	- Invalid date ranges and orders.
	- Data consistency between related fields.

Usage Notes:
	- Run these checks after loading Bronze Layer.
	- Investigate and resolve any descrepancies found during  the checks.


=============================================================================
*/

-- Check for NULL or duplicates in Primary Key
-- Expection: No Result
SELECT 
	cst_id,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

SELECT 
	prd_id,
	COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces
-- Expection: No Result
SELECT 
    cst_key
FROM bronze.crm_cust_info
WHERE cst_key != TRIM(cst_key)

SELECT 
	prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--- check for Nulls or Negative Numbers in prd_cost
-- Expection: No Result
SELECT 
	prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0

-- Data Standardization * Consistency 
SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

-- Check for Invalid Date Orders
SELECT 
	prd_id,
	prd_key,
	prd_nm,
	prd_start_dt,
	prd_end_dt,
	LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_dt_test
FROM bronze.crm_prd_info
WHERE prd_key IN('AC-HE-HL-U509-R','AC-HE-HL-U509') 

SELECT
	NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
OR LEN(sls_due_dt) != 8
OR sls_due_dt > 20500101
OR sls_due_dt < 19900101


SELECT 
	*
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
OR sls_order_dt > sls_due_dt

-- Check Data Consistency: Between Sales, Quantity, and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, Zero, or Negative

SELECT DISTINCT
	sls_sales AS old_sls_sales,
	sls_quantity,
	sls_price AS old_sls_price,

	CASE WHEN sls_sales <=0 OR sls_sales IS NULL OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
	END AS new_sls_sales,

	CASE WHEN sls_price <= 0 OR sls_price IS NULL 
		THEN sls_sales / NULLIF(sls_quantity,0)
	ELSE sls_price
	END AS sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0  OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price


SELECT DISTINCT 
    gen,
    CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
        ELSE 'n/a'
    END gen
FROM bronze.erp_cust_az12


-- Data Standardization & Consistency
SELECT DISTINCT 
	cntry AS old_cntry,
	CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		 WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
		 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	ELSE TRIM(cntry)
	END AS cntry
FROM bronze.erp_loc_a101


SELECT 
	*
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR sub_cat != TRIM(sub_cat) OR maintenance != TRIM(maintenance)