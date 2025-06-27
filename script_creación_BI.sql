USE GD1C2025
GO

/**/
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

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Fact_Venta')
DROP TABLE LA_SELECT_NO_MURIO.BI_Fact_Venta
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Fact_Compras')
DROP TABLE LA_SELECT_NO_MURIO.BI_Fact_Compras
GO

IF EXISTS (SELECT name FROM sys.tables WHERE name='BI_Fact_Pedidos')
DROP TABLE LA_SELECT_NO_MURIO.BI_Fact_Pedidos
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
    mes INT NOT NULL,
    dia INT NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(--
    id_ubicacion INT IDENTITY PRIMARY KEY,
    provincia NVARCHAR(255),
    localidad NVARCHAR(255)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material(--
    id_material INT IDENTITY PRIMARY KEY,
    material_descripcion NVARCHAR(255) NOT NULL,
    material_tipo NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon(--
    id_sillon_modelo BIGINT IDENTITY PRIMARY KEY,
    sillon_modelo_nombre NVARCHAR(255) NOT NULL,
    sillon_modelo_descripcion NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Cliente (--
    id_cliente INT IDENTITY PRIMARY KEY,
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
    nro_sucursal BIGINT IDENTITY PRIMARY KEY,
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
    id_turno INT,
    id_material INT,
    id_sillon_modelo BIGINT,
    nro_sucursal BIGINT,
    cantidad INT,
    precio_promedio_venta DECIMAL(18,2)

    FOREIGN KEY (id_cliente) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Cliente(id_cliente),
    FOREIGN KEY (id_tiempo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_turno) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Turno(id_turno),
    FOREIGN KEY (id_material) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material(id_material),
    FOREIGN KEY (id_sillon_modelo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon(id_sillon_modelo),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Compras(
    id_fact_compras INT PRIMARY KEY,
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
    id_fact_envios INT PRIMARY KEY,

    id_pedido INT,
    id_ubicacion INT,
    id_cliente INT,
    id_tiempo_fecha_programada INT,
    id_tiempo_fecha_entrega INT,
    nro_sucursal BIGINT,
    importe_traslado DECIMAL(18, 2),
    importe_subida DECIMAL(18, 2),
    cantidad_envios_total INT,

    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_cliente) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Cliente(id_cliente),
    FOREIGN KEY (id_tiempo_fecha_programada) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_tiempo_fecha_entrega) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Pedidos (
    id_fact_pedidos INT PRIMARY KEY,
    id_ubicacion INT,
    id_tiempo INT,
    id_turnos INT,
    nro_sucursal BIGINT,
    cantidad_pedidos INT,
    
    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_tiempo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_turnos) REFERENCES  LA_SELECT_NO_MURIO.BI_Dim_Turno(id_turno),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal)
)
GO
/*Eliminar migraciones*/


/*Migraciones */
CREATE PROCEDURE BI_migrar_ubicacion
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Ubicacion (localidad, provincia)
        SELECT nombre_localidad, nombre_provincia FROM LA_SELECT_NO_MURIO.Localidad loc JOIN  LA_SELECT_NO_MURIO.provincia prov 
        ON prov.nro_provincia = loc.nro_provincia
    END
GO

CREATE FUNCTION LA_SELECT_NO_MURIO.getAge(@dateofbirth datetime2(6)) --Recibe una fecha de nacimiento por parámetro
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

CREATE FUNCTION LA_SELECT_NO_MURIO.getAgeRange (@age int) --Recibe una edad por parámetro y 
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

CREATE PROCEDURE BI_migrar_cliente
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Cliente (nombre, rango_etario)
        SELECT 
            cli.cliente_nombre,
            LA_SELECT_NO_MURIO.getAgeRange(LA_SELECT_NO_MURIO.getAge(cli.cliente_fecha_nacimiento))
        FROM LA_SELECT_NO_MURIO.cliente cli
        WHERE cli.cliente_fecha_nacimiento IS NOT NULL;
    END
GO

CREATE PROCEDURE BI_migrar_Tipo_Material
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material ( material_descripcion, material_tipo)
        SELECT mat.material_descripcion, mat.material_tipo FROM LA_SELECT_NO_MURIO.Material mat
    END
GO

CREATE PROCEDURE BI_migrar_turno
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Turno (turno)
        SELECT (CASE 
                WHEN DATEPART(HOUR, ped.pedido_fecha) <= 14  AND DATEPART(HOUR, ped.pedido_fecha) >= 8 THEN '08:00 - 14:00'
                WHEN DATEPART(HOUR, ped.pedido_fecha) > 14  AND DATEPART(HOUR, ped.pedido_fecha) <= 20 THEN  '14:00 - 20:00'
                END) 
        FROM LA_SELECT_NO_MURIO.pedido ped
    END
GO

CREATE PROCEDURE BI_migrar_modelo_sillon
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon ( id_sillon_modelo, sillon_modelo_nombre, sillon_modelo_descripcion)
        SELECT sm.codigo_sillon_modelo, sm.sillon_modelo_nombre, sm.sillon_modelo_descripcion 
        FROM LA_SELECT_NO_MURIO.sillon_modelo sm
    END
GO

CREATE PROCEDURE BI_migrar_estado
AS
    BEGIN
        INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Estado (estado_nombre)
        SELECT ped.pedido_estado
        FROM LA_SELECT_NO_MURIO.pedido ped
    END
GO


CREATE PROCEDURE BI_migrar_tiempos_compras
AS
    BEGIN
        DECLARE date_cursor CURSOR FOR SELECT fecha_compra FROM LA_SELECT_NO_MURIO.compra
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Anio int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        DECLARE @Dia int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Date) AND MONTH(@Date) <= 4 THEN 1
                                        WHEN 5 <= MONTH(@Date) AND MONTH(@Date) <= 8 THEN 2
                                        ELSE 3 END) 
                SET @Mes = MONTH(@Date)
                SET @Dia = DAY(@Date)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre AND dia = @Dia))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes, dia) VALUES (@Anio, @Cuatrimestre, @mes, @Dia)
                END

                FETCH date_cursor into @Date
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
GO


