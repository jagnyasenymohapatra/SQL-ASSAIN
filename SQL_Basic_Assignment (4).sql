/*    SQL Basics
Assignment Questions And Answers */
/* 
1. Create a table called employees with the following structure:
   - emp_id (integer, should not be NULL and should be a primary key)
   - emp_name (text, should not be NULL)
   - age (integer, should have a check constraint to ensure the age is at least 18)
   - email (text, should be unique for each employee)
   - salary (decimal, with a default value of 30,000)
   Write the SQL query to create the above table with all constraints.
*/

CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000.00
);

/* 
2. Explain the purpose of constraints and how they help maintain data integrity in a database. 
   Provide examples of common types of constraints.
*/
-- Constraints enforce rules on data in tables to maintain accuracy and integrity.
-- Common types:
--  - PRIMARY KEY: Ensures each row is unique.
--  - FOREIGN KEY: Enforces referential integrity between tables.
--  - NOT NULL: Disallows NULL values.
--  - UNIQUE: Ensures all values in a column are different.
--  - CHECK: Restricts values based on a condition.
--  - DEFAULT: Sets a default value if none is provided.

/* 
3. Why would you apply the NOT NULL constraint to a column? 
   Can a primary key contain NULL values? Justify your answer.
*/
-- NOT NULL ensures that a column always contains a value.
-- A primary key cannot have NULL values because:
--  - It must uniquely identify each row.
--  - NULL represents an unknown or missing value, which breaks uniqueness.

/* 
4. Explain the steps and SQL commands used to add or remove constraints on an existing table. 
   Provide an example for both adding and removing a constraint.
*/
-- Add a constraint:
ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age >= 18);

-- Remove a constraint (example, constraint named 'chk_age'):
ALTER TABLE employees DROP CONSTRAINT chk_age;

/* 
5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
   Provide an example of an error message that might occur when violating a constraint.
*/
-- Violating constraints causes errors. Example:
-- Trying to insert NULL into emp_name when it's NOT NULL:
-- ERROR 1048 (23000): Column 'emp_name' cannot be null

/* 
6. You created a products table without constraints. Now,
   - product_id should be a primary key
   - price should have a default value of 50.00
*/
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

/* 
7. You have two tables:
   Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
*/
SELECT student.student_name, class.class_name
FROM student
INNER JOIN class ON student.class_id = class.class_id;

/* 
8. Write a query that shows all order_id, customer_name, and product_name, ensuring all products are listed 
   even if they are not associated with an order.
*/
SELECT o.order_id, c.customer_name, p.product_name
FROM product p
LEFT JOIN orders o ON p.product_id = o.product_id
LEFT JOIN customer c ON o.customer_id = c.customer_id;

/* 
9. Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
*/
SELECT p.product_name, SUM(s.amount) AS total_sales
FROM product p
INNER JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name;

/* 
10. Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer
   using an INNER JOIN between all three tables.
*/
SELECT o.order_id, c.customer_name, o.quantity
FROM orders o
INNER JOIN customer c ON o.customer_id = c.customer_id
INNER JOIN product p ON o.product_id = p.product_id;






/* SQL COMMANDS */

/*
1 - Identify the primary keys and foreign keys in maven movies db. Discuss the differences

Primary Key: A column (or set of columns) that uniquely identifies each row in a table.
Foreign Key: A column that creates a relationship between two tables by referencing the primary key of another table.
*/

-- List all primary keys in the Maven Movies database
SELECT
    table_name,
    column_name,
    constraint_name
FROM information_schema.key_column_usage
WHERE constraint_name LIKE 'PRIMARY'
  AND table_schema = 'sakila'; -- change this to your DB name if needed

-- List all foreign keys in the Maven Movies database
SELECT
    table_name,
    column_name,
    constraint_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.key_column_usage
WHERE referenced_table_name IS NOT NULL
  AND table_schema = 'sakila'; -- change this to your DB name if needed

/*
2 - List all details of actors
*/
SELECT * FROM actor;

/*
3 - List all customer information from DB.
*/
SELECT * FROM customer;

/*
4 - List different countries.
*/
SELECT DISTINCT country FROM country;

/*
5 - Display all active customers.
*/
SELECT * FROM customer WHERE active = 1;

/*
6 - List of all rental IDs for customer with ID 1.
*/
SELECT rental_id FROM rental WHERE customer_id = 1;

/*
7 - Display all the films whose rental duration is greater than 5.
*/
SELECT * FROM film WHERE rental_duration > 5;

/*
8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
*/
SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

/*
9 - Display the count of unique first names of actors.
*/
SELECT COUNT(DISTINCT first_name) FROM actor;

/*
10 - Display the first 10 records from the customer table.
*/
SELECT * FROM customer LIMIT 10;

/*
11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
*/
SELECT * FROM customer WHERE first_name LIKE 'b%' LIMIT 3;

/*
12 - Display the names of the first 5 movies which are rated as ‘G’.
*/
SELECT title FROM film WHERE rating = 'G' LIMIT 5;

