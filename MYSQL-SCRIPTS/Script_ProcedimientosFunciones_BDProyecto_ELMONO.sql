-- Procedimientos

-- Procedimiento para Asignar Horarios
DROP PROCEDURE IF EXISTS sp_AsignarHorarioEmpleado;
DELIMITER &&
CREATE PROCEDURE sp_AsignarHorarioEmpleado(
    IN empleadoId BIGINT, 
    IN horarioId INT)
BEGIN
    INSERT INTO EMPLEADO_has_HORARIO_EMPLEADO 
        (HORARIO_EMPLEADO_id_horario, EMPLEADO_Id_Empleado)
    VALUES 
        (horarioId, empleadoId);
END &&
DELIMITER ;

-- Procedimiento para crear una factura de compra
DROP PROCEDURE IF EXISTS sp_CrearFacturaCompra;
DELIMITER &&
CREATE PROCEDURE sp_CrearFacturaCompra(
    IN totalPago INT, 
    IN modoEntrega VARCHAR(45), 
    IN metodoPago VARCHAR(25), 
    IN descripcion VARCHAR(80), 
    IN estadoEntrega TINYINT(1), 
    IN proveedorId BIGINT, 
    IN numeroReferencia BIGINT)
BEGIN
    INSERT INTO FACTURA_COMPRA 
        (fac_com_fecha, fac_com_total_pago, fac_com_modo_entrega, fac_com_metodo_pago, fac_com_descripcion, fac_com_estado_entrega, PROVEEDOR_Id_numero_identificacion, DETALLE_METODO_PAGO_numero_referenca)
    VALUES 
        (NOW(), totalPago, modoEntrega, metodoPago, descripcion, estadoEntrega, proveedorId, numeroReferencia);
END&&
DELIMITER ;

-- Procedimiento para registrar un detalle de una factura compra
DROP PROCEDURE IF EXISTS sp_RegistrarDetalleFacturaCompra;
DELIMITER &&
CREATE PROCEDURE sp_RegistrarDetalleFacturaCompra(
    IN facturaCompraId INT, 
    IN productoTiendaId INT, 
    IN cantidad INT, 
    IN precioUnitario INT)
BEGIN
    INSERT INTO DETALLE_FACTURA_COMPRA 
        (FACTURA_COMPRA_Id_FacturaCompra, PRODUCTO_TIENDA_Id_ProductoTienda, det_cantidad, det_precio_unitario)
    VALUES 
        (facturaCompraId, productoTiendaId, cantidad, precioUnitario);
END&&
DELIMITER ;

-- Procedimiento para actualizar los estados de entrega de una factura venta
DROP PROCEDURE IF EXISTS sp_ActualizarEstadoEntregaVenta;
DELIMITER //
CREATE PROCEDURE sp_ActualizarEstadoEntregaVenta(
    IN facturaId BIGINT)
BEGIN
    UPDATE FACTURA_VENTA 
    SET fac_ven_estado_entrega = 1
    WHERE Id_FacturaVenta = facturaId;
END //
DELIMITER ;


-- Procedimiento para actualizar los detalles de un metodo de pago
DROP PROCEDURE IF EXISTS sp_ActualizarMetodoPago;
DELIMITER //
CREATE PROCEDURE sp_ActualizarMetodoPago(
    IN numeroReferencia BIGINT, 
    IN estadoTransaccion VARCHAR(10), 
    IN informacionAdicional VARCHAR(40))
BEGIN
    UPDATE DETALLE_METODO_PAGO 
    SET met_estado_transaccion = estadoTransaccion, 
        met_informacion_adicional = informacionAdicional
    WHERE numero_referencia = numeroReferencia;
END //
DELIMITER ;

-- Procedimiento para registrar un nuevo gasto
DROP PROCEDURE IF EXISTS sp_RegistrarGasto;
DELIMITER &&
CREATE PROCEDURE sp_RegistrarGasto(
    IN modoEntrega VARCHAR(45), 
    IN metodoPago VARCHAR(25), 
    IN descripcion VARCHAR(80), 
    IN estadoEntrega TINYINT(1), 
    IN sucursalId INT, 
    IN totalPago INT)
BEGIN
    INSERT INTO FACTURA_GASTO 
        (fac_gas_fecha, fac_gas_total_pago, fac_gas_modo_entrega, fac_gas_metodo_pago, fac_gas_descripcion, fac_gas_estado_entrega, SUCURSAL_Id_Sucursal)
    VALUES 
        (NOW(), totalPago, modoEntrega, metodoPago, descripcion, estadoEntrega, sucursalId);
END &&
DELIMITER ;

-- Procedimiento para registrar un detalle de una factura gasto
DROP PROCEDURE IF EXISTS sp_RegistrarDetalleFacturaGasto;
DELIMITER &&
CREATE PROCEDURE sp_RegistrarDetalleFacturaGasto(
    IN facturaGastoId INT, 
    IN productoGastoId INT, 
    IN cantidad INT, 
    IN precioUnitario INT)
BEGIN
    INSERT INTO DETALLE_FACTURA_GASTO 
        (FACTURA_GASTO_Id_FacturagASTO, PRODUCTO_GASTO_Id_Producto_Gasto, det_cantidad, det_precio_unitario)
    VALUES 
        (facturaGastoId, productoGastoId, cantidad, precioUnitario);
END &&
DELIMITER ;

-- Procedimiento para registrar una factura venta
DROP PROCEDURE IF EXISTS sp_RegistrarFacturaVenta;
DELIMITER //

