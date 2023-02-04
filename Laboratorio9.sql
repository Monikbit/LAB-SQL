# Lab | SQL Self and cross join
# In this lab, you will be using the Sakila database of movie rentals.
USE sakila;
/* Instructions
Get all pairs of actors that worked together.
Get all pairs of customers that have rented the same film more than 3 times.
Get all possible pairs of actors and films.  */

/* 1.- Get all pairs of actors that worked together.
SOLUCION SANDRA
select fa1.film_id, concat(a1.first_name, ' ', a1.last_name), concat(a2.first_name, ' ', a2.last_name)
from sakila.actor a1
inner join film_actor fa1 on a1.actor_id = fa1.actor_id
inner join film_actor fa2 on (fa1.film_id = fa2.film_id) and (fa1.actor_id > fa2.actor_id)
inner join actor a2 on a2.actor_id = fa2.actor_id; */

# LA MIA 
SELECT f1.title AS Titulo , fa1.actor_id AS IDActor1 ,CONCAT(a1.first_name,' ', a1.last_name) AS Nombre1 , fa2.actor_id AS IDActor2, CONCAT(a2.first_name,' ' , a2.last_name) AS Nombre2
FROM film_actor AS fa1
JOIN film_actor AS fa2 ON fa1.film_id = fa2.film_id  AND fa1.actor_id < fa2.actor_id  # Le pongo la condicion para eliminar duplicados aqui, para que no sea necesario llamar a la tabla actor, yo lo hice por estetica para agregar nombres
JOIN actor AS a1 ON a1.actor_id = fa1.actor_id
JOIN actor AS a2 ON a2.actor_id = fa2.actor_id 
JOIN film AS f1 ON f1.film_id = fa1.film_id
JOIN film AS f2 ON f2.film_id = fa2.film_id
ORDER BY Titulo ASC;


# 2.- Get all pairs of customers that have rented the same film more than 3 times.
# NO HAY NIGUNA PELICULA QUE SE HAYA RENTADO 6 VECES, POR LO QUE NO HAY UN PAR DE CLIENTES QUE HAYA RENTADO LA MISMA PELICULA MAS DE 3 VECES O POR LO MENOS 3 VECES

SELECT inventory_id, COUNT(rental_id) FROM sakila.rental
GROUP BY inventory_id;

SELECT * FROM rental  # Solo para comprobar que estoy contando correctamente
WHERE inventory_id = 1;

# ASI QUE LO HARE LOS PARES DE CLIENTES QUE HAYAN RENTADO  LA MISMA PELI  Y QUE ESTA PELI QUE HAYA SIDO RENTADA MAS DE 3 VECES

/* ESTA TABLA ME TRAE A LOS CLIENTES QUE HAN RENTADO LA MISMA PELICULA Y QUE ESA PELICULA HA SIDO RENTADA MAS DE 3 VECES */
# NUM DE RENTAS POR PELI, CUENTA EL NUMERO DE VECES QUE LA PELI HA SIDO RENTADA

SELECT c.customer_id AS ID , CONCAT(c.first_name, ' ', c.last_name) AS Nombre , r.inventory_id AS InvID , f.title as Titulo,  COUNT(r.rental_id)  OVER (PARTITION BY r.inventory_id) as Num_rentas_por_peli
FROM rental AS r
JOIN inventory as i ON r.inventory_id = i.inventory_id 
JOIN film as f ON f.film_id = i.film_id
JOIN customer as c ON r.customer_id = c.customer_id  
GROUP BY  r.inventory_id, r.rental_id;

# TENGO QUE HACER UN SELFJOIN DE LA TABLA DE ARRIBA 

SELECT sub2.Nombre AS Nombre1 ,  sub3.Nombre as Nombre2, sub2.Titulo , sub2.Num_rentas_por_peli AS Num_rentas FROM (SELECT * FROM(
SELECT c.customer_id AS ID , CONCAT(c.first_name, ' ', c.last_name) AS Nombre , r.inventory_id AS InvID , f.title as Titulo,  COUNT(r.rental_id)  OVER (PARTITION BY r.inventory_id) as Num_rentas_por_peli
FROM rental AS r
JOIN inventory as i ON r.inventory_id = i.inventory_id 
JOIN film as f ON f.film_id = i.film_id
JOIN customer as c ON r.customer_id = c.customer_id  
GROUP BY  r.inventory_id, r.rental_id) AS sub1
WHERE Num_rentas_por_peli > 3) AS sub2
JOIN (SELECT * FROM(
SELECT c.customer_id AS ID , CONCAT(c.first_name, ' ', c.last_name) AS Nombre , r.inventory_id AS InvID , f.title as Titulo,  COUNT(r.rental_id)  OVER (PARTITION BY r.inventory_id) as Num_rentas_por_peli
FROM rental AS r
JOIN inventory as i ON r.inventory_id = i.inventory_id 
JOIN film as f ON f.film_id = i.film_id
JOIN customer as c ON r.customer_id = c.customer_id  
GROUP BY  r.inventory_id, r.rental_id) AS sub1
WHERE Num_rentas_por_peli > 3) AS sub3
ON sub2.InvID = sub3.InvID AND sub2.ID < sub3.ID # PARA QUITAR DUPLICADOS
ORDER BY Num_rentas DESC ; 
# Se que en esta query completa no termine mostrando todo lo que fui pidiendo durante las subqueries , pero durante la construccion , me ayuda tener toda esa info en cada query

# 3.- Get all possible pairs of actors and films. ES con un cross join */

SELECT concat(first_name, ' ', last_name) AS Nombre , title AS Pelicula
FROM actor
CROSS JOIN  film;

#LA PROBAMOS 
SELECT concat(first_name, ' ', last_name) AS Nombre , title AS Pelicula
FROM actor
CROSS JOIN  film
WHERE title = 'ACADEMY DINOSAUR'; # HAY 200 ACTORES ASI QUE TIENE SENTIDO










