# 1. oro.dim_customers

* **Propósito:** Almacena los detalles de los clientes enriquecidos con datos demográficos y geográficos.
* **Columnas:**

| Nombre de la Columna | Tipo de Dato | Descripción |
| :--- | :--- | :--- |
| `customer_key` | INT | Clave sustituta (surrogate key) que identifica de manera única cada registro de cliente en la tabla de dimensión. |
| `customer_id` | INT | Identificador numérico único asignado a cada cliente. |
| `customer_number` | NVARCHAR(50) | Identificador alfanumérico que representa al cliente, utilizado para seguimiento y referencia. |
| `first_name` | NVARCHAR(50) | El primer nombre del cliente, tal como está registrado en el sistema. |
| `last_name` | NVARCHAR(50) | El apellido o nombre de familia del cliente. |
| `country` | NVARCHAR(50) | El país de residencia del cliente (ej., 'Australia'). |
| `marital_status` | NVARCHAR(50) | El estado civil del cliente (ej., 'Casado', 'Soltero'). |
| `gender` | NVARCHAR(50) | El género del cliente (ej., 'Masculino', 'Femenino', 'n/a'). |
| `birthdate` | DATE | La fecha de nacimiento del cliente, formateada como AAAA-MM-DD (ej., 1971-10-06). |
| `create_date` | DATE | La fecha y hora en que se creó el registro del cliente en el sistema. |





# 2. gold.dim_products

* **Propósito:** Proporciona información sobre los productos y sus atributos.
* **Columnas:**

| Nombre de la Columna | Tipo de Dato | Descripción |
| :--- | :--- | :--- |
| `product_key` | INT | Clave sustituta (surrogate key) que identifica de manera única cada registro de producto en la tabla de dimensión de productos. |
| `product_id` | INT | Un identificador único asignado al producto para seguimiento interno y referencia. |
| `product_number` | NVARCHAR(50) | Un código alfanumérico estructurado que representa el producto, a menudo utilizado para categorización o inventario. |
| `product_name` | NVARCHAR(50) | Nombre descriptivo del producto, incluyendo detalles clave como tipo, color y tamaño. |
| `category_id` | NVARCHAR(50) | Un identificador único para la categoría del producto, que enlaza con su clasificación de alto nivel. |
| `category` | NVARCHAR(50) | La clasificación más amplia del producto (ej., 'Bikes', 'Components') para agrupar artículos relacionados. |
| `subcategory` | NVARCHAR(50) | Una clasificación más detallada del producto dentro de la categoría, como el tipo de producto. |
| `maintenance_required` | NVARCHAR(50) | Indica si el producto requiere mantenimiento (ej., 'Yes', 'No'). |
| `cost` | INT | El costo o precio base del producto, medido en unidades monetarias. |
| `product_line` | NVARCHAR(50) | La línea o serie de productos específica a la que pertenece el producto (ej., 'Road', 'Mountain'). |
| `start_date` | DATE | La fecha en que el producto estuvo disponible para la venta o uso. |





# 3. gold.fact_sales

* **Propósito:** Almacena datos transaccionales de ventas para fines analíticos.
* **Columnas:**

| Nombre de la Columna | Tipo de Dato | Descripción |
| :--- | :--- | :--- |
| `order_number` | NVARCHAR(50) | Un identificador alfanumérico único para cada orden de venta (ej., 'SO54496'). |
| `product_key` | INT | Clave sustituta (surrogate key) que vincula la orden con la tabla de dimensión de productos. |
| `customer_key` | INT | Clave sustituta (surrogate key) que vincula la orden con la tabla de dimensión de clientes. |
| `order_date` | DATE | La fecha en que se realizó el pedido. |
| `shipping_date` | DATE | La fecha en que el pedido fue enviado al cliente. |
| `due_date` | DATE | La fecha de vencimiento del pago del pedido. |
| `sales_amount` | INT | El valor monetario total de la venta para la línea de producto, en unidades monetarias enteras (ej., 25). |
| `quantity` | INT | El número de unidades del producto solicitadas para la línea de producto (ej., 1). |
| `price` | INT | El precio por unidad del producto para la línea de producto, en unidades monetarias enteras (ej., 25). |
