-- Example insert
.nullvalue -NULL-

-- Part 1
-- Creating a trigger that automatically filled in the next sequential egg number
CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
        UPDATE Bird_eggs
            SET Egg_num = (SELECT MAX(Egg_num)+1 FROM Bird_eggs WHERE Nest_ID = new.Nest_ID) 
            WHERE Book_page=new.Book_page 
            AND Year = new.Year 
            AND Nest_ID = new.Nest_ID 
            AND Length = new.Length 
            AND Width = new.Width;
    END;

-- Make an insert
INSERT INTO Bird_eggs
    (Book_page, Year, Site, Nest_ID, Length, Width)
    VALUES ('b14.6', 2014, 'eaba', '14eabaage01', 12.34, 56.78);

-- Test it
SELECT * FROM Bird_eggs;

-- Delete pervious insert
-- Test with a temp table
CREATE TEMP TABLE egg_temp AS SELECT * FROM Bird_eggs;
DELETE FROM egg_temp WHERE Nest_ID = '14eabaage01' 
AND Length = 12.34 AND Width = 56.78;

SELECT * FROM egg_temp;

-- Delete officially
xDELETE FROM Bird_eggs WHERE Nest_ID = '14eabaage01' 
AND Length = 12.34 AND Width = 56.78;

-- Part 2
-- Create a more comprehensive trigger that match all other columns
-- Drop any previous trigger
DROP TRIGGER egg_filler;

CREATE TRIGGER egg_filler_2
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
        UPDATE Bird_eggs
            SET
                Egg_num = (SELECT MAX(Egg_num)+1 FROM Bird_eggs WHERE Nest_ID = new.Nest_ID),
                Book_page = (SELECT MAX(Book_page) FROM Bird_eggs WHERE Nest_ID = new.Nest_ID), -- Any value is fine
                Year = (SELECT MIN(Year) FROM Bird_eggs WHERE Nest_ID = new.Nest_ID), -- Any value is fine
                Site = (SELECT MAX(Site) FROM Bird_eggs WHERE Nest_ID = new.Nest_ID) 
            WHERE Nest_ID = new.Nest_ID 
            AND Length = new.Length 
            AND Width = new.Width;
    END;
-- Note to self: Error with "SELECT Book_page FROM Bird_eggs WHERE Nest_ID = new.Nest_ID LIMIT 1" 
-- Make an insert
INSERT INTO Bird_eggs
    (Nest_ID, Length, Width)
    VALUES ('14eabaage01', 12.34, 56.78);

-- Test it
SELECT * FROM Bird_eggs;

-- Caveats: We are making the assumption that all egg measurements within one Nest_id are done in the same year

-- Question: What if we are inserting a row with new Nest_id and forgot to input Egg_num would NULL + 1 = NULL or 1

