#  Lab | SQL Joins on multiple tables
# In this lab, you will be using the Sakila database of movie rentals.
USE sakila;
/* Instructions
Write a query to display for each store its store ID, city, and country.
Write a query to display how much business, in dollars, each store brought in.
What is the average running time of films by category?
Which film categories are longest?
Display the most frequently rented movies in descending order.
List the top five genres in gross revenue in descending order.
Is "Academy Dinosaur" available for rent from Store 1? */

# Write a query to display for each store its store ID, city, and country.
# Hay que conectar store con adress a travez del address id
# y de adress con city_id, y de city con country  
# city_id y country_id estan en la tabla city
# Quiero que mi tabla muestre
# store_id City_name y Country_name

SELECT s.store_id as ID, c.city as Ciudad, co.country as Pais
FROM store as s
INNER JOIN address as a 
ON s.address_id = a.address_id
INNER JOIN city as c
ON a.city_id = c.city_id
INNER JOIN country as co
ON c.country_id = co.country_id;

# Write a query to display how much business, in dollars, each store brought in.
# TENGO QUE UNIR STORE Y PAYMENT


SELECT  distinct s.store_id AS ID, c.city AS Ciudad, co.country as Pais ,CONCAT('US$ ', SUM(p.amount) OVER (PARTITION BY staff_id)) AS monto 
FROM payment as p
INNER JOIN store AS s
ON p.staff_id = s.manager_staff_id
INNER JOIN address as a 
ON s.address_id = a.address_id
INNER JOIN city as c
ON a.city_id = c.city_id
INNER JOIN country as co
ON c.country_id = co.country_id;

# What is the average running time of films by category?
# HAY QUE HACER UN JOIN ENTRE FILM Y FILM_CATEGORY Y cateogry Y OBTENER EL PROMEDIO
# Quiero que me muestre la  el id de la categori, el nombre de la categoria y la longitud de la peli 

SELECT  DISTINCT fc.category_id as ID_Categoria, c.name AS Nombre , AVG(f.length) OVER (PARTITION BY c.name) as Promedio
FROM film_category AS fc
JOIN film as f
ON fc.film_id = f.film_id
JOIN category AS C
ON c.category_id = fc.category_id
GROUP BY fc.category_id, f.length
ORDER BY Promedio DESC LIMIT 3;


# $ Display the most frequently rented movies in descending order.

SELECT f.film_id, f.title AS Titulo, count(rental_id) AS num_rentas
FROM inventory AS i
inner join rental AS r 
ON i.inventory_id=r.inventory_id
INNER JOIN film AS f 
ON f.film_id = i.film_id
GROUP BY  f.film_id, f.title
ORDER BY   num_rentas DESC  ;

# List the top five genres in gross revenue in descending order.

# TENGO QUE UNIR LA TABLA PAYMENT CON LA TABLA CATEGORY
# CATEGORY SE UNE A FILM CATEGORY ATRAVEZ DE CATEGORY_ID
# FILM CATEGORY SE UNE A INVENTORY EN FILM_ID
# INVENTORY SE UNE CON RENTAL EN INVENTORY_ID 
# RENTAL SE UNE CON PAYMENT EN RENTAL_ID
# QUIERO MOSTRAR EL ID DE CATEGORIA, EL NOMBRE DE LA CATEGORIA Y LOS INGRESOS EN ORDEN DESCENDENTE 
# TAMBIEN MOSTRARE EL NUMERO DE RENTAS DE CADA PELICULA

SELECT DISTINCT  fc.category_id , c.name , COUNT(r.rental_id) OVER (PARTITION BY fc.category_id) AS num_rentass, SUM(p.amount) OVER (PARTITION BY fc.category_id ) AS ingresos
FROM rental AS r
JOIN inventory as i
ON r.inventory_id = i.inventory_id
JOIN film_category AS fc
ON fc.film_id = i.film_id
JOIN category AS c
ON fc.category_id = c.category_id
JOIN payment AS p
ON r.rental_id = p.rental_id
GROUP BY fc.category_id, r.rental_id, p.amount, c.name
ORDER BY ingresos DESC ; 

# Is "Academy Dinosaur" available for rent from Store 1?
# Quiero encontrar cuantas peliculas en el inventario de Academy Dinosour hay, y hacer una busqueda para la tienda 1

SELECT f.film_id AS ID_Peli , i.store_id AS ID_Tienda ,f.title AS Nombre , COUNT(f.film_id) AS '#'
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE i.store_id = 1 AND f.title = 'ACADEMY DINOSAUR'
GROUP BY f.film_id, f.title, i.store_id;