CREATE PROCEDURE BI_migrar_tiempos_pedido
AS
    BEGIN
        DECLARE date_cursor CURSOR FOR SELECT pedido_fecha  FROM LA_SELECT_NO_MURIO.pedido
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Anio int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int 
        DECLARE @Dia int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Date) AND MONTH(@Date) <= 4 THEN 1
                                        WHEN 5 <= MONTH(@Date) AND MONTH(@Date) <= 8 THEN 2
                                        ELSE 3 END) 
                SET @Mes = MONTH(@Date)
                SET @Dia = DAY(@Date)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre AND dia = @Dia))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes, dia) VALUES (@Anio, @Cuatrimestre, @mes, @Dia)
                END

                FETCH date_cursor into @Date
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
GO



CREATE PROCEDURE BI_migrar_tiempos_factura
AS
    BEGIN
        DECLARE date_cursor CURSOR FOR SELECT factura_fecha  FROM LA_SELECT_NO_MURIO.factura
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Anio int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        DECLARE @Dia int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Date) AND MONTH(@Date) <= 4 THEN 1
                                        WHEN 5 <= MONTH(@Date) AND MONTH(@Date) <= 8 THEN 2
                                        ELSE 3 END) 
                SET @Mes = MONTH(@Date)
                SET @Dia = DAY(@Date)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre AND dia = @Dia))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes, dia) VALUES (@Anio, @Cuatrimestre, @mes, @Dia)
                END

                FETCH date_cursor into @Date
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
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
        DECLARE @Dia int
        

        OPEN date_cursor
        FETCH date_cursor into @Date, @Fecha_Programada

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Date) AND MONTH(@Date) <= 4 THEN 1
                                        WHEN 5 <= MONTH(@Date) AND MONTH(@Date) <= 8 THEN 2
                                        ELSE 3 END) 
                SET @Mes = MONTH(@Date)
                SET @Dia = DAY(@Date)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre AND dia = @Dia))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes, dia) VALUES (@Anio, @Cuatrimestre, @mes, @Dia)
                END
                
                SET @Anio = YEAR(@Fecha_Programada)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Fecha_Programada) AND MONTH(@Fecha_Programada) <= 4 THEN 1
                                        WHEN 5 <= MONTH(@Fecha_Programada) AND MONTH(@Fecha_Programada) <= 8 THEN 2
                                        ELSE 3 END) 
                SET @Mes = MONTH(@Fecha_Programada)
                SET @Dia = DAY(@Fecha_Programada)

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre AND dia = @Dia))
                BEGIN
                    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Tiempo (anio, cuatrimestre, mes, dia) VALUES (@Anio, @Cuatrimestre, @mes, @Dia)
                END
                

                FETCH date_cursor into @Date, @Fecha_Programada
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
GO


