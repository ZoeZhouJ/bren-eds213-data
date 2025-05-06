-- Who made mistake working at the 'nome' site between 1998 and 2008 inclusive for exactly 36 nests
.tables
SELECT * FROM Bird_eggs;
SELECT * FROM Bird_nests;
SELECT * FROM Personnel;
-- Bird_nests table has information on method and age 
-- Join personnel with Bird_nests table

CREATE VIEW v AS
    Select * FROM Bird_nests 
    JOIN Personnel 
    ON Observer = Abbreviation;

SELECT Name, COUNT(*) AS Num_floated_nests FROM v
    WHERE ageMethod = 'float' 
    AND Site = 'nome'
    AND Year BETWEEN 1998 AND 2008
    GROUP BY Name
    HAVING Num_floated_nests=36;


