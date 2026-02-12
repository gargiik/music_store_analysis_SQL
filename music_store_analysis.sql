-- Project: Music Store Data Analysis
-- Database: Chinook Database
-- Tool Used: PostgreSQL
-- Description: This project analyzes customer behavior, revenue patterns,artist performance, 
-- and genre popularity using SQL queries.


-- BUSINESS OBJECTIVE 1: Who is the senior most employee based on job title?

-- QUERY DESCREPTION : Senior Most Employee.
-- Retrieves the employee with the highest job level by ordering employees in descending order 
-- of hierarchy.

SELECT * FROM employee
ORDER BY levels desc 
limit 1


-- BUSINESS OBJECTIVE 2: Which countries have the most Invoices?

-- QUERY DESCREPTION : Countries With The Most Invoices.
-- Counts the total number of invoices per country and sorts the results to show the highest first.

SELECT COUNT(*) as c , billing_country
FROM invoice
GROUP BY billing_country
ORDER BY c DESC


-- BUSINESS OBJECTIVE 3: What are the top 3 values of total invoice?

-- QUERY DESCREPTION : Top 3 Highest Invoice Totals.
-- Returns the three highest invoice amounts by sorting totals in descending order.

SELECT total FROM invoice
ORDER BY total DESC
LIMIT 3


-- BUSINESS OBJECTIVE 4: Which city has the best customers? We would like to throw a promotional Music Festival in the city
-- we made the mostmoney. Write a query that returns one city that has the highest sum of invoice totals.
-- Return both the city name and sum of all invoice totals.

-- QUERY DESCREPTION : City With Highest Revenue
-- Calculates total revenue per city using SUM(total).

SELECT SUM(total) as invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total  DESC
LIMIT 1


-- BUSINESS OBJECTIVE 5: Who is the best customer? The customer who has spent the most money will be declared the best customer.
-- Write a query that returns the person who has spent the most money.

-- QUERY DESCREPTION : Best Customer
-- Identifies the customer who spent the most money by summing invoice totals per customer.

SELECT customer.customer_id, customer.first_name, customer.last_name,SUM(invoice.total)as total
FROM customer 
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
LIMIT 1


-- BUSINESS OBJECTIVE 6: List the email, first name, last name and Genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email starting with A.

-- QUERY DESCREPTION : Rock Music Listeners
-- Retrieves unique customers who purchased Rock genre tracks and orders them alphabetically by email.

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN (
SELECT track_id FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Rock'
)
ORDER BY email;


-- BUSINESS OBJECTIVE 7: Let's invite artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

-- QUERY DESCREPTION : Top 10 Rock Artists
-- Counts the number of Rock tracks per artist
-- and returns the top 10 artists with the highest count.

SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC 
LIMIT 10;


-- BUSINESS OBJECTIVE 8: Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the longest 
-- songs listed first. 

-- QUERY DESCREPTION : Tracks That Are Longer Than Average
-- Returns tracks with duration greater than the average track length and sorts them from longest to shortest. 

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track)
ORDER BY milliseconds DESC; 

 




