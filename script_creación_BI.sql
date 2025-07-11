USE GD1C2025
GO

/**/

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Fact_Venta')
DROP TABLE LA_SELECT_NO_MURIO.BI_Fact_Venta
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Fact_Compras')
DROP TABLE LA_SELECT_NO_MURIO.BI_Fact_Compras
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Fact_Pedidos')
DROP TABLE LA_SELECT_NO_MURIO.BI_Fact_Pedidos
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Fact_Envios')
DROP TABLE LA_SELECT_NO_MURIO.BI_Fact_Envios
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Dim_Turno')
DROP TABLE LA_SELECT_NO_MURIO.BI_Dim_Turno
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Dim_Tiempo')
DROP TABLE LA_SELECT_NO_MURIO.BI_Dim_Tiempo
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Dim_Ubicacion')
DROP TABLE LA_SELECT_NO_MURIO.BI_Dim_Ubicacion
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Dim_Tipo_Material')
DROP TABLE LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Dim_Modelo_Sillon')
DROP TABLE LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Dim_Cliente')
DROP TABLE LA_SELECT_NO_MURIO.BI_Dim_Cliente
GO


IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Dim_Estado')
DROP TABLE LA_SELECT_NO_MURIO.BI_Dim_Estado
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Dim_Sucursal')
DROP TABLE LA_SELECT_NO_MURIO.BI_Dim_Sucursal
GO




/* creación de tablas */


CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Turno(--
    id_turno INT IDENTITY PRIMARY KEY,
    turno NVARCHAR(40) 
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Tiempo(--
    id_tiempo INT IDENTITY PRIMARY KEY,
    anio INT NOT NULL,
    cuatrimestre INT NOT NULL,
    mes INT NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(--
    id_ubicacion INT IDENTITY PRIMARY KEY,
    provincia NVARCHAR(255),
    localidad NVARCHAR(255)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material(--
    id_material INT PRIMARY KEY,
    material_descripcion NVARCHAR(255) NOT NULL,
    material_tipo NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon(--
    id_sillon_modelo BIGINT PRIMARY KEY,
    sillon_modelo_nombre NVARCHAR(255) NOT NULL,
    sillon_modelo_descripcion NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Cliente (--
    id_cliente INT  PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    rango_etario NVARCHAR(255) NOT NULL
);
GO


CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Estado(--
    id_estado INT IDENTITY PRIMARY KEY,
    estado_nombre NVARCHAR(255)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Sucursal(
    nro_sucursal BIGINT PRIMARY KEY,
    sucursal_direccion NVARCHAR(255) NOT NULL,
    sucursal_telefono NVARCHAR(255) NOT NULL,
    sucursal_mail NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Venta (
    id_fact_ventas INT PRIMARY KEY IDENTITY(1,1),

    id_cliente INT,
    id_tiempo INT,
    id_ubicacion INT,
    id_sillon_modelo BIGINT,
    nro_sucursal BIGINT,
    cantidad INT,
    cantidad_facturas INT, 
    precio_promedio_venta DECIMAL(18,2),

    FOREIGN KEY (id_cliente) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Cliente(id_cliente),
    FOREIGN KEY (id_tiempo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_sillon_modelo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon(id_sillon_modelo),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Compras(
    id_fact_compras INT PRIMARY KEY IDENTITY,
    id_material INT,
    id_tiempo INT,
    id_ubicacion INT,
    nro_sucursal BIGINT,
    cantidad_compras INT,
    promedio_precio_compras DECIMAL(18,2),

    FOREIGN KEY (id_material) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material(id_material),
    FOREIGN KEY (id_tiempo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Envios(
    id_fact_envios INT IDENTITY(1,1) PRIMARY KEY,

    id_ubicacion INT,
    id_cliente INT,
    id_tiempo_fecha_entrega INT,
    cantidad_envios_total INT,
    porcentaje_cumplido_mes DECIMAL(38, 2),
    costo_total_envio DECIMAL(18, 2)

    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_cliente) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Cliente(id_cliente),
    FOREIGN KEY (id_tiempo_fecha_entrega) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Pedidos (
    id_fact_pedidos INT IDENTITY(1,1) PRIMARY KEY,
    id_ubicacion INT,
    id_tiempo INT,
    id_turnos INT,
    nro_sucursal BIGINT,
    cantidad_pedidos INT,
    estado INT,
    tiempo_promedio_dia DECIMAL(10,2)
    
    
    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_tiempo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_turnos) REFERENCES  LA_SELECT_NO_MURIO.BI_Dim_Turno(id_turno),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal),
    FOREIGN KEY (estado) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Estado(id_estado)
)
GO
/*Eliminar migraciones*/


/*Migraciones */
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_ubicacion' )
    DROP PROCEDURE BI_migrar_ubicacion
GO

CREATE PROCEDURE BI_migrar_ubicacion
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Ubicacion (localidad, provincia)
        SELECT nombre_localidad, nombre_provincia FROM LA_SELECT_NO_MURIO.Localidad loc JOIN  LA_SELECT_NO_MURIO.provincia prov 
        ON prov.nro_provincia = loc.nro_provincia
    END
GO


CREATE OR ALTER FUNCTION LA_SELECT_NO_MURIO.obtener_turno(@pedido_fecha DATETIME2(6))
RETURNS NVARCHAR(40)
AS     
BEGIN           
    RETURN (CASE 
                WHEN DATEPART(HOUR, @pedido_fecha) <= 14  AND DATEPART(HOUR, @pedido_fecha) >= 8 THEN '08:00 - 14:00'
                WHEN DATEPART(HOUR, @pedido_fecha) > 14  AND DATEPART(HOUR, @pedido_fecha) <= 20 THEN  '14:00 - 20:00'
                END) 
END
GO

CREATE OR ALTER FUNCTION LA_SELECT_NO_MURIO.obtener_cuatrimestre(@fecha DATETIME2(6))
RETURNS INT 
AS 
    BEGIN
        RETURN (CASE WHEN 1 <= MONTH(@fecha) AND MONTH(@fecha) <= 4 THEN 1
                                        WHEN 5 <= MONTH(@fecha) AND MONTH(@fecha) <= 8 THEN 2
                                        ELSE 3 END) 
    END
GO

CREATE OR ALTER FUNCTION LA_SELECT_NO_MURIO.getAge(@dateofbirth datetime2(6)) --Recibe una fecha de nacimiento por parámetro
RETURNS int													 --Y devuelve la edad actual de la persona.
AS
    BEGIN
        DECLARE @age int;
        
        IF (MONTH(@dateofbirth)!=MONTH(GETDATE()))
            SET @age = DATEDIFF(MONTH, @dateofbirth, GETDATE())/12;
        ELSE IF(DAY(@dateofbirth) > DAY(GETDATE()))
            SET @age = (DATEDIFF(MONTH, @dateofbirth, GETDATE())/12)-1;
        ELSE 
        BEGIN
            SET @age = DATEDIFF(MONTH, @dateofbirth, GETDATE())/12;
        END
        RETURN @age;
    END
GO


CREATE OR ALTER FUNCTION LA_SELECT_NO_MURIO.getAgeRange (@age int) --Recibe una edad por parámetro y 
RETURNS varchar(10)								  --devuelve el rango de edad al que pertenece.	
AS
    BEGIN
        DECLARE @returnvalue varchar(10);
        IF ( @age < 26)
        BEGIN
            SET @returnvalue = '25 <'
        END
        ELSE IF (@age > 25 AND @age <36)
        BEGIN
            SET @returnvalue = '[18 - 30]';
        END
        ELSE IF (@age > 35 AND @age <51)
        BEGIN
            SET @returnvalue = '[31 - 50]';
        END
        ELSE IF(@age > 50)
        BEGIN
            SET @returnvalue = '+50';
        END

        RETURN @returnvalue;
END
GO


IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_cliente' )
    DROP PROCEDURE BI_migrar_cliente
GO

CREATE PROCEDURE BI_migrar_cliente
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Cliente (id_cliente, nombre, rango_etario)
        SELECT 
            cli.cod_cliente,
            cli.cliente_nombre,
            LA_SELECT_NO_MURIO.getAgeRange(LA_SELECT_NO_MURIO.getAge(cli.cliente_fecha_nacimiento))
        FROM LA_SELECT_NO_MURIO.cliente cli
        WHERE cli.cliente_fecha_nacimiento IS NOT NULL;
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_Tipo_Material' )
    DROP PROCEDURE BI_migrar_Tipo_Material
GO

CREATE PROCEDURE BI_migrar_Tipo_Material
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material ( id_material, material_descripcion, material_tipo)
        SELECT mat.codigo_material, mat.material_descripcion, mat.material_tipo FROM LA_SELECT_NO_MURIO.Material mat
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_turno' )
    DROP PROCEDURE BI_migrar_turno
GO

CREATE PROCEDURE BI_migrar_turno
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Turno (turno)
        SELECT DISTINCT LA_SELECT_NO_MURIO.obtener_turno(ped.pedido_fecha)
        FROM LA_SELECT_NO_MURIO.pedido ped
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_modelo_sillon' )
    DROP PROCEDURE BI_migrar_modelo_sillon
GO

CREATE PROCEDURE BI_migrar_modelo_sillon
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon ( id_sillon_modelo, sillon_modelo_nombre, sillon_modelo_descripcion)
        SELECT sm.codigo_sillon_modelo, sm.sillon_modelo_nombre, sm.sillon_modelo_descripcion 
        FROM LA_SELECT_NO_MURIO.sillon_modelo sm
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_estado' )
    DROP PROCEDURE BI_migrar_estado
GO

CREATE PROCEDURE BI_migrar_estado
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Estado (estado_nombre)
        SELECT DISTINCT ped.pedido_estado
        FROM LA_SELECT_NO_MURIO.pedido ped
    END
GO


IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_tiempos_compras' )
    DROP PROCEDURE BI_migrar_tiempos_compras
GO

CREATE PROCEDURE BI_migrar_tiempos_compras
AS
    BEGIN
        DECLARE date_cursor CURSOR FOR SELECT fecha_compra FROM LA_SELECT_NO_MURIO.compra
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Anio int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(@Date)
                SET @Mes = MONTH(@Date)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre ))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes) VALUES (@Anio, @Cuatrimestre, @mes)
                END

                FETCH date_cursor into @Date
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_tiempos_pedido' )
    DROP PROCEDURE BI_migrar_tiempos_pedido
GO

CREATE PROCEDURE BI_migrar_tiempos_pedido
AS
    BEGIN
        DECLARE date_cursor CURSOR FOR SELECT pedido_fecha  FROM LA_SELECT_NO_MURIO.pedido
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Anio int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int 
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(@Date)
                SET @Mes = MONTH(@Date)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes) VALUES (@Anio, @Cuatrimestre, @mes)
                END

                FETCH date_cursor into @Date
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
GO


IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_tiempos_factura' )
    DROP PROCEDURE BI_migrar_tiempos_factura
GO

CREATE PROCEDURE BI_migrar_tiempos_factura
AS
    BEGIN
        DECLARE date_cursor CURSOR FOR SELECT factura_fecha  FROM LA_SELECT_NO_MURIO.factura
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Anio int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(@Date) 
                SET @Mes = MONTH(@Date)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre ))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes) VALUES (@Anio, @Cuatrimestre, @mes)
                END

                FETCH date_cursor into @Date
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_tiempos_envio' )
    DROP PROCEDURE BI_migrar_tiempos_envio
GO

CREATE PROCEDURE BI_migrar_tiempos_envio
AS
    BEGIN
        DECLARE date_cursor CURSOR FOR SELECT fecha_de_entrega, fecha_programada  FROM LA_SELECT_NO_MURIO.envio
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Fecha_Programada DATETIME2(6)
        DECLARE @Anio int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        

        OPEN date_cursor
        FETCH date_cursor into @Date, @Fecha_Programada

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(@Date)
                SET @Mes = MONTH(@Date)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre ))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes) VALUES (@Anio, @Cuatrimestre, @mes)
                END
                
                SET @Anio = YEAR(@Fecha_Programada)
                SET @Cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(@Fecha_Programada)
                SET @Mes = MONTH(@Fecha_Programada)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes) VALUES (@Anio, @Cuatrimestre, @mes)
                END
                

                FETCH date_cursor into @Date, @Fecha_Programada
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_sucursales' )
    DROP PROCEDURE BI_migrar_sucursales
GO

CREATE PROCEDURE BI_migrar_sucursales 
AS
    BEGIN
    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Sucursal (nro_sucursal, sucursal_direccion, sucursal_mail, sucursal_telefono)
    SELECT suc.nro_sucursal, suc.sucursal_direccion, suc.sucursal_mail, suc.sucursal_telefono FROM LA_SELECT_NO_MURIO.sucursal suc
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_ventas' )
    DROP PROCEDURE BI_migrar_ventas
GO

CREATE PROCEDURE BI_migrar_ventas 
AS
    BEGIN
    INSERT INTO LA_SELECT_NO_MURIO.BI_Fact_Venta (id_cliente, id_tiempo, id_ubicacion, id_sillon_modelo, nro_sucursal, cantidad, cantidad_facturas, precio_promedio_venta)
    SELECT dc.id_cliente, dt.id_tiempo,   (SELECT du.id_ubicacion FROM LA_SELECT_NO_MURIO.sucursal suc
        JOIN LA_SELECT_NO_MURIO.localidad loc ON loc.nro_localidad = suc.nro_localidad 
        JOIN LA_SELECT_NO_MURIO.provincia prov ON prov.nro_provincia = loc.nro_provincia 
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Ubicacion du ON du.localidad = loc.nombre_localidad AND du.provincia = prov.nombre_provincia
        WHERE suc.nro_sucursal = fac.nro_sucursal ),
     s.codigo_sillon_modelo
    , fac.nro_sucursal,
    SUM(df.detalle_factura_cantidad), COUNT(DISTINCT fac.nro_factura ), (SUM(df.detalle_factura_precio * dF.detalle_factura_cantidad) / SUM(df.detalle_factura_cantidad))
    FROM LA_SELECT_NO_MURIO.factura fac JOIN LA_SELECT_NO_MURIO.BI_Dim_Cliente dc ON fac.cod_cliente = dc.id_cliente
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.anio = YEAR(fac.factura_fecha) AND
    dt.mes = MONTH(fac.factura_fecha)  AND dt.cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(fac.factura_fecha)
    JOIN LA_SELECT_NO_MURIO.detalle_factura df ON df.nro_factura = fac.nro_factura
    JOIN LA_SELECT_NO_MURIO.sillon s ON s.codigo_sillon = df.codigo_sillon
    GROUP BY dc.id_cliente, dt.id_tiempo, s.codigo_sillon_modelo, fac.nro_sucursal
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_compras' )
    DROP PROCEDURE BI_migrar_compras
