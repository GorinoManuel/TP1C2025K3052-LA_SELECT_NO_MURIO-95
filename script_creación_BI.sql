USE GD1C2025
GO

/* creación de tablas */

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Pedido(
    id_pedido INT IDENTITY PRIMARY KEY,
    estado NVARCHAR(255) NOT NULL,
    costo_envio_total DECIMAL(18,2),
    fecha_programada DATETIME2(6),
    fecha_de_entrega DATETIME2(6),
    fecha_pedido DATETIME2(6)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Turno(
    id_turno INT IDENTITY PRIMARY KEY
   -- turno 
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Tiempo(
    id_tiempo INT IDENTITY PRIMARY KEY,
    anio INT NOT NULL,
    cuatrimestre INT,
    mes INT
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Ubicacion(
    id_ubicacion INT IDENTITY PRIMARY KEY,
    provincia NVARCHAR(255),
    localidad NVARCHAR(255)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Tipo_Material(
    id_material INT IDENTITY PRIMARY KEY,
    material_tipo NVARCHAR(255) NOT NULL,
    material_precio DECIMAL(38,2) NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Modelo_Sillon(
    codigo_sillon_modelo BIGINT IDENTITY PRIMARY KEY,
    sillon_modelo_nombre NVARCHAR(255) NOT NULL,
    sillon_modelo_precio DECIMAL (18,2) NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Cliente (
    id_ INT IDENTITY PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    rango_etario NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Compra (
    id_compra INT IDENTITY PRIMARY KEY,
    nro_sucursal INT NOT NULL,
    --razon_social_proveedor INT NOT NULL,
    --cuit_proveedor INT NOT NULL,
    fecha_de_compra DATETIME2 NOT NULL,
    total_compra DECIMAL(18,2) NOT NULL,
    turno NVARCHAR(255) NOT NULL -- A revisar
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Dim_Estado(
    id_estado INT IDENTITY PRIMARY KEY,
    estado_nombre NVARCHAR(255)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Venta (
    id_fact_ventas INT PRIMARY KEY IDENTITY(1,1),

    id_cliente INT,
    id_tiempo INT,
    id_ubicacion INT,
    id_turno INT,
    id_material INT,
    id_modelo_sillon INT,
    id_estado_pedido INT,

    cantidad INT,
    monto_total DECIMAL(18,2),

    FOREIGN KEY (id_cliente) REFERENCES BI_Cliente(id_cliente),
    FOREIGN KEY (id_tiempo) REFERENCES BI_Tiempo(id_tiempo),
    FOREIGN KEY (id_ubicacion) REFERENCES BI_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_turno) REFERENCES BI_Turno(id_turno),
    FOREIGN KEY (id_material) REFERENCES BI_Material(id_material),
    FOREIGN KEY (id_modelo_sillon) REFERENCES BI_Modelo_Sillon(id_modelo_sillon),
    FOREIGN KEY (id_estado_pedido) REFERENCES BI_Estado_Pedido(id_estado_pedido)
)
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Compras(
    id_fact_compras INT PRIMARY KEY,
    id_material INT,
    id_tiempo INT,
    id_ubicacion INT,

    cantidad_compras INT,
    monto_total_compras DECIMAL(18,2),

    FOREIGN KEY (id_material) REFERENCES BI_Dim_Tipo_Material(id_material),
    FOREIGN KEY (id_tiempo) REFERENCES BI_Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_ubicacion) REFERENCES BI_Dim_Ubicacion(id_ubicacion)
);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Envios(
    id_fact_envios INT PRIMARY KEY,

    id_pedido INT,
    id_ubicacion INT,
    id_cliente INT,
    id_tiempo INT,

    FOREIGN KEY (id_pedido) REFERENCES BI_Dim_Pedido(id_pedido),
    FOREIGN KEY (id_ubicacion) REFERENCES BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_cliente) REFERENCES BI_Dim_Cliente(id_cliente),
    FOREIGN KEY (id_tiempo) REFERENCES BI_Dim_Tiempo(id_tiempo)

);
GO

CREATE TABLE LA_SELECT_NO_MURIO.BI_Fact_Pedidos (
    id_fact_pedidos INT PRIMARY KEY,

    id_pedido INT,
    id_ubicacion INT,
    id_tiempo INT,

    cantidad_pedididos INT,

    FOREIGN KEY (id_pedido) REFERENCES BI_Dim_Pedido(id_pedido),
    FOREIGN KEY (id_ubicacion) REFERENCES BI_Dim_Ubicacion(id_ubicacion),
    FOREIGN KEY (id_tiempo) REFERENCES BI_Dim_Tiempo(id_tiempo)
)
GO
/*
N_TC*/
/*
Ganancias: Total de ingresos (facturacion) - total de egresos (compras), por 
cada mes, por cada sucursal. 

Factura promedio mensual. Valor promedio de las facturas (en $) segtin la 
provincia de la sucursal para cada cuatrimestre de cada afio. Se calcula en 
funcion de la sumatoria del importe de las facturas sobre el total de las mismas 
durante dicho periodo. 

Rendimiento de modelos. Los 3 modelos con mayores ventas para cada 
cuatrimestre de cada afio segtin la localidad de la sucursal y rango etario de los 
clientes. 

Volumen de pedidos. Cantidad de pedidos registrados por turno, por sucursal 
segtin el mes de cada afio. 

Conversion de pedidos. Porcentaje de pedidos segtin estado, por cuatrimestre y 
sucursal. 

Tiempo promedio de fabricacién: Tiempo promedio que tarda cada sucursal 
entre que se registra un pedido y registra la factura para el mismo. Por 
cuatrimestre. 

Promedio de Compras: importe promedio de compras por mes. 
Compras por Tipo de Material. Importe total gastado por tipo de material, 
sucursal y cuatrimestre. 

Porcentaje de cumplimiento de envios en los tiempos programados por mes. 
Se calcula teniendo en cuenta los envios cumplidos en fecha sobre el total de 
envios para el periodo. 

Localidades que pagan mayor costo de envio. Las 3 localidades (tomando la 
localidad del cliente) con mayor promedio de costo de envio (total). 
*/

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
            LA_SELECT_NO_MURIO.getAgeRange(LA_SELECT_NO_MURIO.getAge(cli.fecha_de_nacimiento))
        FROM LA_SELECT_NO_MURIO.cliente cli
        WHERE cli.fecha_de_nacimiento IS NOT NULL;
    END
GO

CREATE PROCEDURE BI_migrar_tiempos_compras
AS
    BEGIN
        DECLARE date_cursor CURSOR FOR SELECT fecha_compra FROM LA_SELECT_NO_MURIO.compra
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Año int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Date) AND MONTH(@Date) <= 6 THEN 1
                                        ELSE 2 END) 
                SET @Mes = MONTH(@Date)
                

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre))
                BEGIN
                    INSERT INTO DROP_TABLE.BI_dim_tiempos (anio, mes, cuatrimestre) VALUES (@Anio, @Mes, @Cuatrimestre)
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
        DECLARE @Año int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Date) AND MONTH(@Date) <= 6 THEN 1
                                        ELSE 2 END) 
                SET @Mes = MONTH(@Date)
                

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre))
                BEGIN
                    INSERT INTO DROP_TABLE.BI_dim_tiempos (anio, mes, cuatrimestre) VALUES (@Anio, @Mes, @Cuatrimestre)
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
        DECLARE @Año int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Date) AND MONTH(@Date) <= 6 THEN 1
                                        ELSE 2 END) 
                SET @Mes = MONTH(@Date)
                

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre))
                BEGIN
                    INSERT INTO DROP_TABLE.BI_dim_tiempos (anio, mes, cuatrimestre) VALUES (@Anio, @Mes, @Cuatrimestre)
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
        DECLARE date_cursor CURSOR FOR SELECT fecha_de_entrega  FROM LA_SELECT_NO_MURIO.envio
        
        DECLARE @Date DATETIME2(6)
        DECLARE @Año int
        DECLARE @Cuatrimestre int
        DECLARE @Mes int
        

        OPEN date_cursor
        FETCH date_cursor into @Date

        WHILE(@@FETCH_STATUS = 0)
            BEGIN
                SET @Anio = YEAR(@Date)
                SET @Cuatrimestre = (CASE WHEN 1 <= MONTH(@Date) AND MONTH(@Date) <= 6 THEN 1
                                        ELSE 2 END) 
                SET @Mes = MONTH(@Date)
                

                IF NOT EXISTS (SELECT 1 FROM LA_SELECT_NO_MURIO.BI_Dim_Tiempo WHERE (anio = @Anio AND mes = @Mes AND @Cuatrimestre = cuatrimestre))
                BEGIN
                    INSERT INTO DROP_TABLE.BI_dim_tiempos (anio, mes, cuatrimestre) VALUES (@Anio, @Mes, @Cuatrimestre)
                END

                FETCH date_cursor into @Date
            END
        CLOSE date_cursor
        DEALLOCATE date_cursor
    END
GO


CREATE VIEW LA_SELECT_NO_MURIO.vista_ganancias
AS
    SELECT   FROM LA_SELECT_NO_MURIO.BI_Fact_compras JOIN  ON 
    
CREATE VIEW LA_SELECT_NO_MURIO.vista_facturacion_promedio_mensual AS

-- Segun localidad y rango etario (top 3)
CREATE VIEW LA_SELECT_NO_MURIO.vista_rendimiento_modelos
AS
    SELECT
        sillon.codigo_sillon,
        localidad.nro_localidad,
        

CREATE VIEW LA_SELECT_NO_MURIO.vista_volumen_pedidos

CREATE VIEW LA_SELECT_NO_MURIO.vista_conversion_pedidos

CREATE VIEW LA_SELECT_NO_MURIO.vista_tiempo_promedio_fabricacion

CREATE VIEW LA_SELECT_NO_MURIO.vista_promedio_compras

CREATE VIEW LA_SELECT_NO_MURIO.vista_porcentaje_cumplimiento_pedidos

CREATE VIEW LA_SELECT_NO_MURIO.vista_mayor_costo_envio_localidades