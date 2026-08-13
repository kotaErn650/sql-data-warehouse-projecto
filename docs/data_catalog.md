# 1. gold.dim_customers

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
