/*
This stored procedure loads the data into the tables in the bronze layer. It truncates the tables then loads fresh data when 
run
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [bronze].[load_bronze] AS
BEGIN 
DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_whole DATETIME, @end_time_whole DATETIME;
	BEGIN TRY
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer'
		PRINT '=========================================='
		PRINT '------------------------------------------'
		PRINT 'Loading ERP Tables'
		PRINT '-------------------------------------------'

		SET @start_time_whole = GETDATE();

		SET @start_time= GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM "C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv"
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT '>>Loading duration of erp_px_cat_g1v2 table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

		SET @start_time= GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101
		BULK INSERT bronze.erp_loc_a101
		FROM "C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv"
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT '>>Loading duration of erp_loc_a101 table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

		SET @start_time= GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12
		BULK INSERT bronze.erp_cust_az12
		FROM "C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv"
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT '>>Loading duration of erp_cust_az12 table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

		SET @start_time= GETDATE();
		PRINT '------------------------------------------'
		PRINT 'Loading CRM Tables'
		PRINT '-------------------------------------------'
		TRUNCATE TABLE bronze.crm_sales_details
		BULK INSERT bronze.crm_sales_details
		FROM "C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv"
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT '>>Loading duration of crm_sales_details table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

		SET @start_time= GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info
		BULK INSERT bronze.crm_prd_info
		FROM "C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv"
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT '>>Loading duration of prd_info table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

		SET @start_time= GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info
		BULK INSERT bronze.crm_cust_info
		FROM "C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv"
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT '>>Loading duration of cust_info table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

		SET @end_time_whole = GETDATE();
		PRINT'>>Loading duration of all tables in bronze layer: ' + CAST(DATEDIFF(second, @start_time_whole, @end_time_whole) AS VARCHAR) + 'seconds';
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURRED WHILE LOADING BRONZE LAYER'
		PRINT '=========================================='
		PRINT 'ERROR:' + ERROR_MESSAGE();
		PRINT 'ERROR:' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '=========================================='


	END CATCH
END
