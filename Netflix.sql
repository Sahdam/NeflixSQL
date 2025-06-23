CREATE DATABASE Netflix_db


SELECT *
FROM Netflix_db.dbo.Netflix


-- 1. Count the number of Movies vs TV Shows
SELECT DISTINCT type, COUNT(type) AS MovieTypeCount
FROM Netflix_db.dbo.Netflix
GROUP BY type
ORDER BY type

-- 2. Find the most common rating for movies and TV shows
SELECT type, rating
FROM(
SELECT  type, rating, COUNT(*) AS MostCommonRating,
RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS Ranking
FROM Netflix_db.dbo.Netflix
GROUP BY type,rating) AS Table1
WHERE Ranking = 1


-- 3. List all movies released in a specific year (e.g., 2020)
SELECT show_id,title, listed_in,country
FROM Netflix_db.dbo.Netflix
WHERE release_year = '2020'
AND type = 'movie'
ORDER BY title

-- 4. Find the top 5 countries with the most content on Netflix
SELECT TOP 5 countrylist,type, COUNT(countrylist) AS CountryCount
FROM
(
SELECT show_id,type,VALUE AS countrylist
FROM Netflix_db.dbo.Netflix
CROSS APPLY string_split(country, ',')
) AS T1

GROUP BY countrylist,type
ORDER BY CountryCount DESC


-- 5. Identify the longest movie or TV show duration

SELECT TOP 1 title, duration, type
FROM (
  SELECT *,
         TRY_CAST(LEFT(duration, CHARINDEX(' ', duration) - 1) AS INT) AS duration_value
  FROM Netflix_db.dbo.Netflix
  WHERE duration IS NOT NULL
) AS T
ORDER BY duration_value DESC

--6. Find content added in the last 5 years
SELECT *
FROM Netflix_db.dbo.Netflix
WHERE date_added BETWEEN '2017-01-01' AND '2021-12-31'
ORDER BY date_added DESC

SELECT *
FROM Netflix_db.dbo.Netflix
WHERE date_added >= DATEADD(YEAR, -5, GETDATE())

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT show_id, type, title, cast, country, date_added, release_year, rating, duration, directorlist
FROM (
SELECT show_id, type, title, cast, country, date_added, release_year, rating, duration, VALUE AS directorlist
FROM Netflix_db.dbo.Netflix
CROSS APPLY STRING_SPLIT(director, ',')
) AS T3
WHERE LTRIM(RTRIM(LOWER(directorlist))) = 'rajiv chilaka'


-- 8. List all TV shows with more than 5 seasons
WITH duration_CTE AS
(
SELECT show_id,type, title, cast, country, VALUE AS durationseason,
ROW_NUMBER() OVER(PARTITION BY show_id ORDER BY show_id) AS RowNum
FROM Netflix_db.dbo.Netflix
CROSS APPLY string_split(duration, ' ')
)
SELECT show_id,type, title, cast, country, [1] AS season_num, [2] AS season
FROM duration_CTE
PIVOT
(MAX(durationseason) FOR RowNum IN ([1], [2])) AS PVT
WHERE [2] LIKE 'Season%' 
AND [1] > 5 

-- 9. Count the number of content items in each genre
SELECT  Genre, COUNT(Genre) AS GenreCOUNT
FROM
(
SELECT  VALUE AS Genre
FROM Netflix_db.dbo.Netflix
CROSS APPLY string_split(listed_in, ',')
) AS T4
GROUP BY Genre
ORDER BY GenreCOUNT DESC

-- 10. Find the average release year for content produced in a specific country

SELECT Year_Added, COUNT(*) AS Content, (COUNT(*)*1.0)/(SELECT COUNT(*) FROM Netflix_db.dbo.Netflix)*100 AS Average
FROM(
SELECT YEAR(date_added) AS Year_Added, VALUE AS country
FROM Netflix_db.dbo.Netflix
CROSS APPLY string_split(country, ',')
) AS T5

WHERE country = 'India'
GROUP BY Year_Added
ORDER BY Content DESC

--11. List all movies that are documentaries
SELECT show_id,type,title,director,country,date_added,release_year,description,Genre
FROM(
SELECT *, VALUE AS Genre
FROM Netflix_db.dbo.Netflix
CROSS APPLY string_split(listed_in, ',')
) AS T6
WHERE type = 'Movie' 
AND Genre LIKE 'Documentar%'

SELECT *
FROM Netflix_db.dbo.Netflix
WHERE LOWER([listed_in]) LIKE  '%Documentar%'
AND type = 'Movie' 

--12. Find all content without a director
SELECT *
FROM Netflix_db.dbo.Netflix
WHERE director IS NULL

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT *
FROM
(SELECT date_added,VALUE AS Cast
FROM Netflix_db.dbo.Netflix
CROSS APPLY string_split(cast, ',')
) AS T7
WHERE date_added >= DATEADD(YEAR, -10, GETDATE())
AND Cast = 'Salman Khan'

SELECT *
FROM Netflix_db.dbo.Netflix
WHERE LOWER([cast]) LIKE  '%Salman Khan%'
AND date_added >= DATEADD(YEAR, -10, GETDATE())

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced
SELECT TOP 10 Cast, COUNT(Cast) NumberOfMovie
FROM
(SELECT  VALUE AS Cast
FROM Netflix_db.dbo.Netflix
CROSS APPLY string_split(cast, ',')
) AS T8
GROUP BY Cast
ORDER BY 2 DESC

--15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in
-- the description field. Label content containing these keywords as 'Bad' and all other
-- content as 'Good'. Count how many items fall into each category.

SELECT Category, COUNT(Category) AS CategoryCount
FROM
(
SELECT *,
CASE
	 WHEN LOWER([description]) LIKE '%kill%' 
	 OR
	 LOWER([description]) LIKE 'violence' THEN 'Bad Content'
	 ELSE 'Good Content'
END AS Category
FROM Netflix_db.dbo.Netflix
) AS T9
GROUP BY Category