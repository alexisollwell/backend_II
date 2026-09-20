## Actividad 2: Validación de Integraciones
**Objetivo:** Crear un procedimiento almacenado `sp_ValidateApiKey`.
* **Parámetros de Entrada:** `@KeyValue UNIQUEIDENTIFIER`
* **Comportamiento:**
  * Validar si existe una API Key activa con ese valor.
  * Si existe y está activa (`IsActive = 1`), retornar el nombre de la Key (`KeyName`) y un flag de éxito
  * Si no existe, retornar un resultado indicando que no es válida.