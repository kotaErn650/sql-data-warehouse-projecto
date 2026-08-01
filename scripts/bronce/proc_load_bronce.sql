/*
Procedimiento Almacenado: Cargar Capa Bronze (Origen -> Bronze)
  Script Purpose:
    Este procedimiento almacenado carga datos en el esquema 'bronze' desde archivos CSV externos.
    Realiza las siguientes acciones:

    Trunca (vacía) las tablas 'bronze' antes de cargar los datos.
    Utiliza el comando BULK INSERT para cargar datos desde archivos CSV hacia las tablas 'bronze'.

Parameters :
    ninguno (NONE)
    
    Ejemplo de uso:
    EXEC capa_bronce.load_bronce;


*/

CREATE OR ALTER PROCEDURE capa_bronce.load_bronce AS
BEGIN
	DECLARE @all_time DATETIME,@allEnd_time DATETIME, @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
	SET @all_time = GETDATE();
	PRINT'===============================================';
	PRINT'cargarndo la capa de BRONCE';
	PRINT'===============================================';

	PRINT '-----------------------------------------------';
	PRINT 'CARGANDO TABLAS CRM ';
	PRINT '-----------------------------------------------';


	SET @start_time = GETDATE();
	PRINT '>> TRUNCando la tabla crm_cust_info <<';
		TRUNCATE TABLE capa_bronce.crm_cust_info;
	PRINT'>> Insertando los datos a la tabla crm_cust_info <<';
		BULK INSERT capa_bronce.crm_cust_info
		FROM 'C:\Users\kota0\OneDrive\Desktop\Warehouse\sql-data\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2, 
			FIELDTERMINATOR=',',
			TABLOCK
		);
	SET @end_time = GETDATE();
	PRINT'>> Tiempo de carga: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR ) + 'seconds';
	PRINT '******************************************'

	SET @start_time = GETDATE();
	PRINT '>> TRUNCando la tabla crm_prd_info <<';
		TRUNCATE TABLE capa_bronce.crm_prd_info
	PRINT'>> Insertando los datos a la tabla crm_prd_info <<';
		BULK INSERT capa_bronce.crm_prd_info
		FROM 'C:\Users\kota0\OneDrive\Desktop\Warehouse\sql-data\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	SET @end_time = GETDATE();
	PRINT'>> Tiempo de carga: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR ) + 'seconds';
	PRINT '******************************************'

	SET @end_time = GETDATE();
	PRINT '>> TRUNCando la tabla crm_sales_details <<';
		TRUNCATE TABLE capa_bronce.crm_sales_details;
	PRINT'>> Insertando los datos a la tabla crm_sales_details <<';
		BULK INSERT capa_bronce.crm_sales_details
		FROM 'C:\Users\kota0\OneDrive\Desktop\Warehouse\sql-data\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	SET @end_time = GETDATE();
	PRINT'>> Tiempo de carga: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR ) + 'seconds';
	PRINT '******************************************'

	PRINT '-----------------------------------------------';
	PRINT 'CARGANDO TABLAS ERP ';
	PRINT '-----------------------------------------------';

	SET @end_time = GETDATE();
	PRINT '>> TRUNCando la tabla erp_cust_az12 <<';
		TRUNCATE TABLE capa_bronce.erp_cust_az12;
	PRINT'>> Insertando los datos a la tabla erp_cust_az12 <<';
		BULK INSERT capa_bronce.erp_cust_az12
			FROM 'C:\Users\kota0\OneDrive\Desktop\Warehouse\sql-data\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
	SET @end_time = GETDATE();
	PRINT'>> Tiempo de carga: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR ) + 'seconds';
	PRINT '******************************************'

	SET @end_time = GETDATE();
	PRINT '>> TRUNCando la tabla erp_loc_a101 <<';
		TRUNCATE TABLE capa_bronce.erp_loc_a101;
	PRINT'>> Insertando los datos a la tabla erp_loc_a101 <<';
		BULK INSERT capa_broNce.erp_loc_a101
			FROM 'C:\Users\kota0\OneDrive\Desktop\Warehouse\sql-data\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
	SET @end_time = GETDATE();
	PRINT'>> Tiempo de carga: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR ) + 'seconds';
	PRINT '******************************************'

	SET @end_time = GETDATE();
	PRINT '>> TRUNCando la tabla erp_px_cat_g1v2 <<';
		TRUNCATE TABLE capa_bronce.erp_px_cat_g1v2;
	PRINT'>> Insertando los datos a la tabla erp_px_cat_g1v2 <<';
		BULK INSERT capa_bronce.erp_px_cat_g1v2
		FROM 'C:\Users\kota0\OneDrive\Desktop\Warehouse\sql-data\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	SET @end_time = GETDATE();
	PRINT'>> Tiempo de carga: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR ) + 'seconds';
	PRINT '******************************************'


	SET @allEnd_time = GETDATE();
	PRINT'-> TIEMPO DE CARGAR TODOS LOS DATOS : '+ CAST(DATEDIFF(second, @all_time, @allEnd_time)AS NVARCHAR ) + 'seconds';
	END TRY


	BEGIN CATCH
		PRINT '============='
		PRINT 'ERROR DURANTE LA CARGA DE DATOS'
		PRINT 'ERROR: '+ ERROR_MESSAGE()
		PRINT 'ERROR #' + CAST (ERROR_NUMBER() AS NVARCHAR(10))
		PRINT'=============='
	END CATCH

END
