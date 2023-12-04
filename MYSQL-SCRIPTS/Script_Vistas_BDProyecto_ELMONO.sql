-- Creacion de vistas 

-- Informacion de los productos existentes en la sucursal 1
DROP VIEW IF EXISTS vw_productos_existentes;
CREATE VIEW vw_productos_existentes AS
select Id_ProductoTienda,SUCURSAL_Id_Sucursal,pro_nombre,pro_precio_Unitario,lot_cantidad,pro_descripcion 
from PRODUCTO_TIENDA join LOTE ON (PRODUCTO_TIENDA_Id_ProductoTienda = Id_ProductoTienda) 
where SUCURSAL_Id_Sucursal=1;

-- Facturas de ventas registradas
DROP VIEW IF EXISTS vw_facturas_ventas_registradas;
CREATE VIEW vw_facturas_ventas_registradas AS
SELECT * FROM factura_venta 
JOIN detalle_factura_venta ON (Id_FacturaVenta = FACTURA_VENTA_Id_FacturaVenta) 
JOIN producto_tienda ON (PRODUCTO_TIENDA_Id_ProductoTienda = Id_ProductoTienda)
LEFT JOIN detalle_metodo_pago ON (numero_referencia = DETALLE_METODO_PAGO_numero_referencia)
JOIN cliente ON (id_numero_identificacion = CLIENTE_id_numero_identificacion);

-- Saldo inicial
DROP VIEW IF EXISTS saldo_inicial;
CREATE VIEW saldo_inicial AS
SELECT PRODUCTO_TIENDA_Id_ProductoTienda AS ID_Producto, lot_cantidad AS Cantidad
FROM lote;

-- Invetario movimiento
DROP VIEW IF EXISTS inventario;
CREATE VIEW inventario AS
SELECT ID_Producto, Cantidad
FROM saldo_inicial
UNION 
SELECT ID_Producto, Cantidad
FROM entradas_inventario
UNION 
SELECT ID_Producto, Cantidad
FROM salidas_inventario;

-- 4) Inventario actual
DROP VIEW IF EXISTS inventario_actual;
CREATE VIEW inventario_actual AS
SELECT ID_Producto, pro_nombre AS Producto, SUM(Cantidad) AS Cantidad
FROM inventario LEFT JOIN producto_tienda ON inventario.ID_Producto=producto_tienda.Id_ProductoTienda
GROUP BY ID_Producto
ORDER BY ID_Producto;

-- Salidas de inventario 
DROP VIEW IF EXISTS salidas_inventario;
CREATE VIEW salidas_inventario AS
SELECT PRODUCTO_TIENDA_Id_ProductoTienda AS ID_Producto, (-det_cantidad) AS Cantidad
FROM detalle_factura_venta;

-- Entradas de inventario 
DROP VIEW IF EXISTS entradas_inventario;
CREATE VIEW entradas_inventario AS
SELECT PRODUCTO_TIENDA_Id_ProductoTienda AS ID_Producto, det_cantidad AS Cantidad
FROM detalle_factura_venta;

-- Vista que contiene a los clientes registrados 
DROP VIEW IF EXISTS vw_clientes_registrados;
CREATE VIEW vw_clientes_registrados AS
SELECT * FROM cliente;

-- Vista que contiene a los proveedores registrados
DROP VIEW IF EXISTS vw_proveedores_registrados;
CREATE VIEW vw_proveedores_registrados AS SELECT * FROM proveedor;

-- Vista que contiene los productos tipo gasto 
DROP VIEW IF EXISTS vw_productos_gasto_registrados;
CREATE VIEW vw_productos_gasto_registrados AS SELECT * FROM producto_gasto;

-- Vista que contiene la informacion de la sucursal 1
DROP VIEW IF EXISTS vw_info_sucursal_1;
CREATE VIEW vw_info_sucursal_1 AS SELECT * FROM SUCURSAL where Id_sucursal=1;
