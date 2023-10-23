-- Ex1-----------------------------------------------------------------------------------------------------------------
SELECT NOMBRE FROM articulos;

SELECT NOMBRE, PRECIO FROM articulos;

SELECT NOMBRE FROM articulos WHERE precio <= 200;

SELECT Nombre FROM articulos WHERE precio BETWEEN 60 AND 120;

SELECT Nombre, (Precio * 166.386) FROM articulos;

SELECT AVG(Precio) FROM articulos;

SELECT AVG(Precio) FROM articulos WHERE Fabricante=2;

SELECT COUNT(Codigo) FROM articulos WHERE Precio>=180;

SELECT Nombre, Precio 
FROM articulos
WHERE Precio>=180
ORDER BY Precio DESC, Nombre ASC;

SELECT * FROM articulos AS a, fabricantes AS f
WHERE  a.Fabricante = f.Codigo;

SELECT a.Nombre, a.Precio, f.Nombre 
FROM articulos AS a, fabricantes AS f
WHERE  a.Fabricante = f.Codigo;

SELECT AVG(Precio), fabricante
FROM articulos 
GROUP BY Fabricante;

SELECT AVG(Precio), f.Nombre 
FROM articulos AS a, fabricantes AS f
WHERE  a.Fabricante = f.Codigo
GROUP BY f.Nombre;

SELECT f.Nombre 
FROM articulos AS a, fabricantes AS f
WHERE  a.Fabricante = f.Codigo AND a.Precio>=150
GROUP BY f.Nombre;

SELECT Nombre, Precio
FROM articulos
WHERE Precio = (SELECT MIN(Precio) FROM articulos);

SELECT a.Precio, a.Nombre, f.Nombre 
FROM articulos AS a, fabricantes AS f
WHERE f.Codigo = a.Fabricante AND
a.Precio = (SELECT MAX(Precio) FROM articulos AS ar WHERE ar.Fabricante = f.Codigo);

INSERT INTO articulos (Codigo, Nombre, Precio, Fabricante) values (11, 'Altavoces', 69.99, 2);

UPDATE articulos SET Nombre = 'Impresora_Laser'  WHERE Codigo=8;

UPDATE articulos SET Precio = Precio*0.9 WHERE Codigo=8;

UPDATE articulos SET Precio = Precio-10 WHERE Precio >= 120;

-- Ex2-----------------------------------------------------------------------------------------------------------------

SELECT apellidos FROM empleados;

SELECT DISTINCT apellidos FROM empleados;

SELECT * FROM empleados WHERE apellidos = 'Smith';

SELECT * FROM empleados WHERE apellidos IN ('Smith','Rogers');

SELECT * FROM empleados WHERE Departamento = 14;

SELECT * FROM empleados WHERE Departamento IN (37, 77);

SELECT * FROM empleados WHERE apellidos LIKE 'P%';

SELECT SUM(Presupuesto) FROM departamentos;

SELECT COUNT(Dni), Departamento FROM empleados GROUP BY Departamento;

SELECT * FROM empleados AS e, departamentos AS d
WHERE  e.Departamento = d.Codigo;

SELECT e.Nombre, e.Apellidos, d.Nombre, d.Presupuesto
FROM empleados AS e, departamentos AS d
WHERE  e.Departamento = d.Codigo;

SELECT e.Nombre, e.Apellidos
FROM empleados AS e, departamentos AS d
WHERE  e.Departamento = d.Codigo AND d.Presupuesto > 60000;

SELECT * FROM departamentos
WHERE  Presupuesto > (SELECT AVG(Presupuesto) FROM departamentos);

SELECT Nombre FROM departamentos
WHERE Codigo IN (SELECT Departamento FROM empleados GROUP BY Departamento HAVING COUNT(Dni)>2);

INSERT INTO departamentos(Codigo, Nombre, Presupuesto) VALUES (11, 'Calidad', 40000);

INSERT INTO empleados(Dni, Nombre, Apellidos, Departamento) VALUES ('89267109', 'Esther', 'Vazquez', 11);

UPDATE departamentos SET Presupuesto = Presupuesto*0.9;

UPDATE empleados SET Departamento = 14 WHERE Departamento = 77;

DELETE FROM empleados WHERE Departamento = 14;

DELETE FROM empleados WHERE Departamento IN (SELECT Codigo FROM departamentos WHERE presupuesto > 60000);

DELETE FROM empleados;

-- Ex3-----------------------------------------------------------------------------------------------------------------

SELECT * FROM almacenes;

SELECT * FROM cajas WHERE Valor >= 150;

SELECT DISTINCT Contenido FROM cajas;

SELECT AVG(Valor) FROM cajas;

SELECT AVG(Valor), almacen FROM cajas GROUP BY almacen;

SELECT Almacen, AVG(Valor) 
FROM cajas
GROUP BY Almacen
HAVING AVG(Valor) > 150;

SELECT c.NumReferencia, a.Lugar
FROM cajas AS c, almacenes AS a
WHERE c.Almacen = a.Codigo;

SELECT  COUNT(NumReferencia), Almacen
FROM cajas
GROUP BY Almacen;

SELECT Codigo, Capacidad
FROM almacenes AS a
WHERE a.Capacidad < (SELECT COUNT(NumReferencia) FROM cajas AS c WHERE c.Almacen = a.Codigo);

SELECT NumReferencia FROM cajas WHERE Almacen IN(SELECT Codigo FROM almacenes WHERE Lugar = 'Bilbao');

INSERT INTO almacenes (Codigo, Lugar, Capacidad) VALUES (6, 'Barcelona', 3);

INSERT INTO cajas (NumReferencia, Contenido, Valor, Almacen) VALUES ('K98P', 'Papel', 200, 2);

UPDATE cajas AS c SET c.Valor = c.Valor*0.8 WHERE Valor > (SELECT AVG(valor) FROM cajas);

DELETE FROM cajas WHERE valor < 100;

DELETE FROM cajas AS ca WHERE ca.Almacen IN (SELECT a.Codigo FROM almacenes AS a WHERE a.Capacidad < (SELECT COUNT(NumReferencia) FROM cajas AS c WHERE c.Almacen = a.Codigo));

DELETE FROM cajas WHERE Almacen IN (
 SELECT Codigo FROM almacenes WHERE Capacidad < (
 SELECT COUNT(*) FROM cajas WHERE Almacen = Codigo ) );

-- Ex4----------------------------------------------------------------------------------------------------------------

SELECT Nombre FROM peliculas;

SELECT DISTINCT CalificacionEdad FROM peliculas;

SELECT Nombre FROM peliculas WHERE CalificacionEdad IS NULL;

SELECT  s.Codigo, s.Nombre
FROM salas s
LEFT JOIN peliculas p
ON s.pelicula = p.codigo
WHERE s.pelicula IS NULL;

SELECT  *
FROM salas s
LEFT JOIN peliculas p
ON s.pelicula = p.codigo;

SELECT  *
FROM peliculas p
LEFT JOIN salas s
ON  p.codigo =  s.pelicula;

SELECT  p.Nombre
FROM peliculas p
LEFT JOIN salas s
ON  p.codigo =  s.pelicula
WHERE s.Codigo IS NULL;

INSERT INTO peliculas (Codigo, Nombre, CalificacionEdad) VALUES(10, 'Uno, Dos, Tres', '7');

UPDATE peliculas SET CalificacionEdad='PG-13' WHERE CalificacionEdad IS NULL;

DELETE FROM salas WHERE CalificacionEdad='PG';