# Lab | SQL Join
# In this lab, you will be using the Sakila database of movie rentals.The database is structured as follows:

USE sakila;

/* Instructions
List the number of films per category.
Display the first and the last names, as well as the address, of each staff member.
Display the total amount rung up by each staff member in August 2005.
List all films and the number of actors who are listed for each film.
Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names. */


# List the number of films per category.
# Hay dos opciones
# Uniendo  category and film_category
SELECT  c.name, COUNT(fc.film_id) as num_peliculas
FROM category as c
INNER JOIN film_category as fc
ON c.category_id = fc.category_id
GROUP BY c.name 
ORDER BY c.name;


# Uniendo film y film category
SELECT c.name, COUNT(f.film_id) as num_peliculas
FROM film as f
inner join film_category as fc 
ON f.film_id = fc.film_id
INNER JOIN category as C ON c.category_id = fc.category_id
GROUP BY  c.name
ORDER BY c.name;

# Display the first and the last names, as well as the address, of each staff member.
# Necesito trabajar con staff y address

SELECT s.first_name, s.last_name, a.address 
FROM staff as s 
INNER JOIN address as a
ON s.address_id = a.address_id;

# Display the total amount rung up by each staff member in August 2005.
# Aqui vamor unir staff y payment

 
 SELECT  DISTINCT s.staff_id, s.first_name, s.last_name, SUM(p.amount) OVER (PARTITION BY s.staff_id ) AS Total_Monto
 FROM staff as s 
 INNER JOIN payment as p
 ON s.staff_id = p.staff_id 
 GROUP BY  p.amount, s.staff_id, p.payment_date
 HAVING EXTRACT(YEAR FROM p.payment_date)=2005
 ORDER BY Total_Monto;
 
 #  List all films and the number of actors who are listed for each film.
# Necesito hacer un join entre film y film_actor
SELECT distinct fa.film_id ,COUNT(fa.actor_id ) as num_actores
FROM film as f
JOIN film_actor as fa
ON f.film_id = fa.film_id
GROUP BY f.film_id, fa.actor_id;

SELECT fa.film_id AS Id , f.title AS Titulo, COUNT(fa.actor_id) as num_actores 
FROM film_actor as fa
JOIN film as f
ON f.film_id = fa.film_id
GROUP BY fa.film_id, f.title
ORDER BY  titulo ASC;

# Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.
SELECT c.customer_id , c.first_name AS nombre , c.last_name AS apellido, SUM(p.amount) AS monto_pagado
From customer AS c
INNER JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY apellido ASC;







