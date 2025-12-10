--Inserts cleaned data from the bronze category info table to its respective silver table
INSERT INTO silver.erp_px_cat_g1v2
(
	id,
	cat,
	subcat,
	maintenance
)
SELECT
REPLACE(id, '_', '-') AS id,
cat,
subcat,
maintainence
FROM bronze.erp_px_cat_g1v2
