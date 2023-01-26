# Lab | SQL Queries - Lesson 2.6
USE sakila;
# Get release years.
SELECT DISTINCT release_year FROM film ;

# Get all films with ARMAGEDDON in the title.
SELECT title FROM film
WHERE title LIKE '%ARMAGEDDON%';

# Get all films which title ends with APOLLO.
SELECT title FROM film WHERE title LIKE '%APOLLO';

# Get 10 the longest films.
SELECT title, length FROM film ORDER BY length DESC LIMIT 10;

# How many films include Behind the Scenes content?
SELECT COUNT(title) FROM film
WHERE special_features LIKE '%Behind the Scenes%';

# Drop column picture from staff
ALTER TABLE staff
DROP COLUMN picture;

# A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE first_name='TAMMY' AND last_name='SANDERS';
INSERT INTO staff VALUES (3,'TAMMY','SANDERS',79,'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy','3072','2006-01-25 05:41:16');

/* Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
 You can use current date for the rental_date column in the rental table.
 Hint: Check the columns in the table rental and see what information you would need to add there.
 You can query those pieces of information. For eg., you would notice that you need customer_id information as well.
 To get that you can use the following query: */
 
SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'; #customer_id = 130
SELECT MAX(rental_id) FROM rental; # rental_id= 16050
SELECT film_id FROM film WHERE title = 'Academy Dinosaur' ; #Este para buscarlo en inventory
SELECT inventory_id From Inventory WHERE film_id=1; # 9
 INSERT INTO rental VALUES (16050,'2006-01-25 06:46:16',9,130,'2006-01-26 06:46:16',1,'2006-01-26 06:46:16');

# Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
# Check if there are any non-active users
SELECT * FROM customer
WHERE active=1; # 584 registros
SELECT * FROM customer
WHERE active=0; # 15 registros
# Vamos a tomar el cero como inactivo

DROP TABLE deleted_users;

# CREAMOS LA TABLA
CREATE TABLE deleted_users (
deleted_users_id smallint UNSIGNED NOT NULL AUTO_INCREMENT,
customer_id smallint UNSIGNED NOT NULL ,
email varchar(50) DEFAULT NULL,
date datetime,
CONSTRAINT  PRIMARY KEY (deleted_users_id)
);

# Insert the non active users in the table backup table
INSERT INTO deleted_users
SELECT NULL, customer_id, email, create_date FROM customer
WHERE active = 0;

# Delete the non active users from the table customer

# Me salia este error asi que tuve que desactivar el modo seguro y aplicar lo de abajo
# Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`payment`, CONSTRAINT `fk_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE)
SET FOREIGN_KEY_CHECKS=0; # option specifies whether or not to check foreign key constraints for InnoDB tables, Si queremos activarlas pues les damos 1

DELETE FROM customer
WHERE active = 0;
















