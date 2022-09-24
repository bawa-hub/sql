-- Revision the select query 1
select * from CITY Where COUNTRYCODE = 'USA' AND POPULATION > 100000;

-- Revision the select query 2
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'USA' AND POPULATION > 120000;

-- Select All
SELECT * FROM CITY;

-- Select By ID
SELECT * FROM CITY WHERE ID = 1661;

-- Japanes city attributes
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Japanes city names
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN'

-- Whether Obsevation Station 1
SELECT CITY, STATE FROM STATION;

-- Whether Obsevation Station 3
SELECT DISTINCT CITY FROM STATION WHERE ID%2 = 0;

-- Whether Obsevation Station 4
SSELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;

-- Whether Obsevation Station 5