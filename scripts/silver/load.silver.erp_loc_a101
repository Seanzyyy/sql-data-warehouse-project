INSERT INTO silver.erp_loc_a101
(
cid,
cntry
)
SELECT
REPLACE(cid, '-', '') AS cid,
CASE WHEN TRIM(cntry) = 'USA' OR cntry = 'US' THEN 'United States'
	 WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) = '' THEN NULL
	 ELSE cntry END AS cntry
FROM bronze.erp_loc_a101