CREATE PROCEDURE BI_migrar_sucursales 
AS
    BEGIN
    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Sucursal (nro_sucursal, sucursal_direccion, sucursal_mail, sucursal_telefono)
    SELECT suc.nro_sucursal, suc.sucursal_direccion, suc.sucursal_mail, suc.sucursal_telefono FROM LA_SELECT_NO_MURIO.sucursal suc
    END
GO
/*
CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Venta (
    id_fact_ventas INT PRIMARY KEY IDENTITY(1,1),

    id_cliente INT,
    id_tiempo INT,
    id_ubicacion INT,
    id_turno INT,
    id_material INT,
    id_sillon_modelo BIGINT,
    nro_sucursal BIGINT,
    cantidad INT,
    precio_promedio_venta DECIMAL(18,2)

    FOREIGN KEY (id_cliente) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Cliente(id_cliente),
    FOREIGN KEY (id_tiempo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_turno) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Turno(id_turno),
    FOREIGN KEY (id_material) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material(id_material),
    FOREIGN KEY (id_sillon_modelo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon(id_sillon_modelo),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal)
);
GO
*/
CREATE PROCEDURE BI_migrar_sucursales 
AS
    BEGIN
    INSERT INTO LA_SELECT_NO_MURIO.BI_Dim_Sucursal (nro_sucursal, sucursal_direccion, sucursal_mail, sucursal_telefono)
    SELECT suc.nro_sucursal, suc.sucursal_direccion, suc.sucursal_mail, suc.sucursal_telefono FROM LA_SELECT_NO_MURIO.sucursal suc
    END
GO
/*
CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Compras(
    id_fact_compras INT PRIMARY KEY,
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
    id_fact_envios INT PRIMARY KEY,

    id_pedido INT,
    id_ubicacion INT,
    id_cliente INT,
    id_tiempo_fecha_programada INT,
    id_tiempo_fecha_entrega INT,
    nro_sucursal BIGINT,
    importe_traslado DECIMAL(18, 2),
    importe_subida DECIMAL(18, 2),
    cantidad_envios_total INT,

    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_cliente) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Cliente(id_cliente),
    FOREIGN KEY (id_tiempo_fecha_programada) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_tiempo_fecha_entrega) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Pedidos (
    id_fact_pedidos INT PRIMARY KEY,
    id_ubicacion INT,
    id_tiempo INT,
    id_turnos INT,
    nro_sucursal BIGINT,
    cantidad_pedidos INT,
    
    FOREIGN KEY (id_ubicacion) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_tiempo) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_turnos) REFERENCES  LA_SELECT_NO_MURIO.BI_Dim_Turno(id_turno),
    FOREIGN KEY (nro_sucursal) REFERENCES LA_SELECT_NO_MURIO.BI_Dim_Sucursal(nro_sucursal)
)
GO
*/


CREATE VIEW LA_SELECT_NO_MURIO.vista_ganancias
AS
    SELECT fv.nro_sucursal,  dt.mes, (SUM(fv.precio_promedio_venta*fv.cantidad)-SUM(fc.cantidad_compras*fc.promedio_precio_compras)) 'Ganancias'
	FROM LA_SELECT_NO_MURIO.BI_Fact_Venta fv JOIN LA_SELECT_NO_MURIO.BI_Fact_Compras fc ON fv.nro_sucursal = fc.nro_sucursal
											JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.id_tiempo = fv.id_tiempo 
                                            AND dt.id_tiempo = fc.id_tiempo
	GROUP BY fv.nro_sucursal, dt.mes  
GO     

CREATE VIEW LA_SELECT_NO_MURIO.vista_facturacion_promedio_mensual 
AS
    SELECT AVG(fv.precio_promedio_venta) 'Factura Promedio Mensual',  dt.cuatrimestre, dt.anio, du.provincia, fv.nro_sucursal 
    FROM LA_SELECT_NO_MURIO.BI_Fact_Venta fv JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON dt.id_tiempo = fv.id_tiempo
            JOIN LA_SELECT_NO_MURIO.BI_Dim_Ubicacion du ON du.id_ubicacion = fv.id_ubicacion
    GROUP BY dt.cuatrimestre, dt.anio, du.provincia, fv.nro_sucursal 
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

