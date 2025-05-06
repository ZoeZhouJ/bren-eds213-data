-- PART 1
SELECT Site_name, MAX(Area) FROM Site; 
SELECT Site_name, AVG(Area) FROM Site;

-- Error Explained
-- The problem is that the query tries to combine a single summary value with individual site names, but SQL doesn't know which site name to show alongside the maximum area.

-- PART 2
SELECT Site_name, Area 
    FROM Site 
    ORDER BY AREA DESC
    LIMIT 1;

-- PART 3
SELECT Site_name, Area FROM Site 
    WHERE AREA = (SELECT MAX(Area) FROM Site);