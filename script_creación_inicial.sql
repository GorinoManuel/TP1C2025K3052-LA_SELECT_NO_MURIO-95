USE GD1C2025
GO

------Eliminamos las tablas ya creadas ---------

IF EXISTS (SELECT name FROM sys.tables WHERE name='envio')
DROP TABLE LA_SELECT_NO_MURIO.envio
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='detalle_factura')
DROP TABLE LA_SELECT_NO_MURIO.detalle_factura
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='factura')
DROP TABLE LA_SELECT_NO_MURIO.factura
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='detalle_pedido')
DROP TABLE LA_SELECT_NO_MURIO.detalle_pedido
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='material_sillon')
DROP TABLE LA_SELECT_NO_MURIO.material_sillon
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='sillon')
DROP TABLE LA_SELECT_NO_MURIO.sillon
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='sillon_modelo')
DROP TABLE LA_SELECT_NO_MURIO.sillon_modelo
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='sillon_medida')
DROP TABLE LA_SELECT_NO_MURIO.sillon_medida
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='pedido_cancelacion')
DROP TABLE LA_SELECT_NO_MURIO.pedido_cancelacion
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='pedido')
DROP TABLE LA_SELECT_NO_MURIO.pedido
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='cliente')
DROP TABLE LA_SELECT_NO_MURIO.cliente
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='relleno')
DROP TABLE LA_SELECT_NO_MURIO.relleno
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='tela')
DROP TABLE LA_SELECT_NO_MURIO.tela
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='madera')
DROP TABLE LA_SELECT_NO_MURIO.madera
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='detalle_compra')
DROP TABLE LA_SELECT_NO_MURIO.detalle_compra
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='material')
DROP TABLE LA_SELECT_NO_MURIO.material
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='compra')
DROP TABLE LA_SELECT_NO_MURIO.compra
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='proveedor')
DROP TABLE LA_SELECT_NO_MURIO.proveedor
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='sucursal')
DROP TABLE LA_SELECT_NO_MURIO.sucursal
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='localidad')
DROP TABLE LA_SELECT_NO_MURIO.localidad
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='provincia')
DROP TABLE LA_SELECT_NO_MURIO.provincia
GO

------Elimino el schema preventivamente ----------
IF EXISTS (SELECT name FROM sys.schemas WHERE name='LA_SELECT_NO_MURIO')
DROP SCHEMA LA_SELECT_NO_MURIO
GO

CREATE SCHEMA LA_SELECT_NO_MURIO
GO

-- Eliminamos los procedures -- 

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_localidad')
DROP PROCEDURE migrar_localidad
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_provincia')
DROP PROCEDURE migrar_provincia
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_cliente')
DROP PROCEDURE migrar_cliente
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_proveedor')
DROP PROCEDURE migrar_proveedor
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_sucursal')
DROP PROCEDURE migrar_sucursal
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_compra')
DROP PROCEDURE migrar_compra
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_material')
DROP PROCEDURE migrar_material
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_madera')
DROP PROCEDURE migrar_madera
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_relleno')
DROP PROCEDURE migrar_relleno
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_tela')
DROP PROCEDURE migrar_tela
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_detalle_compra')
DROP PROCEDURE migrar_detalle_compra
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_pedido')
DROP PROCEDURE migrar_pedido
GO


IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_sillon')
DROP PROCEDURE migrar_sillon
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_sillon_medida')
DROP PROCEDURE migrar_sillon_medida
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_sillon_modelo')
DROP PROCEDURE migrar_sillon_modelo
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_detalle_factura')
DROP PROCEDURE migrar_detalle_factura
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_factura')
DROP PROCEDURE migrar_factura
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_detalle_pedido')
DROP PROCEDURE migrar_detalle_pedido
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_envio')
DROP PROCEDURE migrar_envio
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_material_sillon')
DROP PROCEDURE migrar_material_sillon
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'migrar_pedido_cancelacion')
DROP PROCEDURE migrar_pedido_cancelacion
GO


