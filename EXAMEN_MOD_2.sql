############ Evaluación Final Módulo 2: SQL ############

-- llamo a la base de datos con la cual quiero trabajar
USE sakila;


-- Ejercicio 1: Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- query de comprobación--
 SELECT* 
	FROM film;
    
 SELECT DISTINCT title as titulo_pelicula -- distinct para sacar los valores sin duplicidades / alias para mejor comprensión (opcional)
	FROM film;
    
-- query final según lo solicitado-- 
SELECT DISTINCT title 
	FROM film;
    
-- Ejercicio 2: Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
-- query de comprobación--
 SELECT* 
	FROM film;
    
SELECT title as titulo_pelicula, rating as clasificación --  muestro el rating para corroborar que todos son "PG-13" / alias para mejor comprensión (opcional)
	FROM film 
    WHERE rating LIKE "PG-13";    -- valor a buscar "PG-13" 
 
-- query final según lo solicitado-- 
SELECT title 
	FROM film 
    WHERE rating LIKE "PG-13";    

-- Ejercicio 3: Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- query de comprobación--
 SELECT* 
	FROM film;
    
SELECT title AS titulo_pelicula, description AS descripción -- description palabra reservada en SQL pero igual funciona / alias opcionales 
	FROM film 
    WHERE description LIKE "%amazing%";    
    
-- query final según lo solicitado--   
SELECT title, description 
	FROM film 
    WHERE description LIKE "%amazing%"; 

-- Ejercicio 4: Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- query de comprobación--
 SELECT* 
	FROM film
    LIMIT 5;
    
SELECT title AS titulo_pelicula, length as duración_pelicula -- length palabra reservada pero igual funciona / alias opcionales para mejor comprensión del output
    FROM film 
    WHERE LENGTH > 120;
    
-- query final según lo solicitado--     
SELECT title 
    FROM film 
    WHERE LENGTH > 120;    

-- Ejercicio 5: Recupera los nombres de todos los actores.
-- query de comprobación--
SELECT *
	FROM ACTOR
    LIMIT 5;
  
SELECT DISTINCT first_name AS nombre  -- distinct para sacar los valores sin duplicidades / alias opcionales para mejor comprensión del output
FROM actor
ORDER BY first_name  ASC;     	   -- ordenamos por orden alfabetico 
    
-- query final según lo solicitado--  
SELECT DISTINCT first_name
FROM actor;

-- Ejercicio 6: Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
-- query de comprobación--
SELECT *
	FROM film
    LIMIT 5;
    
SELECT first_name AS nombre, last_name as apellido -- columnas que necesito mostrar / alias opcionales
	FROM actor 
    WHERE last_name LIKE "Gibson"; -- valor a filtrar
    
    
-- query final según lo solicitado--     
SELECT first_name, last_name 
	FROM actor 
    WHERE last_name LIKE "Gibson";  
    
-- ejercicio 7: Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- query de comprobación--
SELECT *
	FROM actor
    LIMIT 5;
    
SELECT actor_id, first_name as nombre -- alias opcionales
FROM actor
WHERE actor_id >= 10 AND actor_id <= 20; -- que esté entre esos numeros de id


-- query final según lo solicitado-- 
SELECT actor_id, first_name as nombre 
FROM actor
WHERE actor_id >= 10 AND actor_id <= 20;

-- ejercicio 8: Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- query de comprobación--
SELECT *
	FROM film
    LIMIT 5;
    
SELECT title as titulo_pelicula, rating as clasificción -- alias opcionales / muestro rating para corroborar el output
	FROM film
    WHERE rating NOT LIKE "%R%" AND rating NOT LIKE "%PG-13%"; -- AND para que se cumplan ambas condiciones /  encuentre "% %" caracter especifico
    
-- query final según lo solicitado--   
SELECT title 
	FROM film
    WHERE rating NOT LIKE "%R%" AND rating NOT LIKE "%PG-13%";  

-- ejercicio 9: Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
-- query de comprobación--
SELECT *
	FROM film
    LIMIT 5;

SELECT DISTINCT rating AS clasificación, count(rating) AS Cantidad_peliculas  -- DISTINCT para quitar duplicados / count para realizar el recuento / alias opcional
	FROM film
    GROUP BY rating;  -- group by para que agrupe los valores de cada clasificacion        
    
    
