# Use sakila database.
USE sakila;
SHOW tables;
# Get all the data from tables actor, film and customer.
SELECT * FROM actor, film , customer;
# Get film titles.
SELECT title FROM film;
# Get unique list of film languages under the alias language
SELECT * FROM language; 
SELECT distinct name FROM language;
# 5.1 Find out how many stores does the company have?
SELECT count(film_id) FROM inventory;
# 5.2 Find out how many employees staff does the company have?
SELECT * FROM staff;
# 5.3 Return a list of employee first names only?
SELECT first_name FROM staff;