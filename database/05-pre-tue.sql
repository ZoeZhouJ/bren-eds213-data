-- HW 3 Problem 3 recap
-- Exploring why grouping by Scientific_name is not quite correct
SELECT * FROM Species LIMIT 3;
-- Are there duplicate scientific names? (yes)
SELECT COUNT(*) FROM Species;
SELECT COUNT(DISTINCT Scientific_name) FROM Species;
CREATE TEMP TABlE t AS (
SELECT Scientific_name, COUNT(*) AS Num_name_occurrences
    FROM Species
    GROUP BY Scientific_name
    HAVING Num_name_occurrences > 1
);

SELECT * FROM t;
SELECT * FROM Species s JOIN t 
    ON s.Scientific_name = t.Scientific_name
    -- results shows two common names for cygnus columbianus
    OR (s.Scientific_name IS NULL AND t.Scientific_name IS NULL);

-- inserting data
INSERT INTO Species VALUES ('abcd', 'thing', 'scientific_name', NULL); -- a fragile query, columns are assumed
SELECT * FROM Species;
-- you can explicitly label columns
INSERT INTO Species
    (Common_name, Scientific_name, Code, Relevance)
    VALUES
    ('thing 2', 'another scientific name', 'efgh', NULL);
SELECT * FROM Species;
-- Can take advantage of default values
INSERT INTO Species
 (Common_name, Code)
 VALUES
 ('thing 3', 'ijkl');
SELECT * FROM Species;

-- UPDATEs and DELETEs will demolish the entire table unless limited by WHERE
DELETE FROM Bird_eggs WHERE Nest_ID.....

-- Strategies to save yourself?
-- Doing a SELECT first
SELECT * FROM Bird_eggs WHERE Nest_ID like 'z%';
SELECT * FROM Bird_nests;
-- say we want to delete chur site
-- try the create a copy of the table
CREATE TEMP TABLE nest_temp AS (SELECT * FROM Bird_nests);
DELETE FROM nest_temp WHERE Site = 'chur';

-- Another idea
xDELETE FROM ... WHERE ...;  -- take away the x once you are sure 
-- git restore database if accidentally deleted some table

-- next: look up slide on sql triggers
