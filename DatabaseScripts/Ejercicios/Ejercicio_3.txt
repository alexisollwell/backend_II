**Objetivo:** Crear un procedimiento almacenado `sp_CreateOrder`.
* **Parámetros de Entrada:** 
  * `@UserId INT`
  * `@ProductId INT`
  * `@Quantity INT`
* **Comportamiento Esperado:**
  1. Verificar si hay stock suficiente en `Products`. Si no hay (`StockQuantity < @Quantity`), lanzar un error o retornar un estatus de fallo.
  2. Si hay stock:
     * Insertar el registro en la tabla `Orders` (calculando el total a partir del precio del producto * @Quantity).
     * Obtener el `OrderId` generado (usar `SCOPE_IDENTITY()`).
     * Insertar en `OrderDetails`.
     * **Descontar** la cantidad del stock en la tabla `Products` (`UPDATE Products SET StockQuantity = StockQuantity - @Quantity`).