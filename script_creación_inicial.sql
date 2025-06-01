USE GD1C2025
GO

------Eliminamos las tablas ya creadas ---------
IF EXISTS (SELECT name FROM sys.tables WHERE name='provincia')
DROP TABLE LA_SELECT_NO_MURIO.provincia
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='localidad')
DROP TABLE LA_SELECT_NO_MURIO.localidad
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='sucursal')
DROP TABLE LA_SELECT_NO_MURIO.sucursal
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='compra')
DROP TABLE LA_SELECT_NO_MURIO.compra
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='proveedor')
DROP TABLE LA_SELECT_NO_MURIO.proveedor
GO

------Elimino el schema preventivamente ----------
IF EXISTS (SELECT name FROM sys.schemas WHERE name='LA_SELECT_NO_MURIO')
DROP SCHEMA LA_SELECT_NO_MURIO
GO

CREATE SCHEMA LA_SELECT_NO_MURIO
GO

----Creación de tablas ----
CREATE TABLE LA_SELECT_NO_MURIO.provincia (
nro_provincia INT IDENTITY PRIMARY KEY,
nombre_provincia NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.localidad (
nro_localidad INT IDENTITY PRIMARY KEY,
nombre_localidad NVARCHAR(255) NOT NULL,
nro_provincia INT REFERENCES LA_SELECT_NO_MURIO.provincia NOT NULL
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.proveedor(
razon_social_proveedor NVARCHAR(255) not null,
cuit_proveedor NVARCHAR(255) not null,
nro_localidad INT REFERENCES LA_SELECT_NO_MURIO.localidad NOT NULL,
proveedor_direccion NVARCHAR(255) not null,
proveedor_telefono NVARCHAR(255) not null,
proveedor_mail NVARCHAR(255) not null,
PRIMARY KEY  (razon_social_proveedor, cuit_proveedor) 
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.sucursal(
nro_sucursal INT PRIMARY KEY IDENTITY,
nro_localidad INT REFERENCES LA_SELECT_NO_MURIO.localidad NOT NULL,
sucursal_direccion NVARCHAR(255) not null,
sucursal_telefono NVARCHAR(255) not null,
sucursal_mail NVARCHAR(255) not null,
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.compra(
nro_compra DECIMAL(18, 0) IDENTITY PRIMARY KEY,
nro_sucursal INT REFERENCES LA_SELECT_NO_MURIO.sucursal NOT NULL,
razon_social_proveedor NVARCHAR(255) NOT NULL,
cuit_proveedor NVARCHAR(255) NOT NULL,
fecha_compra DATETIME2(6) NOT NULL,
total_compra DECIMAL(18,2) NOT NULL,
FOREIGN KEY(razon_social_proveedor, cuit_proveedor) REFERENCES
LA_SELECT_NO_MURIO.proveedor
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

CREATE TABLE LA_SELECT_NO_MURIO.madera(
codigo_madera INT IDENTITY PRIMARY KEY,
codigo_material INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.material,
color NVARCHAR(255),
dureza NVARCHAR(255)
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.tela(
codigo_tela INT IDENTITY PRIMARY KEY,
codigo_material INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.material,
tela_color NVARCHAR(255),
tela_textura NVARCHAR(255)
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.relleno(
codigo_relleno INT IDENTITY PRIMARY KEY,
codigo_material INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.material,
relleno_densidad DECIMAL(38,2)
)
GO


CREATE TABLE LA_SELECT_NO_MURIO.cliente(
cod_cliente BIGINT IDENTITY PRIMARY KEY,
nro_localidad INT FOREIGN KEY REFERENCES LA_SELECT_NO_MURIO.localidad,
cliente_dni BIGINT,
cliente_nombre NVARCHAR(255),
cliente_fecha_nacimiento DATETIME2(6),
cliente_apellido NVARCHAR(255),
cliente_mail NVARCHAR(255),
cliente_direccion NVARCHAR(255)
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.pedido(
nro_pedido BIGINT PRIMARY KEY IDENTITY,
cod_cliente BIGINT REFERENCES LA_SELECT_NO_MURIO.cliente NOT NULL,
nro_sucursal INT REFERENCES LA_SELECT_NO_MURIO.sucursal NOT NULL,
pedido_fecha DATETIME2(6) NOT NULL,
pedido_total DECIMAL(18, 2) NOT NULL
)
GO



---- Crear Store Procedures para realizar la migracion -----
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
		SELECT Sucursal_Localidad, nro_provincia FROM gd_esquema.Maestra
		JOIN LA_SELECT_NO_MURIO.provincia ON Sucursal_Provincia = nombre_provincia 
		WHERE Sucursal_Localidad IS NOT NULL AND Sucursal_Provincia = nombre_provincia 
		UNION
		SELECT Cliente_Localidad, nro_provincia FROM gd_esquema.Maestra
		JOIN LA_SELECT_NO_MURIO.provincia ON Cliente_Provincia = nombre_provincia 
		WHERE Cliente_Localidad IS NOT NULL 
		UNION 
		SELECT Proveedor_Localidad, nro_provincia FROM gd_esquema.Maestra
		JOIN LA_SELECT_NO_MURIO.provincia ON Proveedor_Provincia = nombre_provincia 
		WHERE Proveedor_Localidad IS NOT NULL
	END
GO

---- Hacer la migracion ------
BEGIN TRANSACTION
	EXEC migrar_provincia
	EXEC migrar_localidad
COMMIT TRANSACTION