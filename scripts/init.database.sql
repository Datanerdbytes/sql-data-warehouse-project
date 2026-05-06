/*
==========================================================
    Create Database and Schemas
==========================================================

Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking it it already exists. 
    If the database exists, it will be dropped and recreated. Additionally, the script sets up three schemas within the 'DataWarehouse' database: 'bronze', 'silver', and 'gold'.


WARNING:
    Running this script will result in the loss of all data in the 'DataWarehouse' database if it already exists, as it will be dropped and recreated. 
    All data in the datbase will be permanently deleted. Proceed with caution and ensure that you have backups of any important data before executing this script.
*/

USE master;
GO


-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO


-- Create schemas: bronze, silver, gold
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO



