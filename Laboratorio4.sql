/* Lab | SQL Queries - Lesson 2.7 Part 1

# In this activity we are going to do some database maintenance 
# In the current database we only have information on movies for the year 2006. 
# Now we have received the film catalog for 2020 as well. For this new data we will create another table and bulk insert all the data there. 
# Code to create a new table has been provided below. */

USE sakila;

DROP TABLE IF EXISTS films_2020;
CREATE TABLE `films_2020` (
    `film_id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `release_year` YEAR(4) DEFAULT NULL,
    `language_id` TINYINT(3) UNSIGNED NOT NULL,
    `original_language_id` TINYINT(3) UNSIGNED DEFAULT NULL,
    `rental_duration` INT(6),
    `rental_rate` DECIMAL(4 , 2 ),
    `length` SMALLINT(5) UNSIGNED DEFAULT NULL,
    `replacement_cost` DECIMAL(5 , 2 ) DEFAULT NULL,
    `rating` ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') DEFAULT NULL,
    PRIMARY KEY (`film_id`),
    CONSTRAINT FOREIGN KEY (`original_language_id`)
        REFERENCES `language` (`language_id`)
        ON DELETE RESTRICT ON UPDATE CASCADE
)  ENGINE=INNODB AUTO_INCREMENT=1003 DEFAULT CHARSET=UTF8;

/* #We have just one item for each film, and all will be placed in the new table. 
# For 2020, the rental duration will be 3 days, with an offer price of `2.99€` and a replacement cost of `8.99€` 
# (these are all fixed values for all movies for this year). 
# The catalog is in a CSV file named **films_2020.csv** that can be found at `files_for_lab` folder. */

# - Add the new films to the database.
# - Update information on `rental_duration`, `rental_rate`, and `replacement_cost`.

### Hint
# You might have to use the following commands to set bulk import option to `ON`:
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

 #Add the new films to the database.
LOAD DATA LOCAL INFILE '/Users/monik/OneDrive/Escritorio/Ironhack/SQL/Laboratorios/films_2020.csv' -- provide the complete path of the file
INTO TABLE films_2020
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(film_id,title,description,release_year,language_id,original_language_id,rental_duration,rental_rate,length,replacement_cost,rating);

SELECT * FROM films_2020;

# - Update information on `rental_duration`, `rental_rate`, and `replacement_cost`.

update films_2020
set rental_duration = 3, rental_rate = 2.99, replacement_cost = 8.99;

/* You might not see the results right away. 
#You might have to click on another table and then click back on the films_2020 to see the changes implemented. 
#This is one way to refresh the table. You can also use the refresh button to see the changes.
#You can also run the instruction */

select * from films_2020; 

# Part 2
# Lab | SQL Queries - Lesson 2.7 Part 2

/* In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.
 You have been using this database for a couple labs already, but if you need to get the data again, refer to the official [installation link](https://dev.mysql.com/doc/sakila/en/sakila-installation.html).
# The database is structured as follows:
# ![DB schema](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/database-sakila-schema.png) */

/* Instructions

#1. In the table actor, what last names are not repeated? For example if you would sort the data in the table actor by last_name, 
#you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
#These three actors have the same last name. So we do not want to include this last name in our output. 
#Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list. */

select last_name from sakila.actor
group by last_name
having count(*) = 1;

#2. Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include 
# the last names of the actors where the last name was present more than once

select last_name from sakila.actor
group by last_name
having count(*) > 1;

#3. Using the rental table, find out how many rentals were processed by each employee.
select staff_id, count(*) from sakila.rental
group by staff_id;

SELECT count(*) FROM rental;

#4. Using the film table, find out how many films were released.
select release_year, count(*) as num_films from sakila.film
group by release_year
order by release_year;

#4. NEW QUESTION: Using the film table, find out how many films have a replacement cost over 25.
select replacement_cost,count(*) from sakila.film
group by replacement_cost
having replacement_cost>25;

#5. Using the film table, find out how many films there are of each rating.
select rating, count(*) as num_films from sakila.film
group by rating;

#6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places 
select rating, round(avg(length),2) as avg_duration from sakila.film
group by rating
order by avg_duration desc;

#7. Which kind of movies (rating) have a mean duration of more than two hours?
select rating, round(avg(length),2) as avg_duration from sakila.film
group by rating
having avg_duration > 120
order by avg_duration desc;