CREATE VIEW LA_SELECT_NO_MURIO.vista_volumen_pedidos
AS
    SELECT dtur.turno, SUM(fp.cantidad_pedidos) 'volumen de pedidos', fp.nro_sucursal, dt.mes, dt.anio   
    FROM LA_SELECT_NO_MURIO.BI_Fact_Pedidos fp 
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt  ON dt.id_tiempo=fp.id_tiempo
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Turno dtur ON dtur.id_turno = fp.id_turnos 
    GROUP BY fp.nro_sucursal, dt.mes, dt.anio, dtur.turno  
GO

CREATE VIEW LA_SELECT_NO_MURIO.vista_conversion_pedidos
AS
    SELECT  (SUM(fp.cantidad_pedidos) / 
            (SELECT SUM(fp2.cantidad_pedidos) FROM LA_SELECT_NO_MURIO.BI_Fact_Pedidos fp2
            JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt2  ON dt2.id_tiempo=fp2.id_tiempo
            GROUP BY dt2.cuatrimestre, fp2.nro_sucursal
            ))*100 '% Conversion_pedidos',
            fp.nro_sucursal, dt.cuatrimestre
    FROM LA_SELECT_NO_MURIO.BI_Fact_Pedidos fp 
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt  ON dt.id_tiempo=fp.id_tiempo
    GROUP BY fp.nro_sucursal, dt.cuatrimestre 
GO

-- Un pedido pendiente/cancelado no tiene que ser considerado aca
CREATE VIEW LA_SELECT_NO_MURIO.vista_tiempo_promedio_fabricacion 
AS
    SELECT
        DATEDIFF(DAY, AVG(DATE(tiempo_pedido.anio, tiempo_pedido.mes, tiempo_pedido.dia)), AVG(DATE(tiempo_venta.anio, tiempo_venta.mes, tiempo_venta.dia)))),
        tiempo_pedido.cuatrimestre AS cuatrimestre,
        tiempo_pedido.anio AS anio
    FROM
        BI_Fact_Pedidos AS pedidos
    JOIN
        BI_Dim_tiempo AS tiempo_pedido ON pedidos.id_tiempo = tiempo_pedido
    UNION
        BI_fact_ventas as ventas
    JOIN
        BI_Dim_tiempo AS tiempo_venta ON ventas.id_tiempo = tiempo_venta
    WHERE BI_fact_pedido = "Entregado"
    GROUP BY tiempo_pedido.anio, tiempo_pedido.cuatrimestre
GO

CREATE VIEW LA_SELECT_NO_MURIO.vista_promedio_compras 
AS
    SELECT
        dt.mes AS mes,
        fc.promedio_precio_compras AS importe_promedio
    FROM LA_SELECT_NO_MURIO.BI_Fact_Compras fc 
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON fc.id_tiempo = dt.id_tiempo
    GROUP BY dt.mes 
GO

CREATE VIEW LA_SELECT_NO_MURIO.vista_porcentaje_cumplimiento_pedidos 
AS
    SELECT 
        dt.mes AS mes,
        CAST(SUM(CASE WHEN DATEFROMPARTS (dt.anio, dt.mes, dt.dia) <= DATEFROMPARTS (dt_entrega.anio, dt_entrega.mes, dt_entrega.dia) THEN 1 ELSE 0 END)/FE.cantidad_envios_total * 100) AS porcentaje_cumplimiento
    FROM LA_SELECT_NO_MURIO.BI_Fact_Envios fe
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt ON fe.id_tiempo_fecha_programada = dt.id_tiempo
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Tiempo dt_entrega ON fe.id_tiempo_fecha_entrega = dt_entrega.id_tiempo
    GROUP BY dt.mes
GO

CREATE VIEW LA_SELECT_NO_MURIO.vista_mayor_costo_envio_localidades AS 
    SELECT TOP 3
        du.localidad AS localidad,
        AVG(fe.importe_traslado + fe.importe_subida) AS promedio_costo_envio
    FROM LA_SELECT_NO_MURIO.BI_Fact_Envios fe
    JOIN LA_SELECT_NO_MURIO.BI_Dim_Ubicacion du ON fe.id_ubicacion = du.id_ubicacion
    GROUP BY du.localidad
    ORDER BY AVG(fe.importe_traslado + fe.importe_subida) desc
GO