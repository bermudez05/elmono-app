-- Creamos los roles,usuarios y asignamos permisos a procedimientos

-- Gerente
CREATE ROLE gerente;

GRANT CREATE, SELECT ON bd_proyecto_tienda.* TO gerente;
GRANT UPDATE ON bd_proyecto_tienda.cliente TO gerente;
GRANT UPDATE ON bd_proyecto_tienda.proveedor TO gerente;

-- Tendero
CREATE ROLE tendero;

GRANT CREATE, SELECT, UPDATE ON bd_proyecto_tienda.cliente TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.detalle_factura_gasto TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.detalle_factura_venta TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.detalle_metodo_pago TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.factura_gasto TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.factura_venta TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.lote TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.producto_gasto TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.producto_tienda TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.proveedor TO tendero;
GRANT SELECT ON bd_proyecto_tienda.sucursal TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.transferencia_bancaria TO tendero;
GRANT CREATE, SELECT ON bd_proyecto_tienda.transferencia_movil TO tendero;

-- Domiciliario
CREATE ROLE domiciliario;

GRANT SELECT ON bd_proyecto_tienda.cliente TO domiciliario;
GRANT SELECT ON bd_proyecto_tienda.detalle_factura_venta TO domiciliario;
GRANT SELECT, UPDATE ON bd_proyecto_tienda.detalle_metodo_pago TO domiciliario;
GRANT SELECT, UPDATE ON bd_proyecto_tienda.factura_venta TO domiciliario;
GRANT SELECT ON bd_proyecto_tienda.producto_tienda TO domiciliario;
GRANT SELECT ON bd_proyecto_tienda.transferencia_bancaria TO domiciliario;
GRANT SELECT ON bd_proyecto_tienda.transferencia_movil TO domiciliario;

-- A cada rol le asociamos un usuario
-- Creamos el usuario 
CREATE USER  "gerente"@"localhost" IDENTIFIED BY "GerenteMono_2017";
GRANT gerente TO 'gerente'@'localhost';
DROP USER 'gerente'@'%';

CREATE USER  "tendero"@"localhost" IDENTIFIED BY "TenderoMono_2017";
GRANT tendero TO 'tendero'@'localhost';
DROP USER 'tendero'@'%';

CREATE USER  "domiciliario"@"localhost" IDENTIFIED BY "DomiciliarioMono_2017";
GRANT domiciliario TO 'domiciliario'@'localhost';
DROP USER 'domiciliario'@'%';

SELECT user, host FROM mysql.user;

-- Asignacion procedimientos a los usuarios/roles creados
-- Tener en cuenta que tenemos los siquientes usuarios:gerente, tendero y domiciliario
grant execute on procedure sp_AsignarHorarioEmpleado to "gerente"@"localhost";
grant execute on procedure sp_CrearFacturaCompra to "gerente"@"localhost";
grant execute on procedure sp_RegistrarDetalleFacturaCompra to "gerente"@"localhost";
grant execute on procedure sp_RegistrarGasto to "gerente"@"localhost";
grant execute on procedure sp_RegistrarDetalleFacturaGasto to "gerente"@"localhost";

grant execute on procedure sp_RegistrarFacturaVenta to "tendero"@"localhost";
grant execute on procedure sp_ActualizarEstadoEntregaVenta to "tendero"@"localhost";
grant execute on procedure SP_RegistrarFacturaVenta to "tendero"@"localhost";
grant execute on procedure sp_RegistrarDetalleFacturaVenta to "tendero"@"localhost";
grant execute on procedure sp_ActualizarMetodoPago to "tendero"@"localhost";
grant execute on procedure sp_RegistrarCliente to "tendero"@"localhost";