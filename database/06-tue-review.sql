-- Review of SQL SELECT processing
SELECT Nest_ID, AVG(3.14/6*Width*Width*Length) AS Avg_volume -- 2nd: compute within AVG function
    FROM Bird_eggs
    WHERE Nest_ID LIKE '14%' -- Happens 1st
    GROUP BY Nest_ID -- 3rd: decide what group results are in, collapse into single row
    HAVING Avg_volume > 10000 
    ORDER BY Avg_volume DESC
    LIMIT 3 OFFSET 17;

-- Can group by a whole expression
SELECT Substring(Nest_ID, 1, 3), AVG(3.14/6*Width*Width*Length) AS Avg_volume 
    FROM Bird_eggs
    WHERE Nest_ID LIKE '14%' -- Happens 1st
    GROUP BY substring(Nest_ID, 1, 3) 
    HAVING Avg_volume > 10000 
    ORDER BY Avg_volume DESC;

-- Joins: creates a new mega-table
    -- Create table
CREATE TABLE a (col INT);
INSERT INTO a VALUES (1), (2), (3), (4);
CREATE TABLE b (col INT);
INSERT INTO b VALUES (0), (1);
SELECT * FROM a;
SELECT * FROM b;
    -- Every possible pairing of rows 
SELECT * FROM a JOIN b ON TRUE;
    -- normal conditional join
SELECT * FROM a JOIN b ON a.col = b.col;
SELECT * FROM a JOIN b ON NULL;
SELECT * FROM a JOIN b ON a.col = b.col OR a.col = b.col +1;
    -- An outer join adds in any rows not included by condition
SELECT * FROM a LEFT JOIN b ON a.col=b.col OR a.col=b.col+1;
        -- What's happening? compare to inner join. 
        -- the database added 3 and 4 in table a that never appeared by condition