----Creaci�n de tablas ----
CREATE TABLE LA_SELECT_NO_MURIO.provincia (
nro_provincia INT IDENTITY PRIMARY KEY,
nombre_provincia NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.localidad (
nro_localidad INT IDENTITY PRIMARY KEY,
nombre_localidad NVARCHAR(255) NOT NULL,
nro_provincia INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.provincia NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.proveedor(
cod_proveedor INT IDENTITY PRIMARY KEY,
razon_social_proveedor NVARCHAR(255) not null,
cuit_proveedor NVARCHAR(255) not null,
nro_localidad INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.localidad NOT NULL,
proveedor_direccion NVARCHAR(255) not null,
proveedor_telefono NVARCHAR(255) not null,
proveedor_mail NVARCHAR(255) not null
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.sucursal(
nro_sucursal BIGINT PRIMARY KEY,
nro_localidad INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.localidad NOT NULL,
sucursal_direccion NVARCHAR(255) not null,
sucursal_telefono NVARCHAR(255) not null,
sucursal_mail NVARCHAR(255) not null,
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.compra(
nro_compra DECIMAL(18, 0) PRIMARY KEY,
nro_sucursal BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.sucursal NOT NULL,
cod_proveedor INT REFERENCES LA_SELECT_NO_MURIO.proveedor,
fecha_compra DATETIME2(6) NOT NULL,
total_compra DECIMAL(18,2) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.material(
codigo_material INT IDENTITY PRIMARY KEY,
material_tipo NVARCHAR(255) NOT NULL,
material_nombre NVARCHAR(255) NOT NULL,
material_descripcion NVARCHAR(255) NULL,
material_precio DECIMAL(38,2) NOT NULL,
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.detalle_compra(
codigo_detalle_compra BIGINT PRIMARY KEY IDENTITY,
codigo_material INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.material NOT NULL,
nro_compra DECIMAL(18, 0) FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.compra NOT NULL,
detalle_compra_precio DECIMAL(18, 2) NOT NULL,
detalle_compra_cantidad DECIMAL(18, 0) NOT NULL,
detalle_compra_subtotal DECIMAL(18, 2) NOT NULL,
)

CREATE TABLE LA_SELECT_NO_MURIO.madera(
codigo_madera INT IDENTITY PRIMARY KEY,
codigo_material INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.material NOT NULL,
madera_color NVARCHAR(255) NOT NULL,
madera_dureza NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.tela(
codigo_tela INT IDENTITY PRIMARY KEY,
codigo_material INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.material NOT NULL,
tela_color NVARCHAR(255) NOT NULL,
tela_textura NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.relleno(
codigo_relleno INT IDENTITY PRIMARY KEY,
codigo_material INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.material NOT NULL,
relleno_densidad DECIMAL(38,2) NOT NULL
)
GO


CREATE TABLE LA_SELECT_NO_MURIO.cliente(
cod_cliente BIGINT IDENTITY PRIMARY KEY,
nro_localidad INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.localidad NOT NULL,
cliente_dni BIGINT NOT NULL,
cliente_nombre NVARCHAR(255) NOT NULL,
cliente_fecha_nacimiento DATETIME2(6) NOT NULL,
cliente_apellido NVARCHAR(255) NOT NULL,
cliente_mail NVARCHAR(255) NOT NULL,
cliente_direccion NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.pedido(
nro_pedido BIGINT PRIMARY KEY,
cod_cliente BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.cliente NOT NULL,
nro_sucursal BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.sucursal NOT NULL,
pedido_fecha DATETIME2(6) NOT NULL,
pedido_total DECIMAL(18, 2) NOT NULL,
pedido_estado NVARCHAR(255) DEFAULT 'PENDIENTE' NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.pedido_cancelacion(
pedido_cancelacion_fecha DATETIME2(6) NOT NULL,
pedido_cancelacion_motivo VARCHAR(255) NULL,
nro_pedido BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.pedido,
PRIMARY KEY (nro_pedido),
)
GO


CREATE TABLE LA_SELECT_NO_MURIO.sillon_medida(
codigo_sillon_medida BIGINT PRIMARY KEY IDENTITY,
sillon_medida_ancho DECIMAL(18,2) NOT NULL,
sillon_medida_alto DECIMAL(18,2) NOT NULL,
sillon_medida_profundidad DECIMAL(18,2) NOT NULL,
sillon_medida_precio DECIMAL(18,2) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.sillon_modelo(
codigo_sillon_modelo BIGINT PRIMARY KEY,
sillon_modelo_nombre NVARCHAR(255) NOT NULL,
sillon_modelo_descripcion NVARCHAR(255) NULL,
sillon_modelo_precio DECIMAL(18,2) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.sillon(
codigo_sillon BIGINT PRIMARY KEY,
codigo_sillon_medida BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.sillon_medida,
codigo_sillon_modelo BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.sillon_modelo,
)
GO



CREATE TABLE LA_SELECT_NO_MURIO.material_sillon(
codigo_sillon BIGINT REFERENCES LA_SELECT_NO_MURIO.sillon,
codigo_material INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.material,
PRIMARY KEY (codigo_sillon, codigo_material)
)
GO


CREATE TABLE LA_SELECT_NO_MURIO.detalle_pedido(
nro_pedido BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.pedido,
codigo_sillon BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.sillon,
cantidad BIGINT NOT NULL,
precio_unitario DECIMAL(18,2) NOT NULL,
subtotal DECIMAL(18,2) NOT NULL,
PRIMARY KEY (nro_pedido, codigo_sillon)
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.factura(
nro_factura BIGINT PRIMARY KEY,
nro_sucursal BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.sucursal NOT NULL,
cod_cliente BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.cliente NOT NULL,
factura_fecha DATETIME2(6) NOT NULL,
factura_total DECIMAL(38, 2) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.detalle_factura(
nro_detalle_factura INT IDENTITY PRIMARY KEY,
detalle_factura_precio DECIMAL(18, 2) NOT NULL,
detalle_factura_cantidad DECIMAL(18, 0) NOT NULL,
detalle_factura_subtotal DECIMAL(18, 2) NOT NULL,
nro_factura BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.factura NOT NULL,
nro_pedido BIGINT NOT NULL,
codigo_sillon BIGINT NOT NULL,
FOREIGN KEY (nro_pedido, codigo_sillon) REFERENCES LA_SELECT_NO_MURIO.detalle_pedido
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.envio(
nro_de_envio DECIMAL(18, 0) PRIMARY KEY,
nro_de_factura BIGINT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.factura,
fecha_programada DATETIME2(6) NOT NULL,
fecha_de_entrega DATETIME2(6) NOT NULL,
importe_traslado DECIMAL(18,2) NOT NULL,
importe_subida DECIMAL(18,2) NOT NULL
)
GO



---- Crear Store Procedures para realizar la migracion 
CREATE PROCEDURE migrar_provincia
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.provincia(nombre_provincia)
		SELECT Sucursal_Provincia FROM gd_esquema.Maestra
		WHERE Sucursal_Provincia IS NOT NULL
		UNION
		SELECT Cliente_Provincia FROM gd_esquema.Maestra
		WHERE Cliente_Provincia IS NOT NULL
		UNION 
		SELECT Proveedor_Provincia FROM gd_esquema.Maestra
		WHERE Proveedor_Provincia IS NOT NULL
	END
GO


CREATE PROCEDURE migrar_localidad
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.localidad(nombre_localidad, nro_provincia)
		SELECT DISTINCT Sucursal_Localidad, nro_provincia FROM gd_esquema.Maestra
		JOIN LA_SELECT_NO_MURIO.provincia ON Sucursal_Provincia = nombre_provincia 
		WHERE Sucursal_Localidad IS NOT NULL AND Sucursal_Provincia = nombre_provincia 
		UNION
		SELECT DISTINCT Cliente_Localidad, nro_provincia FROM gd_esquema.Maestra
		JOIN LA_SELECT_NO_MURIO.provincia ON Cliente_Provincia = nombre_provincia 
		WHERE Cliente_Localidad IS NOT NULL 
		UNION 
		SELECT DISTINCT Proveedor_Localidad, nro_provincia FROM gd_esquema.Maestra
		JOIN LA_SELECT_NO_MURIO.provincia ON Proveedor_Provincia = nombre_provincia 
		WHERE Proveedor_Localidad IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_proveedor
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.proveedor(razon_social_proveedor, cuit_proveedor, proveedor_direccion,proveedor_telefono,proveedor_mail,nro_localidad)
		SELECT DISTINCT maestra.Proveedor_RazonSocial, maestra.Proveedor_Cuit, maestra.Proveedor_Direccion, maestra.Proveedor_Telefono, maestra.Proveedor_Mail, localidad.nro_localidad FROM gd_esquema.Maestra AS maestra
		JOIN LA_SELECT_NO_MURIO.localidad localidad ON Proveedor_Localidad = localidad.nombre_localidad
		JOIN LA_SELECT_NO_MURIO.provincia provincia ON Proveedor_Provincia = provincia.nombre_provincia AND localidad.nro_provincia = provincia.nro_provincia
		WHERE maestra.Proveedor_RazonSocial IS NOT NULL 
		AND maestra.Proveedor_CUIT IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_sucursal
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.sucursal(nro_sucursal, nro_localidad, sucursal_direccion, sucursal_mail, sucursal_telefono)
		SELECT DISTINCT Sucursal_NroSucursal, nro_localidad, Sucursal_Direccion, Sucursal_Mail, Sucursal_Telefono FROM gd_esquema.Maestra
		JOIN LA_SELECT_NO_MURIO.localidad ON Sucursal_Localidad = nombre_localidad
		JOIN LA_SELECT_NO_MURIO.provincia provincia ON Sucursal_Provincia = provincia.nombre_provincia AND localidad.nro_provincia = provincia.nro_provincia
		WHERE Sucursal_NroSucursal IS NOT NULL
	END
GO



CREATE PROCEDURE migrar_cliente
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.cliente(nro_localidad, cliente_dni, cliente_nombre, cliente_fecha_nacimiento, cliente_apellido, cliente_mail, cliente_direccion)
		SELECT DISTINCT nro_localidad, m.Cliente_DNI, m.Cliente_Nombre, m.Cliente_FechaNacimiento, m.Cliente_apellido, m.Cliente_mail, m.Cliente_direccion  FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.localidad ON m.Cliente_Localidad = nombre_localidad
		JOIN LA_SELECT_NO_MURIO.provincia provincia ON m.Cliente_Provincia = provincia.nombre_provincia AND localidad.nro_provincia = provincia.nro_provincia
		WHERE m.Cliente_DNI IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_compra
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.compra(nro_compra, nro_sucursal, cod_proveedor, fecha_compra, total_compra)
		SELECT DISTINCT m.Compra_Numero, m.Sucursal_NroSucursal, prov.cod_proveedor, m.Compra_Fecha, m.Compra_Total   FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.proveedor prov ON m.Proveedor_Cuit = prov.cuit_proveedor AND m.Proveedor_RazonSocial = prov.razon_social_proveedor 
		WHERE m.Proveedor_Cuit IS NOT NULL AND m.Compra_Numero IS NOT NULL AND m.Sucursal_NroSucursal IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_detalle_compra
AS
	BEGIN 
		WITH detalles_unicos AS (
		SELECT *,
			   ROW_NUMBER() OVER (
					PARTITION BY Compra_Numero, Material_Descripcion, Detalle_Compra_SubTotal
					ORDER BY Detalle_Compra_Precio DESC
			   ) AS fila
		FROM gd_esquema.Maestra
		WHERE Compra_Numero IS NOT NULL
		)
		INSERT INTO LA_SELECT_NO_MURIO.detalle_compra(
			codigo_material,
			nro_compra,
			detalle_compra_precio,
			detalle_compra_cantidad,
			detalle_compra_subtotal
		)
		SELECT 
			mat.codigo_material,
			du.Compra_Numero,
			du.Detalle_Compra_Precio,
			du.Detalle_Compra_Cantidad,
			du.Detalle_Compra_SubTotal
		FROM detalles_unicos du
		JOIN LA_SELECT_NO_MURIO.material mat 
			ON du.Material_Tipo = mat.material_tipo 
			AND du.Material_Descripcion = mat.material_descripcion
		JOIN LA_SELECT_NO_MURIO.compra c 
			ON du.Compra_Numero = c.nro_compra
		WHERE fila = 1
	END
GO

CREATE PROCEDURE migrar_material
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.material(material_tipo, material_nombre, material_descripcion, material_precio)
		SELECT DISTINCT m.Material_Tipo, m.Material_Nombre, m.Material_Descripcion, m.Material_Precio  FROM gd_esquema.Maestra m
		WHERE m.Material_Tipo IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_madera
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.madera(codigo_material, madera_color, madera_dureza)
		SELECT DISTINCT material.codigo_material, m.Madera_color, m.Madera_dureza FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.material AS material
    	ON m.Material_Tipo = material.material_tipo AND m.Material_Descripcion = material.material_descripcion
		WHERE m.Material_Tipo = 'Madera'
	END
GO

CREATE PROCEDURE migrar_tela
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.tela(codigo_material, tela_color, tela_textura)
		SELECT DISTINCT material.codigo_material, m.Tela_Color, m.tela_textura FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.material AS material
    	ON m.Material_Tipo = material.material_tipo AND m.Material_Descripcion = material.material_descripcion
		WHERE m.Material_Tipo = 'Tela'
	END
GO

CREATE PROCEDURE migrar_relleno
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.relleno(codigo_material, relleno_densidad)
		SELECT DISTINCT material.codigo_material, m.Relleno_Densidad FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.material AS material
    	ON m.Material_Tipo = material.material_tipo AND m.Material_Descripcion = material.material_descripcion
		WHERE m.Material_Tipo = 'Relleno'
	END
GO

CREATE PROCEDURE migrar_pedido
AS
	BEGIN
		WITH pedidos_unicos AS (
		SELECT *,
			   ROW_NUMBER() OVER (
					PARTITION BY Pedido_Numero
					ORDER BY Pedido_Fecha DESC
			   ) AS fila
		FROM gd_esquema.Maestra
		WHERE Pedido_Numero IS NOT NULL
		)
		INSERT INTO LA_SELECT_NO_MURIO.pedido(
			nro_pedido,
			nro_sucursal,
			pedido_fecha,
			pedido_total,
			cod_cliente,
			pedido_estado
		)
		SELECT 
			pu.Pedido_Numero,
			pu.Sucursal_NroSucursal,
			pu.Pedido_Fecha,
			pu.Pedido_Total,
			cli.cod_cliente,
			pu.Pedido_Estado
		FROM pedidos_unicos pu
		OUTER APPLY (
			SELECT TOP 1 cod_cliente
			FROM LA_SELECT_NO_MURIO.cliente cli
			WHERE cli.cliente_dni = pu.Cliente_Dni
		) cli
		WHERE fila = 1 AND cli.cod_cliente IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_detalle_pedido
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.detalle_pedido(nro_pedido, codigo_sillon, cantidad, precio_unitario, subtotal) 
		SELECT DISTINCT 
			m.Pedido_Numero,
			m.Sillon_Codigo,
			m.Detalle_Pedido_Cantidad,
			m.Detalle_Pedido_Precio,
			m.Detalle_Pedido_SubTotal
		FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.pedido p ON m.Pedido_Numero = p.nro_pedido
		JOIN LA_SELECT_NO_MURIO.sillon s ON m.Sillon_Codigo = s.codigo_sillon
		WHERE 
			m.Pedido_Numero IS NOT NULL 
			AND m.Sillon_Codigo IS NOT NULL  
			AND m.Detalle_Pedido_Cantidad IS NOT NULL 
			AND m.Detalle_Pedido_Precio IS NOT NULL 
			AND m.Detalle_Pedido_SubTotal IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_pedido_cancelacion
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.pedido_cancelacion(pedido_cancelacion_fecha,pedido_cancelacion_motivo,nro_pedido)
		SELECT DISTINCT m.Pedido_Cancelacion_Fecha, m.Pedido_Cancelacion_Motivo, m.Pedido_Numero FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.pedido p ON p.nro_pedido = m.Pedido_Numero
		WHERE m.Pedido_Cancelacion_Fecha IS NOT NULL
		AND m.Pedido_Cancelacion_Motivo IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_factura
AS
	BEGIN
		WITH facturas_unicas AS (
		SELECT *,
			   ROW_NUMBER() OVER (
					PARTITION BY Factura_Numero
					ORDER BY Factura_Fecha DESC 
			   ) AS fila
		FROM gd_esquema.Maestra
		WHERE Factura_Numero IS NOT NULL
		)
		INSERT INTO LA_SELECT_NO_MURIO.factura(
			nro_factura,
			nro_sucursal,
			cod_cliente,
			factura_fecha,
			factura_total
		)
		SELECT 
			fu.Factura_Numero,
			fu.Sucursal_NroSucursal,
			cli.cod_cliente,
			fu.Factura_Fecha,
			fu.Factura_Total
		FROM facturas_unicas fu
		OUTER APPLY (
			SELECT TOP 1 cod_cliente
			FROM LA_SELECT_NO_MURIO.cliente cli
			WHERE cli.cliente_dni = fu.Cliente_Dni
		) cli
		WHERE fila = 1 AND cli.cod_cliente IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_detalle_factura
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.detalle_factura(nro_factura, detalle_factura_precio, detalle_factura_cantidad, nro_pedido, codigo_sillon, detalle_factura_subtotal) 
		SELECT DISTINCT m.Factura_Numero, pe.precio_unitario, pe.cantidad, m.Pedido_Numero, pe.codigo_sillon, pe.subtotal FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.detalle_pedido pe ON pe.nro_pedido = m.Pedido_Numero
		WHERE  m.Factura_Numero IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_sillon_medida
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.sillon_medida(sillon_medida_alto, sillon_medida_ancho, sillon_medida_profundidad, sillon_medida_precio)
		SELECT DISTINCT m.Sillon_Medida_Alto, m.Sillon_Medida_Ancho, m.Sillon_Medida_Profundidad, m.Sillon_Medida_Precio FROM gd_esquema.Maestra m
		WHERE m.Sillon_Medida_Alto IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_sillon_modelo
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.sillon_modelo(codigo_sillon_modelo, sillon_modelo_nombre, sillon_modelo_descripcion, sillon_modelo_precio)
		SELECT DISTINCT m.Sillon_Modelo_Codigo, m.Sillon_Modelo, m.Sillon_Modelo_Descripcion, m.Sillon_Modelo_Precio FROM gd_esquema.Maestra m
		WHERE m.Sillon_Modelo IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_sillon
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.sillon(codigo_sillon, codigo_sillon_medida, codigo_sillon_modelo)
		SELECT DISTINCT m.Sillon_Codigo, smed.codigo_sillon_medida, smod.codigo_sillon_modelo  FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.sillon_medida smed ON m.Sillon_Medida_Alto = smed.sillon_medida_alto AND 
		m.Sillon_Medida_Ancho = smed.sillon_medida_ancho AND m.Sillon_Medida_Profundidad = smed.sillon_medida_profundidad 
		AND m.Sillon_Medida_Precio = smed.sillon_medida_precio 
		JOIN LA_SELECT_NO_MURIO.sillon_modelo smod ON m.Sillon_Modelo = smod.sillon_modelo_nombre
		WHERE m.Sillon_Codigo IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_material_sillon
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.material_sillon(codigo_sillon, codigo_material)
		SELECT DISTINCT m.Sillon_Codigo, mat.codigo_material  
		FROM gd_esquema.Maestra m
		JOIN LA_SELECT_NO_MURIO.material mat 
			ON m.Material_Tipo = mat.material_tipo 
			AND m.Material_Descripcion = mat.material_descripcion
		JOIN LA_SELECT_NO_MURIO.sillon s 
			ON m.Sillon_Codigo = s.codigo_sillon
		WHERE m.Sillon_Codigo IS NOT NULL
	END
GO

CREATE PROCEDURE migrar_envio
AS
	BEGIN
		INSERT INTO LA_SELECT_NO_MURIO.envio(nro_de_envio, nro_de_factura, fecha_programada, fecha_de_entrega, importe_traslado, importe_subida)
		SELECT DISTINCT m.Envio_Numero, m.Factura_Numero, m.Envio_Fecha_Programada, m.Envio_Fecha , m.Envio_ImporteTraslado, m.Envio_importeSubida FROM gd_esquema.Maestra m
		WHERE m.Envio_Numero IS NOT NULL
	END
GO

---- Hacer la migracion ------
BEGIN TRANSACTION
	BEGIN TRY 
		EXEC migrar_provincia
		EXEC migrar_localidad
		EXEC migrar_sucursal
		EXEC migrar_proveedor
		EXEC migrar_cliente
		EXEC migrar_compra
		EXEC migrar_material
		EXEC migrar_madera
		EXEC migrar_tela
		EXEC migrar_relleno
		EXEC migrar_detalle_compra
		EXEC migrar_pedido
		EXEC migrar_pedido_cancelacion
		EXEC migrar_factura
		EXEC migrar_sillon_medida
		EXEC migrar_sillon_modelo
		EXEC migrar_sillon
		EXEC migrar_material_sillon
		EXEC migrar_detalle_pedido
		EXEC migrar_detalle_factura
		EXEC migrar_envio
	END TRY
	BEGIN CATCH 
		PRINT 'UPSSS, Hay un error en la migracion'
		ROLLBACK TRANSACTION
	END CATCH
COMMIT TRANSACTION