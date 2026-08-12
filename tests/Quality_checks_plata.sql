/*
===============================================================================
Control de Calidad (Quality Checks)
===============================================================================
Propósito del Scripts:
    Este Scripts realiza varias comprobaciones de calidad para la consistencia,
    precisión y estandarización de los datos en los esquemas 'silver'. Incluye verificaciones de:
    - Claves primarias nulas o duplicadas.
    - Espacios no deseados en campos de texto (string).
    - Estandarización y consistencia de datos.
    - Rangos y órdenes de fechas no válidos.
    - Consistencia de datos entre campos relacionados.

Notas de Uso:
    - Ejecute estas verificaciones después de cargar los datos en la Capa Silver (Silver Layer).
    - Investigue y resuelva cualquier discrepancia encontrada durante las comprobaciones.
===============================================================================
*/


SELECT 
  cst_id
  COUNT(*)
FROM plata.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) >1 OR cst_id IS NULL

-- DEMAS CONSULTAS DE VALIDACION POR TABLAS 
