--Load data into prd_info table in silver layer after fixing the start and end date issue, 
--data normalization and handling nulls 
INSERT INTO silver.crm_prd_info (prd_id, cat_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt)
SELECT
prd_id,
SUBSTRING(prd_key, 1,5) AS cat_id, --extract catergory id
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key, --extract product key
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE TRIM(prd_line) 
	 WHEN 'R' THEN 'Road'
	 WHEN 'M' THEN 'Mountain'
	 WHEN 'S' THEN 'Other Sales'
	 WHEN 'T' THEN 'Touring'
	 ELSE 'n/a'
END AS prd_line,
prd_start_dt,
LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt ASC) AS prd_end_dt
FROM bronze.crm_prd_info
