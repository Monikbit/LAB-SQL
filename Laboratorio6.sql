/* # Lab | SQL Queries 9
In this lab, you will be using the Sakila database of movie rentals. You have been using this database for a couple labs already,
 but if you need to get the data again, refer to the official installation link. */
 
 /*Instructions
In this lab we will find the customers who were active in consecutive months of May and June. Follow the steps to complete the analysis.
Create a table rentals_may to store the data from rental table with information for the month of May.
Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
Create a table rentals_june to store the data from rental table with information for the month of June.
Insert values in the table rentals_june using the table rental, filtering values only for the month of June.
Check the number of rentals for each customer for May.
Check the number of rentals for each customer for June.*/

Use sakila;

# Create a table rentals_may to store the data from rental table with information for the month of May.
CREATE TABLE rental_may (
  rental_may_id INT NOT NULL,
  rental_date DATETIME NOT NULL,
  inventory_id MEDIUMINT UNSIGNED NOT NULL,
  customer_id SMALLINT UNSIGNED NOT NULL,
  return_date DATETIME DEFAULT NULL,
  staff_id TINYINT UNSIGNED NOT NULL,
  last_update TIMESTAMP NOT NULL 
);

ALTER TABLE `sakila`.`rental_may` 
CHANGE COLUMN `rental_may_id` `rental_may_id` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`rental_may_id`);

# Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
INSERT INTO rental_may
	SELECT * FROM rental
	HAVING EXTRACT(MONTH FROM rental_date) = 5;
    
# Create a table rentals_june to store the data from rental table with information for the month of June.
CREATE TABLE rental_june (
  rental_june_id INT NOT NULL,
  rental_date DATETIME NOT NULL,
  inventory_id MEDIUMINT UNSIGNED NOT NULL,
  customer_id SMALLINT UNSIGNED NOT NULL,
  return_date DATETIME DEFAULT NULL,
  staff_id TINYINT UNSIGNED NOT NULL,
  last_update TIMESTAMP NOT NULL 
);
    
ALTER TABLE `sakila`.`rental_june` 
CHANGE COLUMN `rental_june_id` `rental_june_id` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`rental_june_id`);
    
# Insert values in the table rentals_may using the table rental, filtering values only for the month of June.
INSERT INTO rental_june
	SELECT * FROM rental
	HAVING EXTRACT(MONTH FROM rental_date) = 6;
    
# Check the number of rentals for each customer for May.
SELECT c.customer_id,  c.first_name as nombre, c.last_name as apellido,  COUNT(r.rental_may_id) as num_rentas
FROM customer as c
INNER JOIN rental_may as r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY num_rentas DESC ;

# Check the number of rentals for each customer for June.
SELECT c.customer_id,  c.first_name as nombre, c.last_name as apellido,  COUNT(r.rental_june_id) as num_rentas
FROM customer as c
INNER JOIN rental_june as r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY num_rentas DESC ;




