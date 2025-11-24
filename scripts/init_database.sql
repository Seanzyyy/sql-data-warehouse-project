/*
	This code checks the master database if a database called datawarehouse exists
	if it does it drops it then afterwards a database called datawarehouse is created 
	and 3 schemas for it called bronze, silver and gold are created
*/
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse
GO
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
