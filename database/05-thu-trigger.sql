-- SQLite looks a lot like DuckDB
.schema
.tables
SELECT * FROM Species;
.nullvalue -NULL- -- by default sqlite just display null as empty which we dont want

-- The problem we are going to try to fix:
INSERT INTO Species VALUES ('abcd', 'thing1', '', 'Study species');
SELECT * FROM Species;

-- Time to create our trigger!
CREATE TRIGGER Fix_up_species 
AFTER INSERT ON Species 
FOR EACH ROW 
BEGIN 
    UPDATE Species
      SET Scientific_name = NULL
      WHERE Code = new.Code AND Scientific_name = '';
END;

-- let's test it
INSERT INTO Species 
  VALUES ('efgh', 'thing2','','Study species');
-- check result
SELECT * FROM Species;
-- trigger is stored in schema
.schema
