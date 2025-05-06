-- Which sites have no egg data
-- Exploratory Queries
.tables
SELECT Site, COUNT(*) FROM Bird_eggs
   GROUP BY Site;
SELECT * FROM Site;
SELECT * FROM Bird_eggs;
.nullvalue -NULL-

-- Approach 1: Code NOT IN (subquery) clause
SELECT Code, Site_name FROM Site
    Where Code NOT IN (SELECT DISTINCT Site FROM Bird_eggs)
    ORDER BY Code;

-- Approach 2: outer join with a WHERE clause and IS NULL test
SELECT Code, Nest_ID, Egg_num FROM Site
    LEFT JOIN Bird_eggs ON Code = Site
    WHERE Site IS NULL
    ORDER BY Code;

-- Approach 3: Use the set operation EXCEPT
SELECT Code FROM Site
    EXCEPT SELECT DISTINCT Site FROM Bird_eggs
    ORDER BY Code;