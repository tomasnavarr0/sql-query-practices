/* Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.*/
SELECT codigo_oficina,pais FROM oficina

/*Devuelve un listado con la ciudad y el teléfono de las oficinas de España.*/
SELECT ciudad,telefono FROM oficina
WHERE pais='España'

/* Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.*/
SELECT nombre,apellido1,apellido2,puesto 
FROM empleado
WHERE puesto!='Representante Ventas'

/* Devuelve un listado con los distintos estados por los que puede pasar un pedido.*/
SELECT estado 
FROM pedido
GROUP BY estado

/* Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.*/
SELECT codigo_pedido,codigo_cliente,fecha_esperada,fecha_entrega 
FROM pedido
WHERE fecha_entrega>fecha_esperada

/* Devuelve un listado de todos los pedidos que fueron rechazados en 2009*/
SELECT * 
FROM pedido
WHERE estado='Rechazado' AND fecha_pedido>'2008-12-31' AND fecha_pedido<'2010-01-01'

/* Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.*/

SELECT cliente.nombre_cliente,empleado.nombre,empleado.apellido1,empleado.apellido2
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado

/* Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT * FROM cliente
SELECT * FROM empleado
SELECT * FROM oficina

SELECT cliente.nombre_cliente,empleado.nombre AS nombre_vendedor, empleado.apellido1 AS apellido_vendedor,oficina.ciudad
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
INNER  JOIN oficina ON empleado.codigo_oficina=oficina.codigo_oficina

/* Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.*/

SELECT cliente.nombre_cliente,producto.gama,gama_producto.descripcion_texto
FROM cliente
INNER JOIN pedido ON  pedido.codigo_cliente=cliente.codigo_cliente
INNER JOIN detalle_pedido ON detalle_pedido.codigo_pedido=pedido.codigo_pedido
INNER JOIN producto ON producto.codigo_producto=detalle_pedido.codigo_producto
INNER JOIN gama_producto ON gama_producto.gama=producto.gama

/*¿Cuántos empleados hay en la compañía?*/
SELECT COUNT(nombre) AS CantidadDeEmpleados
FROM empleado

/*¿Cuántos clientes tiene cada país?*/
SELECT COUNT(pais) AS ClientesPorPais ,pais
FROM cliente
GROUP BY pais

/*¿Cuál fue el pago medio en 2009?*/
SELECT AVG(total) AS PromedioPago
FROM pago
WHERE fecha_pago>'2008-12-31' AND fecha_pago<'2010-01-01'


/*Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.*/
SELECT * FROM empleado
SELECT * FROM cliente

SELECT COUNT(cliente.codigo_empleado_rep_ventas) AS CantidadClientes,codigo_empleado_rep_ventas, empleado.nombre
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
GROUP BY codigo_empleado_rep_ventas,empleado.nombre
ORDER BY CantidadClientes DESC

/*Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.*/

SELECT COUNT(codigo_producto) AS TotalProductosPedidos, codigo_pedido
FROM detalle_pedido
GROUP BY codigo_pedido

/*Lista las ventas totales de los productos que hayan facturado más de 3000 euros.
Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).*/

SELECT (precio_unidad*cantidad) AS VentasTotales,codigo_pedido 
FROM detalle_pedido
WHERE (precio_unidad*cantidad)>30
GROUP BY codigo_pedido,(precio_unidad*cantidad)

/* Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. 
Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.*/
SELECT * FROM cliente
SELECT * FROM pedido

SELECT COUNT(pedido.codigo_cliente) AS PedidosCliente,cliente.codigo_cliente,cliente.nombre_cliente
FROM cliente
INNER JOIN pedido ON pedido.codigo_cliente=cliente.codigo_cliente
GROUP BY cliente.codigo_cliente,cliente.nombre_cliente
ORDER BY PedidosCliente DESC

/*Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.*/

SELECT empleado.nombre,empleado.apellido1,empleado.puesto, oficina.telefono
FROM empleado
INNER JOIN cliente ON cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
INNER JOIN oficina ON oficina.codigo_oficina=empleado.codigo_oficina
WHERE empleado.puesto='Representante Ventas'