/*
13 - Find all customers whose first name starts with "a".
*/
SELECT * FROM customer WHERE first_name LIKE 'a%';

/*
14 - Find all customers whose first name ends with "a".
*/
SELECT * FROM customer WHERE first_name LIKE '%a';

/*
15 - Display the list of first 4 cities which start and end with ‘a’.
*/
SELECT city FROM city WHERE city LIKE 'a%a' LIMIT 4;

/*
16 - Find all customers whose first name have "NI" in any position.
*/
SELECT * FROM customer WHERE first_name LIKE '%NI%';

/*
17 - Find all customers whose first name have "r" in the second position.
*/
SELECT * FROM customer WHERE first_name LIKE '_r%';

/*
18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
*/
SELECT * FROM customer WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

/*
19 - Find all customers whose first name starts with "a" and ends with "o".
*/
SELECT * FROM customer WHERE first_name LIKE 'a%o';

/*
20 - Get the films with pg and pg-13 rating using IN operator.
*/
SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

/*
21 - Get the films with length between 50 to 100 using between operator.
*/
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

/*
22 - Get the top 50 actors using limit operator.
*/
SELECT * FROM actor LIMIT 50;

/*
23 - Get the distinct film ids from inventory table.
*/
SELECT DISTINCT film_id FROM inventory;






/* FUNCTIONS */



/*
Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.
*/
SELECT COUNT(*) AS total_rentals FROM rental;

/*
Question 2:
Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.
*/
SELECT AVG(rental_duration) AS average_rental_duration FROM film;

/*
Question 3:
Display the first name and last name of customers in uppercase.
Hint: Use the UPPER () function.
*/
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper FROM customer;

/*
Question 4:
Extract the month from the rental date and display it alongside the rental ID.
Hint: Employ the MONTH() function.
*/
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

/*
Question 5:
Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.
*/
SELECT customer_id, COUNT(*) AS rental_count FROM rental GROUP BY customer_id;

/*
Question 6:
Find the total revenue generated by each store.
Hint: Combine SUM() and GROUP BY.
*/
SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
JOIN store ON staff.store_id = store.store_id
GROUP BY store.store_id;

/*
Question 7:
Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use COUNT () and GROUP BY.
*/
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

/*
Question 8:
Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY.
*/
SELECT l.name AS language, AVG(f.rental_rate) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;




/* JOINS */

/*
Question 9:
Display the title of the movie, customer’s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables.
*/
SELECT f.title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

/*
Question 10:
Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film_actor, film, and actor tables.
*/
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

/*
Question 11:
Retrieve the customer names along with the total amount they've spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
*/
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

/*
Question 12:
List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
*/
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, f.title;


/* Advanced Joins and GROUP BY: */

/*
Question 13:
Display the top 5 rented movies along with the number of times they've been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT() and GROUP BY, and limit the results.
*/
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

/*
Question 14:
Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
*/
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;


/* WINDOWS FUNCTION */


