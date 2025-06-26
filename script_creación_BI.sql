USE GD1C2025
GO

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

CREATE VIEW vista_ganancias
AS
    SELECT v.compras
    
CREATE VIEW vista_facturacion_promedio_mensual

CREATE VIEW vista_rendimiento_modelos

CREATE VIEW vista_volumen_pedidos

CREATE VIEW vista_conversion_pedidos

CREATE VIEW vista_tiempo_promedio_fabricacion

CREATE VIEW vista_promedio_compras

CREATE VIEW vista_porcentaje_cumplimiento_pedidos

CREATE VIEW vista_mayor_costo_envio_localidades