CREATE PROCEDURE sp_RegistrarFacturaVenta(
    OUT nuevaFacturaId BIGINT,
    IN totalPago INT,
    IN modoEntrega VARCHAR(45),
    IN metodoPago VARCHAR(25),
    IN descripcion VARCHAR(80),
    IN estadoEntrega TINYINT(1),
    IN clienteId BIGINT,
    IN empleadoId BIGINT
)
BEGIN
    -- Variable local para almacenar el ID generado
    DECLARE lastInsertId BIGINT;

    -- Insertar en la tabla FACTURA_VENTA
    INSERT INTO FACTURA_VENTA (
        fac_ven_fecha,
        fac_ven_total_pago,
        fac_ven_modo_entrega,
        fac_ven_metodo_pago,
        fac_ven_descripcion,
        fac_ven_estado_entrega,
        CLIENTE_id_numero_identificacion,
        EMPLEADO_Id_Empleado
    ) VALUES (
        NOW(),
        totalPago,
        modoEntrega,
        metodoPago,
        descripcion,
        estadoEntrega,
        clienteId,
        empleadoId
    );

    -- Obtener el último ID insertado
    SELECT LAST_INSERT_ID() INTO lastInsertId;

    -- Asignar el valor al parámetro de salida
    SET nuevaFacturaId = lastInsertId;
END //

DELIMITER ;

-- Procedimiento para registrar producto
DROP PROCEDURE IF EXISTS sp_RegistrarDetalleFacturaVenta;
DELIMITER //
CREATE PROCEDURE sp_RegistrarDetalleFacturaVenta(
    IN facturaVentaId INT, 
    IN productoTiendaId INT, 
    IN cantidad INT, 
    IN precioUnitario INT)
BEGIN
    INSERT INTO DETALLE_FACTURA_VENTA 
        (FACTURA_VENTA_Id_FacturaVenta, PRODUCTO_TIENDA_Id_ProductoTienda, det_cantidad, det_precio_unitario)
    VALUES 
        (facturaVentaId, productoTiendaId, cantidad, precioUnitario);
END //
DELIMITER ;

-- Procedimiento para registrar cliente
DROP PROCEDURE IF EXISTS sp_RegistrarCliente;
DELIMITER //
CREATE PROCEDURE sp_RegistrarCliente(
    IN idIdentificacion BIGINT, 
    IN nombre VARCHAR(30), 
    IN apellido VARCHAR(30), 
    IN telefono BIGINT,
    IN direccion VARCHAR(45),
    IN tipo_identificacion VARCHAR(20),
    IN ciudad VARCHAR(45))
BEGIN
    INSERT INTO CLIENTE 
        (id_numero_identificacion, cli_nombre, cli_apellido, cli_telefono,cli_direccion,cli_tipo_identificacion,cli_ciudad)
    VALUES 
        (idIdentificacion, nombre, apellido, telefono, direccion, tipo_identificacion, ciudad);
END //
DELIMITER ;


-- Funciones

-- Calcula el total de una factura, teniendo en cuente que cada factura puede tener mas de un producto
DROP FUNCTION IF EXISTS f_CalcularTotalFactura;
DELIMITER $$
CREATE FUNCTION f_CalcularTotalFactura(facturaId INT) RETURNS INT DETERMINISTIC 
BEGIN
    DECLARE total INT;
    SELECT SUM(det_precio_unitario * det_cantidad) INTO total 
    FROM DETALLE_FACTURA_VENTA 
    WHERE FACTURA_VENTA_Id_FacturaVenta = facturaId;
    RETURN total;
END $$
DELIMITER ;


-- Función para calcular el total de una factura de gasto
DROP FUNCTION IF EXISTS f_CalcularTotalFacturaGasto;
DELIMITER $$
CREATE FUNCTION f_CalcularTotalFacturaGasto(facturaGastoId INT) RETURNS INT DETERMINISTIC 
BEGIN
    DECLARE total INT;
    SELECT SUM(det_precio_unitario * det_cantidad) INTO total 
    FROM DETALLE_FACTURA_GASTO 
    WHERE FACTURA_GASTO_Id_FacturagASTO = facturaGastoId;
    RETURN total;
END $$
DELIMITER ;


-- Función para calcular el total de ventas en un periodo
DROP FUNCTION IF EXISTS f_TotalVentasPeriodo;
DELIMITER //
CREATE FUNCTION f_TotalVentasPeriodo(fechaInicio DATE, fechaFin DATE) 
RETURNS INT 
DETERMINISTIC 
BEGIN
    DECLARE total INT;
    SELECT SUM(fac_ven_total_pago) INTO total 
    FROM FACTURA_VENTA 
    WHERE fac_ven_fecha BETWEEN fechaInicio AND fechaFin;
    RETURN IFNULL(total, 0);
END //
DELIMITER ;


-- Función para contar las ventas en un periodo
DROP FUNCTION IF EXISTS f_ContarFacturasPeriodo;
DELIMITER //
CREATE FUNCTION f_ContarFacturasPeriodo(fechaInicio DATE, fechaFin DATE) 
RETURNS INT 
DETERMINISTIC 
BEGIN
    DECLARE totalFacturas INT;
    SELECT COUNT(*) INTO totalFacturas 
    FROM FACTURA_VENTA 
    WHERE fac_ven_fecha BETWEEN fechaInicio AND fechaFin;
    RETURN totalFacturas;
END //
DELIMITER ;

-- Función para calcular el promedio de valor de factura
DROP FUNCTION IF EXISTS f_PromedioValorFactura;
DELIMITER //
CREATE FUNCTION f_PromedioValorFactura(fechaInicio DATE, fechaFin DATE) RETURNS DECIMAL(10,2) 
DETERMINISTIC 
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(fac_ven_total_pago) INTO promedio 
    FROM FACTURA_VENTA 
    WHERE fac_ven_fecha BETWEEN fechaInicio AND fechaFin;
    RETURN IFNULL(promedio, 0.00);
END //
DELIMITER ;

