/*
SQL Names

Save a script containing the query you used to answer each question and your answer (as a comment).
*/


--   ✅1.  How many rows are in the names table?

SELECT COUNT (*)
FROM names;

		--1,957,046 rows

--   ✅2.  How many total registered people appear in the dataset?

SELECT SUM(num_registered)
FROM names;

		--351,653,025 total registered

--   ✅3.  Which name had the most appearances in a single year in the dataset?

SELECT name, year, num_registered
FROM names
ORDER BY num_registered DESC;
		
		--Linda in 1947 with 99,689 registrations
		
--   ✅4.  What range of years are included?

SELECT DISTINCT year
FROM names
ORDER BY year;
 --or--
SELECT MIN(year), MAX(year)
FROM names;

		--1880 to 2018 are the years represented in the database

--   ✅5.  What year has the largest number of registrations?

SELECT year, SUM(num_registered)
FROM names
GROUP BY year
ORDER BY SUM(num_registered) DESC
LIMIT 5;

		--4,200,022 in 1957

--   ✅6.  How many different (distinct) names are contained in the dataset?

SELECT COUNT (DISTINCT name)
FROM names;

		--98,400 names

--   ✅7.  Are there more males or more females registered?

SELECT gender, SUM(num_registered)
FROM names
GROUP BY gender;
/*
		"gender"	"sum"
		"F"	174,079,232
		"M"	177,573,793
			
			About 3.5 million more male names were registered.
*/

--   ✅8.  What are the most popular male and female names overall (i.e., the most total registrations)?

SELECT name, gender, SUM(num_registered) as total_registered
FROM names
GROUP BY gender, name
ORDER BY SUM(num_registered) DESC;

/*		"name"	"gender"	"sum"
		"James"	"M"	5,164,280
		"Mary"	"F"	4,125,675
			
		James with 5.1M registrations and Mary with 4.1 registrations were the most popular names overall.
*/

--   ✅9.  What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?

SELECT name, gender, SUM(num_registered) as total_registered
FROM names
WHERE year BETWEEN 2000 AND 2009
GROUP BY gender, name
ORDER BY SUM(num_registered) DESC;

/*	"name"	"gender"	"total_registered"
	"Jacob"	"M"	273844
	"Emily"	"F"	223690
	
	Jacob and Emily were the most popular boy and girl names registered 2000-2009
*/	

--   ✅10. Which year had the most variety in names (i.e. had the most distinct names)?

SELECT COUNT (DISTINCT name), year
FROM names
GROUP BY year
ORDER BY COUNT (DISTINCT name) DESC;
	
	--32,518 distinct names were registered in 2008
	
--   ✅11. What is the most popular name for a girl that starts with the letter X?

SELECT name, gender, SUM(num_registered)
FROM names
WHERE name LIKE 'X%'
GROUP BY name, gender
ORDER BY SUM (num_registered) DESC;

		--The most popular girl name starting with the letter X is Ximena with 26145 registrations.
		
--   ✅12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?

SELECT name
FROM names
WHERE name LIKE 'Q%'AND name NOT LIKE '_u%'
ORDER BY name DESC;

SELECT COUNT (DISTINCT name)
FROM names
WHERE name LIKE 'Q%'AND name NOT LIKE '_u%'
ORDER BY COUNT(name) DESC;
		--46 distinct names start with Q but do not have u as their 2nd letter.

--   ✅13.  Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.

SELECT name, SUM(num_registered)
FROM names
WHERE name LIKE 'Ste%en'
GROUP by name
ORDER BY SUM(num_registered) DESC;

		--The 'Steven' spelling is more popular than 'Stephen' with 1,286,951 registrations vs 860,972

--   ✅14.  What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?

SELECT name, COUNT(DISTINCT gender)
FROM names
GROUP BY name
HAVING COUNT(DISTINCT gender) > 1;

SELECT (10773.0/98400.0)*100.0
		
		--10.95% are unisex names

--   ✅15.  How many names have made an appearance in every single year since 1880?

SELECT name, COUNT (DISTINCT year)
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year)=(SELECT COUNT (DISTINCT year) from names);

		--921 names have appeared every year.

--   ✅16.  How many names have only appeared in one year?

SELECT name, COUNT (DISTINCT year)
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year)=1;

		--21,123 names only appeared in one year.
		
--   ✅17.  How many names only appeared in the 1950s?

SELECT name, MIN(year) AS first_year, MAX(year) AS last_year
FROM names
GROUP BY 1
HAVING MIN(year) >= 1950 AND MAX(year) <= 1959;

		--661 names only appeared in the 1950s

--   ✅18.  How many names made their first appearance in the 2010s?

SELECT name, MIN(year) AS first_year
FROM names
GROUP by name
HAVING MIN(year)>= 2010

		--11,270 names first appeared in the 2010s.

--   ✅19.  Find the names that have not be used in the longest.

SELECT name, MAX(year) AS last_used
FROM names
GROUP BY name
ORDER BY MAX(year);

		--Roll and Zilpah are the names that haven't been used in the longest time.

--   ✅20.  Come up with a question that you would like to answer using this dataset. Then write a query to answer this question. 
		--Are there any boys named Sue?

SELECT COUNT(name), gender, SUM(num_registered)
FROM names
WHERE name LIKE 'Sue' AND gender='M'
GROUP BY gender;

		--519 boys have been named Sue.

SELECT COUNT(name), gender, SUM(num_registered), year
FROM names
WHERE name LIKE 'Sue' AND gender='M'
GROUP BY gender, year;
		--...going all the way back to 1917 with the most recent in 1996