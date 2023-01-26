# Lab | SQL Queries - Lesson 2.5
USE sakila;
# Select all the actors with the first name ‘Scarlett’.
SELECT * FROM actor
WHERE first_name = 'Scarlett';
# How many films (movies) are available for rent and how many films have been rented?
SELECT inventory_id   FROM rental 
WHERE inventory_id= 367;
SELECT * FROM film
WHERE rental_duration < 0; # Con esto veo que todas las peliculas shan sido rentadas

# How many films (movies) are available for rent and how many films have been rented?
SELECT  COUNT(DISTINCT inventory_id),    # Count(distinct tabla) Me cuenta el numero de valores unicos en la tabla ,para este ejercicio me cuenta el numero de peliculas disponibles para renta
COUNT(rental_id) # Esta me cuenta el numero de veces que ha habido una renta sin importar la pelicula
FROM rental;

# What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM film;

# What's the average movie duration expressed in format (hours, minutes)? 
SELECT TIME_FORMAT(sec_to_time((AVG(length))*60), "%H:%i") FROM film; # SEC TO TIME toma tu tiempo que esta en segundos y te los regresa como Horas, minutos y segundos, 
#Como nosotros solo queriamos hora y minutos, aplice un Timeformat patra dar el formato que me pedian

# How many distinct (different) actors' last names are there?
SELECT  COUNT(DISTINCT last_name) From actor;

# Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(current_timestamp(), MIN(create_date))  FROM customer; #Al dia de hoy
SELECT DATEDIFF(MAX(last_update),MIN(rental_date) )  FROM rental; # 

# Show rental info with additional columns month and weekday. Get 20 results.
# Trabajaremos con la columna RENTAL_DATE
# SUBSTRING_INDEX(string, delimiter, number)
SELECT rental_date, DATE_FORMAT(CONVERT(substring_index(rental_date,' ',1),date), '%M') AS MES , DAYNAME(rental_date) AS DIA FROM rental;

# Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT rental_date, DATE_FORMAT(CONVERT(substring_index(rental_date,' ',1),date), '%M') AS MES , DAYNAME(rental_date) AS DIA, 
CASE WHEN DAYNAME(rental_date) in ('Monday','Tuesday', 'Wednesday', 'Thursday', 'friday') THEN 'Workday'
ELSE 'Weekend'
END AS day_type
FROM rental;

# How many rentals were in the last month of activity?
SELECT  COUNT(rental_id) AS rentas_last_month FROM rental WHERE rental_date = (SELECT MAX(rental_date) FROM rental); #Aqui realmente estoy trabajando sobre la ultima fecha, que en este caso es la unica del ultimo mes
SELECT  COUNT(rental_id) AS rentas_last_month FROM rental WHERE MONTH(rental_date) = 2 AND YEAR(rental_date)=2006 ; #Aqui ya especifique cual es el ultimo mes y de que año, si no hubiera especificado el año , para este caso hubiera sido lo mismo, ya que solo hay registros de febrero del ultimo año
SELECT COUNT(rental_id) FROM rental WHERE rental_date >= '2006-01-16';


