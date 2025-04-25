/*🔍 Step 1: Create a Local MySQL Database
1. Open MySQL Workbench
2. Connect to your local MySQL server
3. Run this SQL to create a new database: */
CREATE DATABASE netflix_db;
USE netflix_db;

/* 🔍 Step 1:  Download the Dataset
1. Go to this Kaggle page:
📥 Netflix Movies and TV Shows Dataset
2. Click the Download button (top right)
3. Unzip the file—you’ll get netflix_titles.csv  */

/*🔍 Step 2: Create the Database and Table in MySQL Workbench
Open MySQL Workbench
Connect to your local MySQL instance
Open a new SQL tab and run the following:*/
CREATE TABLE netflix_titles (
    show_id VARCHAR(20),
    type VARCHAR(10),
    title VARCHAR(255),
    director TEXT,
    cast TEXT,
    country TEXT,
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in TEXT,
    description TEXT
);

/*🔍 Step 4: Test the Data*/
SELECT     *FROM    netflix_titles LIMIT 5;

/*🔍 Step 5: SQL Practice – Level 1 (Basic Exploration)
Try these out one at a time: */

/*✅1. Count how many movies and TV shows there are:*/
SELECT type, COUNT(*) AS count
FROM netflix_titles
GROUP BY type;

/*✅2. Find the top 10 countries by number of titles:*/
SELECT country , COUNT(*) AS count
FROM netfliX_titles
GROUP BY country
ORDER BY count DESC
LIMIT 10;

/*✅3. How many titles were released each year?*/
SELECT release_year, COUNT(*) AS count
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

/*🔍 Step 6: SQL Practice – Level 2 (Filters, Sorting, Strings)*/

/*✅4. List the 10 most recently added titles: */
SELECT title, date_added, type
FROM netflix_titles
WHERE date_added IS NOT NULL
ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC
LIMIT 10;
/*-- QUESTIO RE ABOVE:  why coma is positioned after d, but not after M as well?
EXPLANATION:
Fantastic question—and you’ve got a sharp eye! 🔍
The comma placement in the STR_TO_DATE() format string is meant to match the exact punctuation and spacing in the actual string stored in the date_added column.

🎯 Let's look at an example value:
arduino
Copy code
"September 9, 2021"
The structure here is:

Full month name → September → %M
Space
Day → 9 → %d
Comma
Space
Year → 2021 → %Y

So the correct format string must match that exact structure, including punctuation:

sql
Copy code
'%M %d, %Y'
This means:

%M = Full month name (e.g. "September")
= space
%d = day (e.g. 9)

, = comma (must match!)
= another space
%Y = year (e.g. 2021)

❌ Incorrect example:
If you had written:

sql
Copy code
'%M, %d %Y'
That would be expecting something like:

arduino
Copy code
"September, 9 2021"
—which doesn’t match your actual data. So the conversion would fail or return NULL.

✅ Bottom line:
The comma goes after the %d because the real string has a comma after the day, not after the month.

*/


/*✅5. Show all titles where the director is known and not empty:*/
SELECT title, director
FROM netflix_titles
WHERE director IS NOT NULL AND director != ''
LIMIT 10;

/*✅ 6. Find all movies with “Love” in the title (case-insensitive):*/
SELECT title, type
FROM netflix_titles
WHERE LOWER(title) LIKE '%love%'
AND type = 'Movie';
/* CHECK ABOVE: 💡 Why use LOWER()?
Because text matching in SQL (especially with LIKE) is often case-sensitive—so:

sql
Copy code
WHERE title LIKE '%love%'
would match "Crazy Little Thing Called Love"
but not "Love Actually" (because of the capital "L").✅ What does LOWER(title) do?
It transforms every title to lowercase before comparing it:

sql
Copy code
LOWER('Love Actually') → 'love actually'
So when you run:
sql
Copy code
WHERE LOWER(title) LIKE '%love%'
…it will match any of the following:
"Love Actually"
"A Little Thing Called Love"
"lovely bones"
"LOVE & OTHER DRUGS"
Because now everything is treated as lowercase.
🔄 You can also use UPPER() if you prefer:
sql
Copy code
WHERE UPPER(title) LIKE '%LOVE%'
Same idea, just different case direction.

💥 TL;DR:
LOWER() makes the comparison case-insensitive

Ensures you catch all versions: "Love", "love", "LOVE", etc.*/

/*✅ 7. Get the number of titles by rating:*/

SELECT rating, COUNT(*) AS count
FROM netflix_titles
GROUP BY rating
ORDER BY count DESC;

/*🎯 “Top 10 most common content ratings (like TV-MA, PG, etc.)
 in descending order”*/
SELECT rating AS '10 MOST COMMON', type, COUNT(*) AS count
FROM netflix_titles
GROUP BY rating, type
ORDER BY count DESC
LIMIT 10;

SELECT     *FROM    netflix_titles;
