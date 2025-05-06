-- Learn about tables
DESCRIBE Bird_nests;

SELECT * FROM Bird_eggs
    LIMIT 2;

SELECT * FROM Species
    LIMIT 1;

-- Group by nest and compute average volumes
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG(3.14*((Width)^2)*Length/6) AS Avg_volume
    FROM Bird_eggs
    GROUP BY Nest_ID;

-- Join with nest and species table
SELECT Scientific_name, MAX(Avg_volume) AS Max_avg_volume
    FROM Bird_nests 
    JOIN Averages USING (Nest_ID)
    JOIN Species ON Species = Code
    GROUP BY Scientific_name
    ORDER BY Max_avg_volume DESC;

-- One statement challenge
SELECT Scientific_name, MAX(Avg_volume) AS Max_avg_volume
    FROM Bird_nests 
    JOIN (SELECT Nest_ID, AVG(3.14*((Width)^2)*Length/6) AS Avg_volume
            FROM Bird_eggs
            GROUP BY Nest_ID
        ) USING (Nest_ID)
    JOIN Species ON Species = Code
    GROUP BY Scientific_name
    ORDER BY Max_avg_volume DESC;