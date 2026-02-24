/*
Week 4: SQL Basics
Goal: SELECT/FROM/WHERE/ORDER BY using MCU data.
*/

USE MCU_Training;
GO

-- Start simple
SELECT * FROM dbo.Characters;

SELECT CharacterName, Alias
FROM dbo.Characters
ORDER BY CharacterName;

-- Filtering
SELECT *
FROM dbo.Films
WHERE ReleaseYear = 2011
ORDER BY ReleaseDate;

-- NULL checks
SELECT *
FROM dbo.Films
WHERE ReleaseDate IS NULL;

-- Pattern matching
SELECT *
FROM dbo.Characters
WHERE Alias LIKE '%H%';

-- TOP with ORDER BY
SELECT TOP (3)
    FilmTitle, ReleaseDate
FROM dbo.Films
ORDER BY ReleaseDate ASC;

-- Simple computed column in query
SELECT
    FilmTitle,
    ReleaseYear,
    ReleaseYear - 2000 AS YearsAfter2000
FROM dbo.Films
ORDER BY ReleaseYear;