# Sistema de Auditoría de Precios con Triggers (SQL) 

## Descripción
Este proyecto implementa un sistema de seguridad y trazabilidad de datos para un entorno minorista. El objetivo principal es monitorear cambios críticos en la información sensible (precios), registrando automáticamente **quién**, **cuándo** y **qué** modificó, sin depender de la intervención del usuario.

## Características Técnicas Destacadas
* **Database Triggers:** Implementación de disparadores `AFTER UPDATE` para capturar eventos de modificación en tiempo real.
* **Tablas Virtuales:** Uso de `INSERTED` y `DELETED` para comparar los valores previos y posteriores a la transacción.
* **Tablas de Auditoría (Logs):** Diseño de una estructura histórica inmutable para el almacenamiento de registros de seguridad.
* **Manejo de Zonas Horarias:** Normalización de fechas utilizando funciones como `DATEADD` para estandarizar registros de tiempo (Timezones) en reportes.
* **Integridad de Datos:** Uso de columnas `IDENTITY` para la autogeneración de IDs de seguimiento.

## Estructura del Proyecto
1.  **Productos_Premium:** Tabla maestra transaccional (Catálogo de productos).
2.  **Historial_Precios:** Tabla de log (Auditoría) que se llena automáticamente.
3.  **TRG_Auditoria_Precios:** El trigger que actúa como "espía" del sistema.

## Cómo probar este proyecto
1.  Ejecuta el script `Script_Auditoria_Precios.sql` en SQL Server.
2.  Realiza un `UPDATE` manual en cualquier precio de la tabla de productos.
3.  Consulta la tabla `HISTORIAL_PRECIOS` y verás que el cambio se registró mágicamente con tu usuario y la fecha exacta.
