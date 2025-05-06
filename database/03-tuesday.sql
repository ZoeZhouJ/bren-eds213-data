.table

-- There are lots of "dot-command" in DuckDB
.help
.help show
.show
-- Ctrl-D or .exit to exit DuckDB

-- Start with SQL
SELECT * FROM Site;

-- SQL is case-insensitive, but uppercase is the tradition
select * from site;

SELECT * 

-- CTRL-C to refresh command 
-- wont run unless you had semi colon 
-- '' is not the same as "" here 

-- A multi-line statement: need to highlight the whole thing to run
Select *
    FROM Site;

-- LIMIT clause
SELECT * 
    FROM Site
    LIMIT 3;

-- can be combined with OFFSET clause
SELECT *
    FROM Site
    LIMIT 3
    OFFSET 3;

-- Selecting distinct items
SELECT * FROM Bird_nests LIMIT 1;
SELECT Species FROM Bird_nests;
SELECT DISTINCT Species FROM Bird_nests;
SELECT DISTINCT Species, Observer FROM Bird_nests;

-- Add ordering 
SELECT DISTINCT Species, Observer
    FROM Bird_nests
    ORDER BY Species; 

SELECT DISTINCT Species, Observer
    FROM Bird_nests
    ORDER BY Species, Observer DESC; 

-- Look at Site table
SELECT * FROM Site;
-- Select distinct locations from the SIte table
SELECT DISTINCT Location
    FROM Site; 
-- Are they returned in order? If not , order them
SELECT DISTINCT Location
    FROM Site
    ORDER BY Location; 
-- Add a limit clause to return just three results
-- Q: Was the LIMIT applied *before* the results were ordered or **AFTER**?
SELECT DISTINCT Location
    FROM Site
    ORDER BY Location
    LIMIT 3;
-- It wouldn't work the other way around
SELECT DISTINCT Location
    FROM Site
    LIMIT 3
    ORDER BY Location;