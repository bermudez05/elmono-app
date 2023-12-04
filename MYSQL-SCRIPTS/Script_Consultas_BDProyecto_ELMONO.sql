-- Consultas realizadas para la base de datos del Proyecto
USE bd_proyecto_tienda;

-- Gerente

-- 1) Ventas del día agrupadas por métodos de pago
SELECT fac_ven_fecha AS Fecha, fac_ven_metodo_pago AS Metodo_de_Pago, SUM(fac_ven_total_pago) AS Venta_Total
FROM factura_venta
WHERE fac_ven_fecha = CURDATE()
GROUP BY fac_ven_fecha, fac_ven_metodo_pago;

-- 2) Ventas del día agrupadas por vendedor
SELECT fac_ven_fecha AS Fecha, EMPLEADO_Id_Empleado AS Vendedor, SUM(fac_ven_total_pago) AS Venta_Total
FROM factura_venta LEFT JOIN empleado ON factura_venta.EMPLEADO_Id_Empleado=empleado.Id_Empleado
WHERE fac_ven_fecha = CURDATE()
GROUP BY fac_ven_fecha, EMPLEADO_Id_Empleado;

-- 3) Ventas del mes actual por días
SELECT fac_ven_fecha AS Fecha, SUM(fac_ven_total_pago) AS Venta_Total
FROM factura_venta
WHERE MONTH(fac_ven_fecha) = MONTH(NOW())
GROUP BY fac_ven_fecha;

-- 5) Listado de clientes según sus compras del mes actual
SELECT id_numero_identificacion AS ID_Cliente, cli_nombre AS Nombre, cli_apellido AS Apellido, SUM(fac_ven_total_pago) AS Valor_ventas
FROM factura_venta LEFT JOIN cliente ON factura_venta.CLIENTE_id_numero_identificacion=cliente.id_numero_identificacion
WHERE MONTH(fac_ven_fecha) = MONTH(NOW())
GROUP BY id_numero_identificacion;

-- 6) Resumen de ventas realizadas 
DROP VIEW IF EXISTS ventas;
CREATE VIEW ventas AS
SELECT fac_ven_fecha AS Fecha, Id_FacturaVenta AS ID_Factura, Id_ProductoTienda AS ID_Producto, pro_nombre AS Nombre_Producto, det_cantidad AS Cantidad, det_precio_unitario AS Precio_Unitario, (det_cantidad * det_precio_unitario) AS Precio_Total
FROM detalle_factura_venta LEFT JOIN factura_venta ON detalle_factura_venta.FACTURA_VENTA_Id_FacturaVenta=factura_venta.Id_FacturaVenta LEFT JOIN producto_tienda ON detalle_factura_venta.PRODUCTO_TIENDA_Id_ProductoTienda=producto_tienda.Id_ProductoTienda
ORDER BY fac_ven_fecha;

-- 7) Compras realizadas
DROP VIEW IF EXISTS compras;
CREATE VIEW compras AS
SELECT fac_com_fecha AS Fecha, Id_FacturaCompra AS ID_Factura, Id_ProductoTienda AS ID_Producto, pro_nombre AS Nombre_Producto, det_cantidad AS Cantidad, det_precio_unitario
FROM detalle_factura_compra LEFT JOIN factura_compra ON detalle_factura_compra.FACTURA_COMPRA_Id_FacturaCompra=factura_compra.Id_FacturaCompra LEFT JOIN producto_tienda ON detalle_factura_compra.PRODUCTO_TIENDA_Id_ProductoTienda=producto_tienda.Id_ProductoTienda
ORDER BY fac_com_fecha;

-- 8) PyG del mes
SELECT Tipo, SUM(movimiento) AS total_movimiento
FROM (
    SELECT "Ingreso" AS Tipo, fac_ven_total_pago AS movimiento FROM factura_venta
    UNION 
    SELECT "Costo" AS Tipo, (-fac_com_total_pago) AS movimiento FROM factura_compra
    UNION 
    SELECT "Gasto" AS Tipo, (-fac_gas_total_pago) AS movimiento FROM factura_gasto
) AS subconsulta
GROUP BY Tipo;

-- 9) Gastos del mes
SELECT 
    Id_Producto_Gasto AS ID_Gasto, 
    pro_nombre AS Gasto, 
    SUM(det_cantidad) AS Cantidad, 
    det_precio_unitario AS Precio_Unitario, 
    SUM(det_cantidad * det_precio_unitario) AS Precio_Total
FROM detalle_factura_gasto 
LEFT JOIN producto_gasto ON detalle_factura_gasto.PRODUCTO_GASTO_Id_Producto_Gasto = producto_gasto.Id_Producto_Gasto 
LEFT JOIN factura_gasto ON detalle_factura_gasto.FACTURA_GASTO_Id_FacturaGASTO = factura_gasto.Id_Facturagasto
WHERE MONTH(fac_gas_fecha) = MONTH(NOW())
GROUP BY ID_Gasto, Gasto, Precio_Unitario;

-- 10) Efectivo y Bancos
SELECT Método, SUM(movimiento) AS total_movimiento
FROM (
    SELECT fac_ven_metodo_pago AS Método, fac_ven_total_pago AS movimiento FROM factura_venta
    UNION 
    SELECT fac_com_metodo_pago AS Método, (-fac_com_total_pago) AS movimiento FROM factura_compra
    UNION 
    SELECT fac_gas_metodo_pago AS Método, (-fac_gas_total_pago) AS movimiento FROM factura_gasto
) AS subconsulta
GROUP BY Método;

-- Tendero

-- 1) Datos del cliente
SELECT *
FROM cliente
WHERE id_numero_identificacion=1012345678;

