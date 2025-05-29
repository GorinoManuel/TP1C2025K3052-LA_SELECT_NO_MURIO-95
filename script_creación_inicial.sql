USE GD1C2025
GO

------Elimino el schema preventivamente ----------
IF EXISTS (SELECT name FROM sys.schemas WHERE name='LA_SELECT_NO_MURIO')
DROP SCHEMA LA_SELECT_NO_MURIO
GO

------Eliminamos las tablas ya creadas ---------


CREATE SCHEMA LA_SELECT_NO_MURIO
GO

----Creación de tablas ----
CREATE TABLE LA_SELECT_NO_MURIO.provincia (
nro_provincia INT IDENTITY PRIMARY KEY,
nombre_provincia NVARCHAR(255)
)

CREATE TABLE LA_SELECT_NO_MURIO.localidad (
nro_localidad INT IDENTITY PRIMARY KEY,
nombre_localidad NVARCHAR(255),
nro_provincia INT REFERENCES LA_SELECT_NO_MURIO.provincia
)

