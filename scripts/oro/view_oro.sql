/*
===============================================================================
Script DDL: Crear Vistas Gold (Gold Views)
===============================================================================
Propósito del Script:
    Este script crea vistas para la capa Gold en el almacén de datos (data warehouse).
    La capa Gold representa las tablas finales de dimensiones y hechos (Esquema en Estrella).

    Cada vista realiza transformaciones y combina datos de la capa Silver
    para producir un conjunto de datos limpio, enriquecido y listo para el negocio.

Uso:
    - Estas vistas se pueden consultar directamente para analítica y reportes.
===============================================================================
*/

IF OBJECT_ID('oro.dim_product','V') IS NOT NULL
	DROP VIEW oro.dim_product;
GO
CREATE VIEW oro.dim_product AS
SELECT
ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
	pn.cat_id AS category_id,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pc.maintenance,
	pn.prd_cost AS cost,
	pn.prd_line product_line,
	pn.prd_start_dt AS start_date
FROM plata.crm_prd_info pn
LEFT JOIN plata.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL 
GO
/*==============================================================================
			Vista customer
================================================================================*/
IF OBJECT_ID ('oro.dim_customer','V') IS NOT NULL
	DROP VIEW oro.dim_customer;
GO
CREATE VIEW oro.dim_customer AS /* <- Creacion de la vista carga todo lo que esta en la sentencia*/
SELECT 
	-- aqui numeramos cada fila y la ordenamos por fecha de creacion
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	ci.cst_marital_status status_civil,
	CASE WHEN ci.cst_gndr!= 'N/A' THEN ci.cst_gndr --CRM sera nuestro dato Maestro a prevalecer
		 ELSE COALESCE(ca.gen, 'N/A')
	END gender,
	ca.bdate AS birthdate,
	la.cntry AS country,
	ci.cst_create_date AS create_date


FROM plata.crm_cust_info AS ci
LEFT JOIN plata.erp_cust_az12 AS ca
ON		ci.cst_key = ca.cid
LEFT JOIN plata.erp_loc_a101 AS la
ON		ci.cst_key = la.cid
GO
/*==============================================================================
			CREATE FACTO TABLA: Oro.fact_sales
================================================================================*/
-- =============================================================================
-- Crear Tabla de Hechos: gold.fact_sales
-- =============================================================================

IF OBJECT_ID('oro.fact_sales','V') IS NOT NULL
    DROP VIEW oro.fact_sales;
GO
CREATE VIEW oro.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,          
    sd.sls_due_dt   AS due_date,   
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM plata.crm_sales_details sd
LEFT JOIN oro.dim_product pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN oro.dim_customer cu
    ON sd.sls_cust_id = cu.customer_id;