-- 2) Compras del cliente
SELECT CONCAT(cli_nombre," ",cli_apellido) AS Cliente, 
	fac_ven_fecha AS Fecha, 
    pro_nombre AS Producto,
    det_cantidad AS Cantidad,
    det_precio_unitario AS Valor_Unitario,
    (det_cantidad*det_precio_unitario) AS Valor_Total
FROM cliente LEFT JOIN factura_venta ON CLIENTE_id_numero_identificacion=id_numero_identificacion 
	LEFT JOIN detalle_factura_venta ON FACTURA_VENTA_Id_FacturaVenta=Id_FacturaVenta
    LEFT JOIN producto_tienda ON PRODUCTO_TIENDA_Id_ProductoTienda=Id_ProductoTienda
WHERE id_numero_identificacion=1012345678;

-- 3) Ventas totales del día
SELECT fac_ven_fecha AS Fecha, EMPLEADO_Id_Empleado AS Vendedor, SUM(fac_ven_total_pago) AS Venta_Total
FROM factura_venta LEFT JOIN empleado ON factura_venta.EMPLEADO_Id_Empleado=empleado.Id_Empleado
WHERE fac_ven_fecha = CURDATE() AND Id_Empleado=1000000001
GROUP BY fac_ven_fecha, EMPLEADO_Id_Empleado;

-- 4) Cierre del día
SELECT fac_ven_fecha AS Fecha, 
	EMPLEADO_Id_Empleado AS Vendedor, 
    fac_ven_metodo_pago AS Método_Pago,
    SUM(fac_ven_total_pago) AS Venta_Total
FROM factura_venta LEFT JOIN empleado ON factura_venta.EMPLEADO_Id_Empleado=empleado.Id_Empleado
WHERE fac_ven_fecha = CURDATE() AND Id_Empleado=1000000001
GROUP BY fac_ven_fecha, EMPLEADO_Id_Empleado, fac_ven_metodo_pago;

-- 5)  Última venta realizada por el vendedor
SELECT fac_ven_fecha AS Fecha, 
	Id_FacturaVenta AS ID_Factura, 
    EMPLEADO_Id_Empleado AS Vendedor, 
    CLIENTE_id_numero_identificacion AS ID_Cliente,
    pro_nombre AS Producto,
    fac_ven_metodo_pago AS Método_Pago,
    det_cantidad AS Cantidad,
    det_precio_unitario AS Valor_Unitario,
    (det_cantidad*det_precio_unitario) AS Valor_Total    
FROM factura_venta 
	LEFT JOIN empleado ON factura_venta.EMPLEADO_Id_Empleado = empleado.Id_Empleado
	LEFT JOIN detalle_factura_venta ON FACTURA_VENTA_Id_FacturaVenta=Id_FacturaVenta
    LEFT JOIN cliente ON CLIENTE_id_numero_identificacion=id_numero_identificacion 
    LEFT JOIN producto_tienda ON PRODUCTO_TIENDA_Id_ProductoTienda=Id_ProductoTienda
WHERE EMPLEADO_Id_Empleado = 1000000001
    AND fac_ven_fecha = CURDATE()
ORDER BY fac_ven_fecha DESC
LIMIT 1;

-- Domiciliario

-- 1) Historial de Domincilios
SELECT Id_FacturaVenta AS ID_Factura,
	CONCAT(cli_nombre," ",IFNULL(cli_apellido, ' ')) AS Cliente, 
    fac_ven_metodo_pago AS Método_Pago,
    DETALLE_METODO_PAGO_numero_referencia AS Detalle_Método_Pago,
    fac_ven_total_pago AS Total_Pago,
    met_estado_transaccion AS Estado_Transacción,
    met_informacion_adicional AS Info_Adicional,
	fac_ven_estado_entrega AS Estado_entrega
FROM factura_venta LEFT JOIN cliente ON CLIENTE_id_numero_identificacion=id_numero_identificacion
	LEFT JOIN detalle_metodo_pago ON DETALLE_METODO_PAGO_numero_referencia=numero_referencia
WHERE fac_ven_modo_entrega="Domicilio" 
ORDER BY Id_FacturaVenta;

-- 2) Domilicios pendientes de entregar
SELECT Id_FacturaVenta AS ID_Factura,
	CONCAT(cli_nombre," ", IFNULL(cli_apellido, ' ')) AS Cliente, 
    -- cli_nombre AS Cliente, 
    fac_ven_metodo_pago AS Método_Pago,
    DETALLE_METODO_PAGO_numero_referencia AS Detalle_Método_Pago,
    fac_ven_total_pago AS Total_Pago,
    met_estado_transaccion AS Estado_Transacción,
    met_informacion_adicional AS Info_Adicional,
    fac_ven_estado_entrega AS Estado_entrega
FROM factura_venta LEFT JOIN cliente ON CLIENTE_id_numero_identificacion=id_numero_identificacion
	LEFT JOIN detalle_metodo_pago ON DETALLE_METODO_PAGO_numero_referencia=numero_referencia
WHERE fac_ven_modo_entrega="Domicilio" AND fac_ven_estado_entrega=1
ORDER BY Id_FacturaVenta;

-- 3) Cierre del día
SELECT fac_ven_fecha AS Fecha, 
	EMPLEADO_Id_Empleado AS Domiciliario, 
    SUM(fac_ven_total_pago) AS Venta_Total
FROM factura_venta LEFT JOIN empleado ON factura_venta.EMPLEADO_Id_Empleado=empleado.Id_Empleado
WHERE fac_ven_fecha = CURDATE() AND Id_Empleado=1000000003 AND fac_ven_metodo_pago="Efectivo"
GROUP BY fac_ven_fecha, EMPLEADO_Id_Empleado;