GO

CREATE PROCEDURE BI_migrar_compras
AS
    BEGIN
    INSERT INTO LA_SELECT_NO_MURIO.BI_Fact_Compras (id_material, id_tiempo, id_ubicacion, nro_sucursal, cantidad_compras, promedio_precio_compras)
    SELECT dc.codigo_material, dt.id_tiempo,   (SELECT du.id_ubicacion FROM LA_SELECT_NO_MURIO.sucursal suc
        JOIN LA_SELECT_NO_MURIO.localidad loc ON loc.nro_localidad = suc.nro_localidad 
        JOIN LA_SELECT_NO_MURIO.provincia prov ON prov.nro_provincia = loc.nro_provincia 
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Ubicacion du ON du.localidad = loc.nombre_localidad AND du.provincia = prov.nombre_provincia
        WHERE suc.nro_sucursal = com.nro_sucursal ),
    com.nro_sucursal,
    SUM(dc.detalle_compra_cantidad), (SUM(dc.detalle_compra_precio * dc.detalle_compra_cantidad) / SUM(DC.detalle_compra_cantidad))
    FROM LA_SELECT_NO_MURIO.compra com 
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.anio = YEAR(com.fecha_compra) AND
    dt.mes = MONTH(com.fecha_compra) AND dt.cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(com.fecha_compra)
    JOIN LA_SELECT_NO_MURIO.detalle_compra dc ON dc.nro_compra = com.nro_compra
    GROUP BY dc.codigo_material, dt.id_tiempo, dt.id_tiempo, com.nro_sucursal
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_envios' )
    DROP PROCEDURE BI_migrar_envios
GO

CREATE OR ALTER PROCEDURE BI_migrar_envios
AS
    BEGIN
    INSERT INTO LA_SELECT_NO_MURIO.BI_Fact_Envios (id_ubicacion, id_cliente, id_tiempo_fecha_entrega, porcentaje_cumplido_mes, costo_total_envio)
    SELECT (SELECT du.id_ubicacion FROM LA_SELECT_NO_MURIO.cliente cli
        JOIN LA_SELECT_NO_MURIO.localidad loc ON loc.nro_localidad = cli.nro_localidad 
        JOIN LA_SELECT_NO_MURIO.provincia prov ON prov.nro_provincia = loc.nro_provincia 
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Ubicacion du ON du.localidad = loc.nombre_localidad AND du.provincia = prov.nombre_provincia
        WHERE fac.cod_cliente = cli.cod_cliente),
    fac.cod_cliente, dt.id_tiempo, 100.0 * SUM(CASE 
                   WHEN env.fecha_de_entrega <= env.fecha_programada THEN 1 
                   ELSE 0 
               END) / COUNT(*), SUM( env.importe_traslado + env.importe_subida)
    FROM LA_SELECT_NO_MURIO.envio env
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.anio = YEAR(env.fecha_de_entrega) AND
    dt.mes = MONTH(env.fecha_de_entrega) AND dt.cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(env.fecha_de_entrega)
    JOIN LA_SELECT_NO_MURIO.factura fac ON  fac.nro_factura = env.nro_de_factura
    GROUP BY fac.cod_cliente, dt.id_tiempo
    END
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'BI_migrar_pedidos' )
    DROP PROCEDURE BI_migrar_pedidos
GO

CREATE PROCEDURE BI_migrar_pedidos
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Fact_Pedidos (id_tiempo, id_turnos, cantidad_pedidos, nro_sucursal, estado, tiempo_promedio_dia)
        SELECT 
        dt.id_tiempo, tur.id_turno, COUNT(DISTINCT ped.nro_pedido), ped.nro_sucursal, est.id_estado, 
        AVG(DATEDIFF(day, ped.pedido_fecha, ISNULL( fact.factura_fecha, ped.pedido_fecha)))
        FROM LA_SELECT_NO_MURIO.pedido ped
        LEFT JOIN LA_SELECT_NO_MURIO.detalle_pedido dped ON dped.nro_pedido = ped.nro_pedido
        LEFT JOIN LA_SELECT_NO_MURIO.detalle_factura dfact ON dfact.codigo_sillon = dped.codigo_sillon
        AND dfact.nro_pedido = dped.nro_pedido
        LEFT JOIN LA_SELECT_NO_MURIO.factura fact on fact.nro_factura = dfact.nro_factura
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.anio = YEAR(ped.pedido_fecha) AND
        dt.mes = MONTH(ped.pedido_fecha) AND dt.cuatrimestre = LA_SELECT_NO_MURIO.obtener_cuatrimestre(ped.pedido_fecha)
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Turno tur ON tur.turno = LA_SELECT_NO_MURIO.obtener_turno(ped.pedido_fecha) 
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Estado est ON est.estado_nombre = ped.pedido_estado
        GROUP BY   dt.id_tiempo, tur.id_turno, ped.nro_sucursal,  est.id_estado
    END
GO

IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_ganancias' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_ganancias
GO

CREATE OR ALTER VIEW LA_SELECT_NO_MURIO.vista_ganancias
AS
    SELECT fv.nro_sucursal,  dt.mes, (SUM(fv.precio_promedio_venta*fv.cantidad)-SUM(fc.promedio_precio_compras)) 'Ganancias'
	FROM LA_SELECT_NO_MURIO.BI_Fact_Venta fv JOIN LA_SELECT_NO_MURIO.BI_Fact_Compras fc ON fv.nro_sucursal = fc.nro_sucursal  and FC.id_tiempo = fv.id_tiempo
											JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.id_tiempo = fv.id_tiempo 
	GROUP BY fv.nro_sucursal, dt.mes
GO     


IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_facturacion_promedio_mensual' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_facturacion_promedio_mensual
GO

CREATE VIEW LA_SELECT_NO_MURIO.vista_facturacion_promedio_mensual 
AS
    SELECT SUM(fv.precio_promedio_venta * fv.cantidad) / SUM(fv.cantidad_facturas) 'Facturacion Promedio Mensual',  dt.cuatrimestre, dt.anio, du.provincia, fv.nro_sucursal 
    FROM LA_SELECT_NO_MURIO.BI_Fact_Venta fv JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.id_tiempo = fv.id_tiempo
            JOIN LA_SELECT_NO_MURIO.BI_Dim_Ubicacion du ON du.id_ubicacion = fv.id_ubicacion
    GROUP BY dt.cuatrimestre, dt.anio, du.provincia, fv.nro_sucursal 
GO 


IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_rendimiento_modelos' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_rendimiento_modelos
GO

-- Segun localidad y rango etario (top 3)
CREATE VIEW LA_SELECT_NO_MURIO.vista_rendimiento_modelos
AS
    SELECT TOP 3 SUM(fv.precio_promedio_venta * fv.cantidad) 'Modelo con mayores ventas', dt.cuatrimestre, cli.rango_etario, fv.nro_sucursal, du.localidad 
    FROM LA_SELECT_NO_MURIO.BI_Fact_Venta fv 
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.id_tiempo = fv.id_tiempo
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Cliente cli ON cli.id_cliente = fv.id_cliente 
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon ms ON ms.id_sillon_modelo = fv.id_sillon_modelo
        JOIN LA_SELECT_NO_MURIO.BI_Dim_Ubicacion du ON du.id_ubicacion = fv.id_ubicacion
    GROUP BY dt.cuatrimestre, cli.rango_etario, fv.nro_sucursal, du.localidad 
    ORDER BY SUM(fv.precio_promedio_venta * fv.cantidad) desc
GO        


IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_volumen_pedidos' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_volumen_pedidos
GO

CREATE VIEW LA_SELECT_NO_MURIO.vista_volumen_pedidos
AS
    SELECT dtur.turno, SUM(fp.cantidad_pedidos) 'volumen de pedidos', fp.nro_sucursal, dt.mes, dt.anio   
    FROM LA_SELECT_NO_MURIO.BI_Fact_Pedidos fp 
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt  ON dt.id_tiempo=fp.id_tiempo
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Turno dtur ON dtur.id_turno = fp.id_turnos 
    GROUP BY fp.nro_sucursal, dt.mes, dt.anio, dtur.turno  
GO




IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_conversion_pedidos' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_conversion_pedidos
GO

CREATE VIEW LA_SELECT_NO_MURIO.vista_conversion_pedidos
AS
    SELECT  (SUM(fp.cantidad_pedidos) *100 / 
            (SELECT SUM(fp2.cantidad_pedidos) FROM LA_SELECT_NO_MURIO.BI_Fact_Pedidos fp2
            JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt2  ON dt2.id_tiempo=fp2.id_tiempo
            WHERE dt2.cuatrimestre = dt.cuatrimestre AND FP2.nro_sucursal = fp.nro_sucursal
            )) '% Conversion_pedidos',
            fp.nro_sucursal, dt.cuatrimestre, est.estado_nombre
    FROM LA_SELECT_NO_MURIO.BI_Fact_Pedidos fp 
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt  ON dt.id_tiempo=fp.id_tiempo
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Estado est ON fp.estado = est.id_estado
    GROUP BY fp.nro_sucursal, dt.cuatrimestre, est.estado_nombre
GO


IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_tiempo_promedio_fabricacion' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_tiempo_promedio_fabricacion
GO

-- Un pedido pendiente/cancelado no tiene que ser considerado aca
CREATE VIEW LA_SELECT_NO_MURIO.vista_tiempo_promedio_fabricacion 
AS
    SELECT
        AVG(pedidos.tiempo_promedio_dia) AS Tiempopromedio,
        tiempo_pedido.cuatrimestre AS cuatrimestre,
        tiempo_pedido.anio AS anio
    FROM
        LA_SELECT_NO_MURIO.BI_Fact_Pedidos AS pedidos
    JOIN
        LA_SELECT_NO_MURIO.BI_Dim_tiempo AS tiempo_pedido ON pedidos.id_tiempo = tiempo_pedido.id_tiempo
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Estado est ON est.id_estado = pedidos.estado 
    WHERE est.estado_nombre = 'ENTREGADO'
    GROUP BY tiempo_pedido.anio, tiempo_pedido.cuatrimestre
GO



IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_promedio_compras' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_promedio_compras
GO

CREATE OR ALTER VIEW LA_SELECT_NO_MURIO.vista_promedio_compras 
AS
    SELECT
        dt.mes AS mes,
        AVG(fc.promedio_precio_compras*fc.cantidad_compras) AS importe_promedio
    FROM LA_SELECT_NO_MURIO.BI_Fact_Compras fc 
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON fc.id_tiempo = dt.id_tiempo
    GROUP BY dt.mes
GO



IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_compras_por_tipo_material' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_compras_por_tipo_material
GO

CREATE OR ALTER VIEW LA_SELECT_NO_MURIO.vista_compras_por_tipo_material 
AS
    SELECT
        dt.cuatrimestre,
        tm.material_tipo,
        suc.nro_sucursal,
        SUM(fc.promedio_precio_compras*fc.cantidad_compras) AS importe_total_material
    FROM LA_SELECT_NO_MURIO.BI_Fact_Compras fc 
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON fc.id_tiempo = dt.id_tiempo
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material tm ON tm.id_material = fc.id_material
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Sucursal suc ON fc.nro_sucursal = suc.nro_sucursal
    GROUP BY dt.cuatrimestre,
        tm.material_tipo,
        suc.nro_sucursal
GO


IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_porcentaje_cumplimiento_pedidos' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_porcentaje_cumplimiento_pedidos
GO

CREATE OR ALTER VIEW LA_SELECT_NO_MURIO.vista_porcentaje_cumplimiento_pedidos 
AS
    SELECT 
        dt.mes AS mes,
        avg(fe.porcentaje_cumplido_mes) AS porcentaje_cumplimiento
    FROM LA_SELECT_NO_MURIO.BI_Fact_Envios fe
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON fe.id_tiempo_fecha_entrega = dt.id_tiempo
    GROUP BY dt.mes
GO
--OK


IF EXISTS (SELECT name FROM sys.views WHERE name = 'vista_mayor_costo_envio_localidades' )
    DROP VIEW LA_SELECT_NO_MURIO.vista_mayor_costo_envio_localidades
GO

CREATE VIEW LA_SELECT_NO_MURIO.vista_mayor_costo_envio_localidades AS 
    SELECT TOP 3
        du.localidad AS localidad,
        AVG(fe.costo_total_envio) AS promedio_costo_envio
    FROM LA_SELECT_NO_MURIO.BI_Fact_Envios fe
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Ubicacion du ON fe.id_ubicacion = du.id_ubicacion
    GROUP BY du.localidad
    ORDER BY AVG(fe.costo_total_envio) desc
GO
--OK

BEGIN TRANSACTION
	EXEC BI_migrar_ubicacion
    EXEC BI_migrar_cliente
    EXEC BI_migrar_Tipo_Material
    EXEC BI_migrar_turno
    EXEC BI_migrar_modelo_sillon
    EXEC BI_migrar_estado
    EXEC BI_migrar_tiempos_compras
    EXEC BI_migrar_tiempos_pedido
    EXEC BI_migrar_tiempos_factura
    EXEC BI_migrar_tiempos_envio
    EXEC BI_migrar_sucursales
    EXEC BI_migrar_ventas
    EXEC BI_migrar_compras
    EXEC BI_migrar_envios
    EXEC BI_migrar_pedidos
COMMIT TRANSACTION