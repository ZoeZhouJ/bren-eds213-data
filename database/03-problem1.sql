CREATE TEMP TABLE problem1 (column1 REAL);
INSERT INTO problem1 (column1) VALUES
    (1.1),
    (2.1),
    (NULL),
    (3.1);

SELECT AVG(column1) FROM problem1;
-- Answer: The average ignoring null would be 2.1; the average including NULL would be 1.6. The answer returned from pervious query is ignoring NULL values.  

-- Compute average from scratch
SELECT SUM(column1)/COUNT(*) FROM problem1;
SELECT SUM(column1)/COUNT(column1) FROM problem1;
-- Answer: the second query is correct because AVG function divide the sum of the non-NULL values by the number of non-NULL values. 

-- Finish
DROP TABLE problem1;