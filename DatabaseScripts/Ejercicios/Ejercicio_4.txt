**Objetivo:** Crear un procedimiento almacenado `sp_GetUserForLogin`.
* **Parámetros de Entrada:** `@Username NVARCHAR(50)`
* **Comportamiento:** 
  * Obtener el `UserId`, `PasswordHash` y `Role` de la tabla `Users`.