-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The
-- countrycode is 'USA', and population of 45001.

START TRANSACTION;
INSERT INTO city (name, countrycode, district, population)
VALUES ('Smallville', 'USA', 'Kansas', 45001);
SELECT * FROM city WHERE name = 'Smallville'
COMMIT

-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.
START TRANSACTION;
INSERT INTO countrylanguage(countrycode, language, isofficial, percentage)
VALUES ('USA', 'Kryptonese', false, 0.0001);
SELECT * FROM countrylanguage WHERE language = 'Kryptonese'
COMMIT

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble." Change
-- the appropriate record accordingly.
START TRANSACTION;
UPDATE countrylanguage 
SET language = 'Krypto-babble'
WHERE language = 'Kryptonese'
SELECT * FROM countrylanguage WHERE language = 'Krypto-babble'
COMMIT

-- 4. Set the US capital to Smallville, Kansas in the country table.
START TRANSACTION;
UPDATE country
SET capital = (SELECT id FROM city WHERE name = 'Smallville') --selects Smallville's code ? 4081
WHERE code = 'USA'
SELECT * FROM country WHERE code = 'USA'

COMMIT

-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

START TRANSACTION;
DELETE FROM city WHERE name = 'Smallville'
ROLLBACK
select * from city where name = 'Smallville'

--Smallville cannnot be deleted directly from the city table, because it is being used as a US capital 
--so deleting it would violate referentil integrety. 

-- 6. Return the US capital to Washington.
START TRANSACTION;
UPDATE country
SET capital = (SELECT id FROM city WHERE name = 'Washington') --selects Smallville's code ? 4081
WHERE code = 'USA'
SELECT * FROM country WHERE code = 'USA'

ROLLBACK;

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
START TRANSACTION;

DELETE FROM city WHERE name = 'Smallville' and district = 'Kansas'

ROLLBACK;

-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972
-- (exclusive).
-- (590 rows affected)

START TRANSACTION;

ROLLBACK;

-- 9. Convert population so it is expressed in 1,000s for all cities. (Round up to
-- the nearest integer value.)
-- (4079 rows affected)

START TRANSACTION;
UPDATE city SET population = (population / 1000);
SELECT name, population FROM city WHERE name = 'Columbus';
COMMIT;
-- 10. Assuming a country's surfacearea is expressed in square miles, convert it to
-- square meters for all countries where French is spoken by more than 20% of the
-- population.
-- (7 rows affected)
START TRANSACTION;
UPDATE country SET surfacearea = (surfacearea * (2589988.1103)) 
WHERE code IN (
SELECT code, surfacearea FROM country 
JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE percentage > 20.0 AND language = 'French')

COMMIT;



