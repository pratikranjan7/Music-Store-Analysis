-- 1. Who is the senior most employee based on job title?

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1


-- 2. Which countries have the most Invoices? 

SELECT billing_country,count(1) as count_of_invoice
FROM invoice
GROUP BY billing_country
ORDER BY count_of_invoice DESC
LIMIT 1

-- 3. What are top 3 values of total invoice? 

SELECT total 
FROM invoice
ORDER BY total DESC
LIMIT 3

-- 4. Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice 
-- totals 

SELECT billing_city,SUM(total) AS total
FROM invoice
GROUP BY billing_city
ORDER BY total DESC
LIMIT 1

-- 5. Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the 
-- most money 



SELECT (c.first_name,c.last_name) as full_name,x.customer_id
FROM customer c
JOIN	
(SELECT customer_id,SUM(total) AS total
FROM invoice 
GROUP BY customer_id
ORDER BY total DESC
LIMIT 1)x
ON c.customer_id = x.customer_id

--SELECT c.first_name,c.last_name as full_name,x.customer_id,total
--FROM customer c
--JOIN	
--(SELECT TOP 1 customer_id,SUM(total) AS total
--FROM invoice 
--GROUP BY customer_id
--ORDER BY total DESC)x
--ON c.customer_id = x.customer_id
	




-- Question Set 2 – Moderate 
-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A 

select distinct c.email, c.first_name, c.last_name
from customer c
join invoice i
on c.customer_id = i.customer_id
join invoice_line il
on il.invoice_id = i.invoice_id
join track t
on t.track_id = il.track_id
join genre g
on g.genre_id = t.genre_id
where g.name = 'Rock'
order by c.email



-- 2. Let's invite the artists who have written the most rock music in our dataset. Write a 
-- query that returns the Artist name and total track count of the top 10 rock bands 

SELECT a.name as artist_name,count(1) as track_count
FROM artist a
join album alb
on alb.artist_id = a.artist_id
join track t on t.album_id = alb.album_id
join genre g
on g.genre_id = t.genre_id
where g.name = 'Rock'
group by a.name
order by track_count desc
limit 10



-- 3. Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first 

select name,milliseconds
from track
where milliseconds >
(select avg(milliseconds)
from track t)
order by milliseconds desc



-- Question Set 3 – Advance 
-- 1. Find how much amount spent by each customer on artists? Write a query to return 
-- customer name, artist name and total spent 

select first_name,last_name,a.name,sum(total)
from customer c
join artist a


join invoice i

select *
from [dbo].[artist]

select *
from invoice

select *
from invoice_line

select *
from [dbo].[album]

select *
from [dbo].[customer]
select *
from playlist_track


select *
from track

[dbo].[genre]

select c.first_name,c.last_name,sum(i.total) as sum,art.name
from invoice i
join invoice_line il on i.invoice_id = il.invoice_id
join track t on t.track_id = il.track_id
join album a on a.album_id = t.album_id
join artist art on art.artist_id = a.artist_id
join customer c on c.customer_id = i.customer_id
group by  c.first_name,c.last_name,art.name






-- 2. We want to find out the most popular music Genre for each country. We determine the 
-- most popular genre as the genre with the highest amount of purchases. Write a query 
-- that returns each country along with the top Genre. For countries where the maximum 
-- number of purchases is shared return all Genres 

	with cte as(select *, dense_rank() over(partition by country order by country,count desc) as rnk
	from (select i.billing_country as country,g.name,count(g.genre_id) as count
	from invoice i
	join invoice_line il
	on i.invoice_id = il.invoice_id
	join track t
	on il.track_id = t.track_id
	join genre g
	on g.genre_id = t.genre_id
	group by i.billing_country,g.name)x)


-- 3. Write a query that determines the customer that has spent the most on music for each 
-- country. Write a query that returns the country along with the top customer and how 
-- much they spent. For countries where the top amount spent is shared, provide all 
-- customers who spent this amount 


	with cte as(select *,dense_rank() over(partition by country order by country,total desc) as rnk
	from(select c.first_name as first_name,c.last_name as last_name,
	i.billing_country as country,sum(i.total) as total
	from customer c
	join invoice i
	on c.customer_id = i.customer_id
	group by c.first_name,c.last_name,i.billing_country)x)

	select *
	from cte where rnk = 1






	