/*
Question 1:
Rank the customers based on the total amount they've spent on rentals.
*/
SELECT customer_id, first_name, last_name, SUM(amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS ranking
FROM payment
JOIN customer USING(customer_id)
GROUP BY customer_id;

/*
Question 2:
Calculate the cumulative revenue generated by each film over time.
*/
SELECT f.title, p.payment_date, SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;

/*
Question 3:
Determine the average rental duration for each film, considering films with similar lengths.
*/
SELECT film_id, title, length, rental_duration, 
       AVG(rental_duration) OVER (PARTITION BY length) AS avg_duration_similar_length
FROM film;

/*
Question 4:
Identify the top 3 films in each category based on their rental counts.
*/
WITH RankedFilms AS (
    SELECT c.name AS category_name, 
           f.title, 
           COUNT(r.rental_id) AS rental_count,
           RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name, f.title, c.category_id
)
SELECT category_name, title, rental_count, rank
FROM RankedFilms
WHERE rank <= 3;

/*
Question 5:
Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
*/
WITH CustomerRentalCounts AS (
    SELECT 
        c.customer_id, 
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
        COUNT(r.rental_id) AS total_rentals
    FROM rental r
    JOIN customer c ON r.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT 
    customer_id, 
    customer_name, 
    total_rentals, 
    total_rentals - AVG(total_rentals) OVER () AS rental_difference
FROM CustomerRentalCounts;


/*
Question 6:
Find the monthly revenue trend for the entire rental store over time.
*/
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, SUM(amount) AS total_revenue,
       SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) AS cumulative_revenue
FROM payment
GROUP BY month;

/*
Question 7:
Identify the customers whose total spending on rentals falls within the top 20% of all customers.
*/
WITH CustomerSpending AS (
    SELECT customer_id, SUM(amount) AS total_spent,
           NTILE(5) OVER (ORDER BY SUM(amount) DESC) AS spending_bracket
    FROM payment
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, cs.total_spent
FROM CustomerSpending cs
JOIN customer c ON cs.customer_id = c.customer_id
WHERE cs.spending_bracket = 1;

/*
Question 8:
Calculate the running total of rentals per category, ordered by rental count.
*/
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals,
       SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS running_total
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name;

/*
Question 9:
Find the films that have been rented less than the average rental count for their respective categories.
*/
WITH CategoryAverage AS (
    SELECT c.name AS category_name, f.film_id, f.title, COUNT(r.rental_id) AS rental_count,
           AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id) AS avg_rentals
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.category_id, f.film_id, f.title
)
SELECT film_id, title, category_name, rental_count, avg_rentals
FROM CategoryAverage
WHERE rental_count < avg_rentals;

/*
Question 10:
Identify the top 5 months with the highest revenue and display the revenue generated in each month.
*/
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, SUM(amount) AS total_revenue
FROM payment
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 5;

/* NORMALIZATION AND CTE */

/*
Question 1:
First Normal Form (1NF):
Identify a table in the Sakila database that violates 1NF. Explain how you 
would normalize it to achieve 1NF.
*/
-- Answer:
-- The `address` table violates 1NF if it stores multiple phone numbers in a single column.
-- Solution: Create a separate table for phone numbers.


CREATE TABLE phone_number (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    address_id INT,
    phone VARCHAR(15),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

/*
Question 2:
Second Normal Form (2NF):
Choose a table in Sakila and describe how you would determine whether it is in 2NF.
If it violates 2NF, explain the steps to normalize it.
*/
-- Answer:
-- The `film_actor` table violates 2NF if actor birthdate is stored in it since it depends only on `actor_id`.
-- Solution: Separate actor details into another table.


CREATE TABLE actor_details (
    actor_id INT PRIMARY KEY,
    birthdate DATE,
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);

/*
Question 3:
Third Normal Form (3NF):
Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
present and outline the steps to normalize the table to 3NF.
*/
-- Answer:
-- The `customer` table violates 3NF if it stores city name instead of city_id.
-- Solution: Separate `city` into a new table.


CREATE TABLE city (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

ALTER TABLE customer 
DROP COLUMN city,
ADD COLUMN city_id INT,
ADD FOREIGN KEY (city_id) REFERENCES city(city_id);

/*
Question 4:
Normalization Process:
Guide through the process of normalizing a table from the initial unnormalized form up to at least 2NF.
*/
-- Answer:
-- Consider a table "orders" that stores multiple product IDs in a single row.
-- Step 1: Convert it into 1NF by ensuring atomic values.
-- Step 2: Separate it into 2NF by moving product details into a separate table.


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

/*
Question 5:
CTE Basics:
Write a query using a CTE to retrieve the distinct list of actor names and 
the number of films they have acted in.
*/

WITH ActorFilms AS (
    SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT * FROM ActorFilms;

/*
Question 6:
CTE with Joins:
Create a CTE that combines information from the film and language tables to 
display the film title, language name, and rental rate.
*/

WITH FilmLanguage AS (
    SELECT f.title, l.name AS language_name, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLanguage;

/*
Question 7:
CTE for Aggregation:
Write a query using a CTE to find the total revenue generated by each customer 
(sum of payments).
*/

WITH CustomerRevenue AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM CustomerRevenue;

/*
Question 8:
CTE with Window Functions:
Utilize a CTE with a window function to rank films based on their rental duration.
*/

WITH FilmRanking AS (
    SELECT title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS film_rank
    FROM film
)
SELECT * FROM FilmRanking;


/*
Question 9:
CTE and Filtering:
Create a CTE to list customers who have made more than two rentals, and then join this 
CTE with the customer table to retrieve additional customer details.
*/

WITH FrequentRenters AS (
    SELECT customer_id, COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)
SELECT c.customer_id, c.first_name, c.last_name, f.rental_count
FROM customer c
JOIN FrequentRenters f ON c.customer_id = f.customer_id;

/*
Question 10:
CTE for Date Calculations:
Write a query using a CTE to find the total number of rentals made each month.
*/

WITH MonthlyRentals AS (
    SELECT MONTH(rental_date) AS rental_month, COUNT(*) AS total_rentals
    FROM rental
    GROUP BY MONTH(rental_date)
)
SELECT * FROM MonthlyRentals;

/*
Question 11:
CTE and Self-Join:
Create a CTE to generate a report showing pairs of actors who have appeared in the same 
film together.
*/

WITH ActorPairs AS (
    SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2, fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT a1.first_name AS actor1, a2.first_name AS actor2, f.title
FROM ActorPairs ap
JOIN actor a1 ON ap.actor1 = a1.actor_id
JOIN actor a2 ON ap.actor2 = a2.actor_id
JOIN film f ON ap.film_id = f.film_id;

/*
Question 12:
CTE for Recursive Search:
Implement a recursive CTE to find all employees in the staff table who report to a specific manager.
*/

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE reports_to = 1  -- Change this to the manager's ID

    UNION ALL

    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    JOIN EmployeeHierarchy e ON s.reports_to = e.staff_id
)
SELECT * FROM EmployeeHierarchy;

