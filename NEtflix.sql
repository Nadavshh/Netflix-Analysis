USE netflix;

SELECT TOP 10 * FROM dbo.DataNetflixRevenue2020_V2$;
SELECT TOP 10 * FROM dbo.DataNetflixSubscriber2020_V2$ ;
SELECT TOP 10 * FROM dbo.netflix_titles$ ;
SELECT TOP 10 * from dbo.['netflix-rotten-tomatoes-metacri$'] ;

--Total Revenue And Subcricbers For Q1 2018 - Q2 2020 Per Area
SELECT a.Area,
SUM(a.Revenue) AS Total_revenue,
SUM(b.Subscribers) AS Total_subscribers
FROM dbo.DataNetflixRevenue2020_V2$  a
JOIN dbo.DataNetflixSubscriber2020_V2$ b
	ON a.Area = b.Area
GROUP BY a.Area
ORDER BY 2 DESC
;

--Total Revenue And Subcricbers For Q1 2018 - Q2 2020 Per Area OVER TIME
SELECT a.Years,
a.Area,
SUM(a.Revenue) AS Total_revenue,
SUM(b.Subscribers) AS Total_subscribers
FROM dbo.DataNetflixRevenue2020_V2$ a
JOIN dbo.DataNetflixSubscriber2020_V2$ b
	ON a.Years= b.Years
GROUP BY a.Years, a.Area
ORDER BY 2,1
;

-- ARANGE THE DATA WITH DATE ORDER
SELECT title,
type,
date_added 
FROM dbo.netflix_titles$
WHERE date_added IS NOT NULL
AND YEAR(date_added) >= 2018
ORDER BY  YEAR(date_added),MONTH(date_added),DAY(date_added)
;

-- Movies and TV Shows added no Netflix per Year
SELECT COUNT(a.title) AS Total,
a.type,
YEAR(a.date_added) AS Calander_Year
FROM dbo.netflix_titles$ a 
WHERE date_added IS NOT NULL
AND YEAR(date_added) >= 2018
GROUP BY YEAR(a.date_added),a.type
ORDER BY 2
;
-- Releases in NETFLIX per director
SELECT a.director ,
COUNT(a.director) AS Total_releases
FROM dbo.netflix_titles$ a
WHERE a.director IS NOT NULL
GROUP BY a.director
ORDER BY 2 DESC
;
-- The country that released the most in netflix
SELECT a.country,
COUNT(a.country) AS Total_releases_in_netflix
FROM dbo.netflix_titles$ a
WHERE date_added IS NOT NULL
AND YEAR(date_added) >= 2018 
AND a.country IS NOT NULL
GROUP BY a.country
ORDER BY 2 DESC
;
-- TOP RATED Series BY IMDB
SELECT a.Title,
a.[IMDb Score],
a.[Series or Movie],
a.Poster,
a.Image,
a.Genre
FROM dbo.['netflix-rotten-tomatoes-metacri$'] a 
WHERE a.[Series or Movie] = 'Series'
ORDER BY 2 DESC
;
-- TOP RATED GENRES by IMDB
SELECT a.Genre,
ROUND(SUM(a.[IMDb Score]),2) AS Total_IMDB_Score
FROM dbo.['netflix-rotten-tomatoes-metacri$'] a
GROUP BY a.Genre
ORDER BY 2 DESC
;