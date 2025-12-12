
--check data integrity of numerical fields
SELECT 
*
FROM bronze.crm_sales_details
WHERE sls_sales <=0 OR sls_quantity <= 0 OR sls_price <= 0 
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL

--check duplicates
SELECT
s.sls_ord_num,
COUNT(*)
FROM bronze.crm_sales_details s
GROUP BY sls_ord_num
HAVING COUNT(*)>1

INSERT INTO silver.crm_sales_details
(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CONVERT (DATE,
CASE WHEN LEN(sls_order_dt) < 8 THEN NULL
     ELSE CONVERT(VARCHAR, sls_order_dt) END) AS sls_order_dt,
CONVERT (DATE,
CASE WHEN LEN(sls_ship_dt) < 8 THEN NULL
     ELSE CONVERT(VARCHAR, sls_ship_dt) END) AS sls_ship_dt,
CONVERT (DATE,
CASE WHEN LEN(sls_due_dt) < 8 THEN NULL
     ELSE CONVERT(VARCHAR, sls_due_dt) END) AS sls_due_dt,
CASE WHEN sls_sales = 0 OR sls_sales IS NULL THEN sls_price/sls_quantity
	 WHEN sls_sales < 0 THEN sls_sales * (-1)
	 ELSE sls_sales END AS sls_sales,
sls_quantity,
CASE WHEN sls_price = 0 OR sls_price IS NULL THEN sls_sales * sls_quantity
	 WHEN sls_price < 0 THEN sls_price * (-1)
	 ELSE sls_price END AS sls_price 
FROM bronze.crm_sales_details
