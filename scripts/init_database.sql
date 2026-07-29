/*
===============================================================================
Create Database and Schemas
===============================================================================
Propósito del script:
Este script crea una nueva base de datos llamada 'DataWarehouse' después de verificar si ya existe.
Si la base de datos existe, se elimina y se vuelve a crear. Además, el script configura tres
esquemas dentro de la base de datos: 'bronze', 'silver' y 'gold'.

WARNING:
Ejecutar este script eliminará toda la base de datos 'DataWarehouse' si existe. 
Todos los datos en la base de datos se borrarán permanentemente. 
Procede con cuidado y asegúrate de tener copias de seguridad antes de ejecutar este script.
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

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
