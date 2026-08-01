/*
========================================================
DDL Script : creacion de las tablas de la capa de bronce
========================================================
  Script Purpose:
    Este script crea tablas en el esquema 'bronze', eliminando las tablas existentes si ya existen.
    Ejecute este script para redefinir la estructura DDL de las tablas 'bronze'.
========================================================
    
*/

IF OBJECT_ID('capa_bronce.crm_cust_info','U')IS NOT NULL
	DROP TABLE capa_bronce.crm_cust_info;
GO
  
CREATE TABLE capa_bronce.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);
EXEC sp_help  'capa_bronce.crm_cust_info';
EXEC sp_databases;


IF OBJECT_ID('capa_bronce.crm_prd_info','U')IS NOT NULL
	DROP TABLE capa_bronce.crm_prd_info
CREATE TABLE capa_bronce.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR (10),
	prd_start_dt DATE,
	prd_end_dt DATE

);
GO
IF OBJECT_ID ('capa_bronce.crm_sales_details','U') IS NOT NULL
	DROP TABLE capa_bronce.crm_sales_details
CREATE TABLE capa_bronce.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT

);

IF OBJECT_ID ('capa_bronce.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE capa_bronce.erp_cust_az12;
CREATE TABLE capa_bronce.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen  NVARCHAR(50)
);
GO
IF OBJECT_ID('capa_bronce.erp_loc_a101','U')IS NOT NULL
	DROP TABLE capa_bronce.erp_loc_a101
CREATE TABLE capa_bronce.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);
GO
IF OBJECT_ID('capa_bronce.erp_px_cat_g1V2','U')IS NOT NULL
	DROP TABLE capa_bronce.erp_px_cat_g1V2
CREATE TABLE capa_bronce.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);
