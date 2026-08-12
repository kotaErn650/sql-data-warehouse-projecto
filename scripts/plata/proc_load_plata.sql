
	print('>> 1) Insertando Datos Into: plata.crm_cust_info')
	INSERT INTO plata.crm_cust_info(
		cst_id,
		cst_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gndr,
		cst_create_date

	)
	SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname)AS cst_lastname,
	CASE WHEN cst_marital_status = 'M' THEN 'MATRIMONIO'
		 WHEN cst_marital_status = 'S' THEN 'SOLTER@'
		 ELSE 'N/A'
	END AS cst_marital_status,
	CASE WHEN cst_gndr = 'F' THEN 'MUJER'
		 WHEN cst_gndr = 'M' THEN 'HOMBRE'
		 ELSE 'N/A'
	END AS cst_gndr,
/*
===============================================================================
Procedimiento Almacenado: Cargar Capa Silver (Bronze -> Silver)
===============================================================================
Propósito del Guion:
    Este procedimiento almacenado realiza el proceso ETL (Extracción, Transformación, Carga) para
    poblar las tablas del esquema 'silver' desde el esquema 'bronze'.
    Acciones Realizadas:
    - Trunca las tablas Silver.
    - Inserta los datos transformados y depurados de Bronze en las tablas Silver.

Parámetros:
    Ninguno.
    Este procedimiento almacenado no acepta parámetros ni devuelve valores.

Ejemplo de Uso:
    EXEC Silver.load_silver;
===============================================================================
*/
	cst_create_date
	FROM(
		SELECT*,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC)AS can_dupli
		FROM bronce.crm_cust_info
		WHERE cst_id IS NOT NULL
	)T
	WHERE can_dupli =1

	-- ************************************
	print('**Truncando tabla **')
	TRUNCATE TABLE plata.crm_prd_info
	print('>> 2) Insertando Datos Into: plata.crm_prd_info')

	INSERT INTO plata.crm_prd_info (
		prd_id ,
		cat_id ,
		prd_key ,
		prd_nm ,
		prd_cost ,
		prd_line ,
		prd_start_dt,
		prd_end_dt
	)

	SELECT
	prd_id,
	REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
	SUBSTRING(prd_key,7, LEN(prd_key)) AS prd_key,
	prd_nm,
	ISNULL(prd_cost, 0) AS prd_cost,
	CASE TRIM(UPPER(prd_line))
		WHEN 'M' THEN 'Mountain'
		WHEN 'R' THEN 'Road'
		WHEN 'S' THEN 'Sport'
		WHEN 'T' THEN 'Touring'
	END AS prd_line,
	CAST(prd_start_dt AS DATE) AS prd_start_dt,
	DATEADD(DAY, -1, LEAD(prd_start_dt)OVER (PARTITION BY prd_key ORDER BY prd_start_dt))AS prd_end_dt
	FROM bronce.crm_prd_info
	-- ***************************************************
	print('**Truncando tabla **')
	TRUNCATE TABLE plata.crm_sales_details
	print('>> 3) Insertando Datos Into: plata.crm_sales_details')
	INSERT INTO plata.crm_sales_details(
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
	CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt)!=8 THEN NULL
		 ELSE CAST(CAST(sls_order_dt AS varchar) AS DATE)
	END sls_order_dt,
	CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt)!=8 THEN NULL
		 ELSE CAST(CAST(sls_ship_dt AS varchar) AS DATE)
	END sls_ship_dt,
	CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt)!=8 THEN NULL
		 ELSE CAST(CAST(sls_due_dt AS varchar) AS DATE)
	END sls_due_dt,
	sls_quantity,
	CASE WHEN sls_sales IS NULL OR sls_sales<=0 OR sls_sales != sls_quantity * ABS(sls_price)
		 THEN sls_quantity *ABS(sls_price)
		 ELSE sls_sales
	END sls_sales,
	CASE WHEN sls_price IS NULL OR sls_price <=0
		 THEN sls_sales / NULLIF(sls_quantity, 0)
		 ELSE sls_price
	END sls_price
	FROM bronce.crm_sales_details
	-- ERP *****************************************
	print('**Truncando tabla **')
	TRUNCATE TABLE plata.erp_px_cat_g1v2
	print('>> 4) Insertando Datos Into: plata.erp_px_cat_g1v2')
	INSERT INTO plata.erp_px_cat_g1v2(
		id,
		cat,
		subcat,
		maintenance
	)
	SELECT 
	id,
	cat,
	subcat,
	maintenance
	FROM bronce.erp_px_cat_g1v2
	-- **********************************************
	print('**Truncando tabla **')
	TRUNCATE TABLE plata.erp_loc_a101
	print('>> 5) Insertando Datos Into: plata.erp_loc_a101')
	INSERT INTO plata.erp_loc_a101(
		cid,
		cntry
	)
	SELECT
		REPLACE(cid, '-','')AS cid,

		CASE WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
			 WHEN TRIM(cntry) IN ('DE') THEN 'Germany'
			 WHEN TRIM(cntry) IN ('') OR cntry IS NULL THEN 'N/A'
		ELSE TRIM(cntry)
		END AS cntrya
	FROM bronce.erp_loc_a101;
	-- **********************************************
	print('**Truncando tabla **')
	TRUNCATE TABLE plata.erp_cust_az12
	print('>> 6) Insertando Datos Into: plata.erp_cust_az12')
	INSERT INTO plata.erp_cust_az12(
		cid,
		bdate,
		gen
	)
	SELECT 
	CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4,LEN(cid))
		 ELSE cid
	END cid,
	CASE WHEN bdate > GETDATE() THEN NULL
		 ELSE bdate
	END bdate,
	CASE WHEN TRIM(UPPER(gen)) IN ('F','FEMALE') THEN 'Mujer'
		 WHEN TRIM(UPPER(gen)) IN ('M','MALE') THEN 'Hombre'
		 ELSE 'N/A'
	END gen
	FROM bronce.erp_cust_az12
END
-- FIN DEL PRODCEDURE