-- query final según lo solicitado--      
SELECT DISTINCT rating , count(rating)
	FROM film
    GROUP BY rating;  
    
    
-- Ejercicio 10: Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- query de comprobación-- Tablas: customer -> relación: customer_id -> rental 
SELECT *
	FROM customer
    LIMIT 5; 

SELECT  c.customer_id, c.first_name as nombre, c.last_name as apellido, count(rental_id) as recuento_alquileres -- count para recuento de alquileres / ALIAS OPCIONALES
	FROM customer AS c
    INNER JOIN rental AS r -- inner join porque quiero solo las coincidencias entre clientes-alquileres
    ON c.customer_id = r.customer_id -- columna comun entre las tablas 
    GROUP BY c.customer_id, c.first_name, c.last_name; -- group by agrupa por cliente para poder contar los alquileres de cada uno

-- query final según lo solicitado--  
SELECT  c.customer_id, c.first_name, c.last_name, count(rental_id) as recuento_alquileres
	FROM customer AS c
    INNER JOIN rental AS r
    ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
-- 11 Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
-- query de comprobación-- 

-- Tras revisar el esquema he determinado las que necesitaré para el ejercicio
-- Tablas necesarias: 1) category -> 2)film_category -> 3)film -> inventory -> 4)rental    
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres -- count por rental_id porque es un valor único por cada alquiler
	FROM category AS c
	INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id -- unión 1
	INNER JOIN film as f
		ON fc.film_id = f.film_id-- unión 2
	INNER JOIN inventory as i
		ON f.film_id = i.film_id -- unión 3
	INNER JOIN rental as r
		ON i.inventory_id = r.inventory_id-- unión 4
	GROUP BY c.name;
    
-- query final según lo solicitado--
SELECT c.name, COUNT(r.rental_id) AS total_alquileres
	FROM category AS c
	INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id 
	INNER JOIN film as f
		ON fc.film_id = f.film_id
	INNER JOIN inventory as i
		ON f.film_id = i.film_id
	INNER JOIN rental as r
		ON i.inventory_id = r.inventory_id
	GROUP BY c.name;


-- 12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración
-- query de comprobación-- 
SELECT *
	FROM film;
    
SELECT rating as clasificación, AVG (length) as promedio_duración -- AVG PARA BUSCAR PROMEDIOS
	FROM film
	GROUP BY rating; -- agrupamos por clasificación
    
-- query final según lo solicitado--
SELECT rating as clasificación, AVG (length) as promedio_duración 
	FROM film
    GROUP BY rating; 

-- 13 Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love"
-- query de comprobación-- 
-- Tras revisar el esquema he determinado las que necesitaré para el ejercicio
-- Tablas: 1) actor -> 2) film_actor -> 3) film

SELECT a.first_name as nombre, a.last_name as apellido , f.title as titulo_pelicula -- alias opcionales / titulo para corroborar output
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id -- union 1
   INNER JOIN film AS f
		ON fa.film_id = f.film_id -- union 2
	WHERE f.title LIKE "%Indian Love%"; 

-- query final según lo solicitado--
SELECT a.first_name, a.last_name
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
   INNER JOIN film AS f
		ON fa.film_id = f.film_id
	WHERE f.title LIKE "%Indian Love%";


-- 14 Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción
-- query de comprobación--
SELECT *
	FROM film
	LIMIT 5;
    
SELECT title AS titulo_pelicula, description AS descripción -- alias opcionales / description reservado pero funciona
	FROM film
    WHERE description like "%dog%" or "%cat%"; -- que en la descripción sea "%valor_solicitado%"
    
-- query final según lo solicitado--
    
SELECT title
	FROM film
    WHERE description like "%dog%" or "%cat%"; 
    
-- 15 Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración 
-- superior a 5 días y luego selecciona las películas correspondientes



-- 16 Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

-- 17 Encuentra el título de todas las películas que son de la misma categoría que "Family".

-- 18 Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

-- 19 Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

-- 20 Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.

-- 21 Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

-- 22.Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.

-- 23 Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los 
-- actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

-- 24 . Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.


   