/*

   Data Cleaning in SQL Queries

*/
-----------------------------------------
-----------------------------------------

SELECT *
FROM dbo.texas_crime

-----------------------------

-- Cleaning the clearance_date column


SELECT clearance_date, LEFT(clearance_date, CHARINDEX(' ', clearance_date) - 1)
FROM dbo.texas_crime;


UPDATE dbo.texas_crime
SET clearance_date = LEFT(clearance_date, CHARINDEX(' ', clearance_date) - 1)


--------------------------------------------

-- Cleaning the timestamp column

SELECT timestamp, LEFT(timestamp, CHARINDEX(' ', timestamp) - 1)
FROM dbo.texas_crime

UPDATE dbo.texas_crime
SET timestamp = LEFT(timestamp, CHARINDEX(' ', timestamp) - 1)


-------------------------------------------------------------------------------------------------------------

-- Address column cleaning

SELECT address, SUBSTRING(address, CHARINDEX('Austin, TX', address), LEN('Austin, TX')) AS properaddress
FROM dbo.texas_crime
WHERE CHARINDEX('Austin, TX', address) > 0;

UPDATE dbo.texas_crime
SET address = SUBSTRING(address, CHARINDEX('Austin, TX', address), LEN('Austin, TX'))
WHERE CHARINDEX('Austin, TX', address) > 0;


-------------------------------------------------------------------------------------------------------------

-- Spliting address into city & state column

SELECT address, LEFT(address, CHARINDEX(',', address) - 1) AS City
FROM dbo.texas_crime

ALTER TABLE texas_crime
ADD City NVARCHAR(10)

UPDATE dbo.texas_crime
SET City = LEFT(address, CHARINDEX(',', address) - 1)

SELECT address, RIGHT(address, CHARINDEX(',', address) -4) AS State
FROM dbo.texas_crime

ALTER TABLE texas_crime
ADD State NVARCHAR(10)

UPDATE dbo.texas_crime
SET State = RIGHT(address, CHARINDEX(',', address) -4)

----------------------------------------------------------------------------------


-- Replacing 'TX' with Texas

UPDATE dbo.texas_crime
SET State = REPLACE(State, 'TX', 'Texas') 
WHERE CHARINDEX('TX', State) > 0;

----------------------------------------------------------------------------------


-- Setting the description column to proper case

UPDATE dbo.texas_crime
SET description = 
    CONCAT(
        UPPER(LEFT(description, 1)), LOWER(SUBSTRING(description, 2, LEN(description) - 1)))

----------------------------------------------------------------------------------------

-- Getting rid of unused column

ALTER TABLE dbo.texas_crime
DROP COLUMN address
-----------------------------------------------------------------------------------------

-- Viewing the cleaned data

SELECT *
FROM dbo.texas_crime
