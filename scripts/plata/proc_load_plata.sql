-- CREATE SCHEMA bronce;
-- GO
-- CREATE SCHEMA palta;
-- GO
-- CREATE SCHEMA oro;
-- GO

/*
===============================================================================
SCRIPT DDL: Crear Tablas Silver
===============================================================================
Propósito del sCRIPT:
    Este Script crea tablas en el esquema 'silver', eliminando las tablas
    existentes si ya existen.
    Ejecute este guion para redefinir la estructura DDL de las Tablas 'bronze'
===============================================================================
*/  


--CREANDO LAS TABLAS DEL CRM
IF OBJECT_ID ('plata.crm_cust_info','U') IS NOT NULL
	DROP TABLE plata.crm_cust_info
CREATE TABLE plata.crm_cust_info(
	cst_id             INT,
	cst_key            NVARCHAR(50),
	cst_firstname      NVARCHAR(50),
	cst_lastname       NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr           NVARCHAR(50),
	cst_create_date    DATE,
	dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO
IF OBJECT_ID ('plata.crm_prd_info') IS NOT NULL 
	DROP TABLE plata.crm_prd_info
CREATE TABLE plata.crm_prd_info(
	prd_id           INT,
	prd_key          NVARCHAR(50),
	prd_nm           NVARCHAR(50),
	prd_cost         NVARCHAR(50),
	prd_line         NVARCHAR(50),
	prd_start_dt     DATE,
	prd_end_dt       DATE,
	dwh_create_date  DATETIME2 DEFAULT GETDATE()
);
IF OBJECT_ID ('plata.crm_sales_details') IS NOT NULL
	DROP TABLE plata.crm_sales_details
CREATE TABLE plata.crm_sales_details(
	sls_ord_num         NVARCHAR(50),
	sls_prd_key         NVARCHAR(50),
	sls_cust_id         INT,
	sls_order_dt        INT,
	sls_ship_dt         INT,
	sls_due_dt          INT,
	sls_sales           INT,
	sls_quantity        INT,
	sls_price           INT,
	dwh_create_date     DATETIME2 DEFAULT GETDATE()
);

--***************ERP*********************

IF OBJECT_ID ('plata.erp_cust_az12','U') IS NOT NULL
	DROP TABLE plata.erp_cust_az12
CREATE TABLE plata.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
IF OBJECT_ID('plata.erp_loc_a101','U')IS NOT NULL
	DROP TABLE plata.erp_loc_a101
CREATE TABLE plata.erp_loc_a101(
	cid             NVARCHAR (50),
	cntry           NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
IF OBJECT_ID('plata.erp_px_cat_g1v2','U')IS NOT NULL
	DROP TABLE plata.erp_px_cat_g1v2
CREATE TABLE plata.erp_px_cat_g1v2(
	id              NVARCHAR(50),
	cat             NVARCHAR(50),
	subcat          NVARCHAR(50),
	maintenance     NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
