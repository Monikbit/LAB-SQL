# Lab | SQL Advanced queries
# In this lab, you will be using the Sakila database of movie rentals.
USE sakila;

/* Instructions
List each pair of actors that have worked together.
For each film, list actor that has acted in more films. */ 

# List each pair of actors that have worked together.
 # OPCION 1
SET @row_number=0; # siempre hay que volver  a correr esta , sino, comenzar el row_number donde se quedo
SELECT f1.title AS Titulo , fa1.actor_id AS IDActor1 ,CONCAT(a1.first_name,' ', a1.last_name) AS Nombre1 , fa2.actor_id AS IDActor2, CONCAT(a2.first_name,' ' , a2.last_name) AS Nombre2, (@row_number:=@row_number + 1 ) AS row_num
FROM film_actor AS fa1
JOIN film_actor AS fa2 ON fa1.film_id = fa2.film_id  AND fa1.actor_id < fa2.actor_id  # Le pongo la condicion para eliminar duplicados aqui, para que no sea necesario llamar a la tabla actor, yo lo hice por estetica para agregar nombres
JOIN actor AS a1 ON a1.actor_id = fa1.actor_id
JOIN actor AS a2 ON a2.actor_id = fa2.actor_id 
JOIN film AS f1 ON f1.film_id = fa1.film_id
JOIN film AS f2 ON f2.film_id = fa2.film_id
ORDER BY Titulo ASC ;

# OPCION 2 CON CTE
SET @row_number=0;
WITH tabla1 AS ( SELECT f1.title AS Titulo , fa1.actor_id AS IDActor1 ,CONCAT(a1.first_name,' ', a1.last_name) AS Nombre1 , fa2.actor_id AS IDActor2, CONCAT(a2.first_name,' ' , a2.last_name) AS Nombre2
FROM film_actor AS fa1
JOIN film_actor AS fa2 ON fa1.film_id = fa2.film_id  AND fa1.actor_id < fa2.actor_id  # Le pongo la condicion para eliminar duplicados aqui, para que no sea necesario llamar a la tabla actor, yo lo hice por estetica para agregar nombres
JOIN actor AS a1 ON a1.actor_id = fa1.actor_id
JOIN actor AS a2 ON a2.actor_id = fa2.actor_id 
JOIN film AS f1 ON f1.film_id = fa1.film_id
JOIN film AS f2 ON f2.film_id = fa2.film_id
ORDER BY Titulo ASC)
SELECT tabla1.* , (@row_number:=@row_number + 1 ) AS row_num FROM tabla1;



# For each film, list actor that has acted in more films.
# LO QUE ENTENDI, ES QUE ESTA PIDIENDO QUE PARA CADA PELICULA BUSQUEMOS QUIEN DE SUS ACTORES TIENEN UN MAYOR  NUMERO DE ACTUACIONES Y LO ENUMEREMOS


SET @row_number=0;
WITH tabla1 AS
 ( SELECT f.film_id, f.title, sub1.*  FROM film AS F 
 JOIN ( SELECT fa.actor_id as ID , CONCAT(a.first_name,' ' , a.last_name) AS Nombre,  COUNT(*) as Num 
 FROM film_actor AS fa JOIN actor AS a ON fa.actor_id = a.actor_id 
 GROUP BY fa.actor_id 
 ORDER BY num DESC) AS sub1 
 GROUP BY sub1.Num, f.film_id , sub1.ID LIMIT 1000) 
 SELECT tabla1.* , (@row_number:=@row_number + 1 ) AS row_num FROM tabla1;
 
 
# YO QUERIA QUE ME LISTARA EL ACTOR CON MAS ACTUACIONES POR PELICULAS, PERO NO LO LOGRE 
# No super como Eliminar los registros que no eran el max(num) por actor  en cada pelicula


 

 
 


