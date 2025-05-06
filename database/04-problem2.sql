-- Who worked with whom?

-- Explore tables
.tables
SELECT * FROM Camp_assignment;
SELECT * FROM Personnel;
    -- Join tables to assign full names to observer
    CREATE VIEW v AS 
    SELECT Year, Site, Observer, Name, Start, "End"
    FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation;
SELECT * FROM v;

-- Find people who worked at the same site, and 
-- whose date ranges overlap while at this site,
-- using a self-join

-- Step 1
SELECT * FROM Camp_assignment A 
    JOIN Camp_assignment B
    ON A.Site = B.Site;

-- Step 2
SELECT * FROM Camp_assignment A 
    JOIN Camp_assignment B
    ON A.Site = B.Site
    WHERE (A.Start <= B.End) AND (A.End >= B.Start);

-- Step 3
SELECT * FROM Camp_assignment A 
    JOIN Camp_assignment B
    ON A.Site = B.Site
    WHERE (A.Start <= B.End) AND (A.End >= B.Start)
    AND A.Site='lkri';

SELECT * FROM Camp_assignment A 
    JOIN Camp_assignment B
    ON A.Site = B.Site
    WHERE (A.Start <= B.End) AND (A.End >= B.Start)
    AND A.Site='lkri'
    AND A.Observer < B.Observer;

-- Step 4 Clean up
SELECT A.Site, A.Observer AS Observer_1, B.Observer AS Observer_2 
    FROM Camp_assignment A 
    JOIN Camp_assignment B
    ON A.Site = B.Site
    WHERE (A.Start <= B.End) AND (A.End >= B.Start)
    AND A.Site='lkri'
    AND A.Observer < B.Observer;

-- Bonus: Add full names by joining the Personnel table
-- Notes: I didn't choose to join personnel table twice with output from above
-- Join table 
CREATE VIEW v_bonus AS 
    SELECT Year, Site, Observer, Name, Start, "End"
    FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation;

SELECT A.Site, A.Name AS Name_1, B.Name AS Name_2 
    FROM v_bonus A 
    JOIN v_bonus B
    ON A.Site = B.Site
    WHERE (A.Start <= B.End) AND (A.End >= B.Start)
    AND A.Site='lkri'
    AND A.Observer < B.Observer
    ORDER BY B.Name;