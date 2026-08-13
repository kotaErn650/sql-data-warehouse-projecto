/*
===============================================================================
Control de Calidad (Quality Checks)
===============================================================================
Propósito del Script:
    Este script realiza controles de calidad para validar la integridad, consistencia
    y precisión de la capa oro (oro Layer). Estos controles garantizan:
    - Unicidad de las claves sustitutas (surrogate keys) en las tablas de dimensiones.
    - Integridad referencial entre las tablas de hechos y de dimensiones.
    - Validación de las relaciones en el modelo de datos para fines analíticos.

Notas de Uso:
    - Ejecutar estos controles después del proceso de carga de datos de la capa Silver (Silver Layer).
    - Investigar y resolver cualquier discrepancia encontrada durante las verificaciones.
===============================================================================
*/


SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM oro.dim_customer
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- =============================================================================
-- Verificando 'oro.product_key'
-- =============================================================================
-- Verificar la unicidad de Product Key en oro.dim_products
-- Expectativa: Sin resultados
SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM oro.dim_product
GROUP BY product_key
HAVING COUNT(*) > 1;

-- =============================================================================
-- Verificando 'oro.fact_sales'
-- =============================================================================
-- Verificar la conectividad del modelo de datos entre la tabla de hechos y las dimensiones
SELECT *
FROM oro.fact_sales AS f
LEFT JOIN oro.dim_customer c
    ON c.customer_key = f.customer_key
LEFT JOIN oro.dim_product p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL;
