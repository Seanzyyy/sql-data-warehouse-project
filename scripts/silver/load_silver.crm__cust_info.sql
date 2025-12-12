/*
This script checks for some data quality issues and cleans up the table from the bronze layer
before moving it to the silver layer
*/
--checking for duplicates
SELECT 
cst_id,
COUNT (*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1;

--chekcing for unwanted spaces
SELECT
cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

--check the value options in a coded column (gender and marital status)
SELECT DISTINCT
cst_marital_status
FROM bronze.crm_cust_info

--insert into silver cust_info table cleaned data 
INSERT INTO silver.crm_cust_info (cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status, cst_gndr, cst_create_date)
SELECT
	cst_id,
	cst_key,
	TRIM(cst_firstname),
	TRIM(cst_lastname),
	CASE WHEN cst_marital_status = 'S' THEN 'Single'
		 WHEN cst_marital_status = 'M' THEN 'Married'
		 ELSE 'n/a'
	END AS cst_marital_status, --normalized marital status to readable format
	CASE WHEN cst_gndr = 'M' THEN 'Male'
		 WHEN cst_gndr = 'F' THEN 'Female'
		 ELSE 'n/a'
	END AS cst_gndr,  --normalized gender to readable format
	cst_create_date
FROM(
SELECT
	*,
	ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag --group records 
FROM bronze.crm_cust_info
)t WHERE flag =1 --select only the most recent record amond duplicates
