/*
Week 3: Your First Database (MCU starter)
Goal: Create MCU_Training, create tables, insert sample data, verify.
*/

-- Recreate from scratch (teaching-friendly). Comment out DROP if you want to keep work.
IF DB_ID('MCU_Training') IS NOT NULL
BEGIN
    ALTER DATABASE MCU_Training SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE MCU_Training;
END
GO

CREATE DATABASE MCU_Training;
GO

USE MCU_Training;
GO

/* Core entities */
CREATE TABLE dbo.Characters
(
    CharacterID     INT IDENTITY(1,1) NOT NULL,
    CharacterName   NVARCHAR(150) NOT NULL,
    Alias           NVARCHAR(150) NULL,
    FirstAppearanceYear SMALLINT NULL
    -- Keys/constraints come in Week 5+10; keep Week 3 simple.
);
GO

CREATE TABLE dbo.Films
(
    FilmID      INT IDENTITY(1,1) NOT NULL,
    FilmTitle   NVARCHAR(200) NOT NULL,
    ReleaseYear SMALLINT NULL,
    ReleaseDate DATE NULL
);
GO

/* Bridge table: many-to-many (a character appears in many films; a film has many characters) */
CREATE TABLE dbo.CharacterFilmAppearances
(
    CharacterID INT NOT NULL,
    FilmID      INT NOT NULL,
    RoleType    NVARCHAR(50) NULL,      -- e.g. 'Lead', 'Supporting', 'Cameo'
    BillingOrder INT NULL               -- teaching-friendly: simple integer ordering
);
GO

/* Sample data (small, enough to teach queries/joins/aggregates) */
INSERT INTO dbo.Characters (CharacterName, Alias, FirstAppearanceYear)
VALUES
('Tony Stark', 'Iron Man', 2008),
('Steve Rogers', 'Captain America', 2011),
('Thor Odinson', 'Thor', 2011),
('Natasha Romanoff', 'Black Widow', 2010),
('Bruce Banner', 'Hulk', 2008);

INSERT INTO dbo.Films (FilmTitle, ReleaseYear, ReleaseDate)
VALUES
('Iron Man', 2008, '2008-05-02'),
('The Incredible Hulk', 2008, '2008-06-13'),
('Iron Man 2', 2010, '2010-05-07'),
('Thor', 2011, '2011-05-06'),
('Captain America: The First Avenger', 2011, '2011-07-22'),
('The Avengers', 2012, '2012-05-04');

-- Appearances (IDs will match insert order in a fresh database)
-- Characters:
-- 1 Tony, 2 Steve, 3 Thor, 4 Natasha, 5 Bruce
-- Films:
-- 1 Iron Man, 2 Incredible Hulk, 3 Iron Man 2, 4 Thor, 5 Cap 1, 6 Avengers

INSERT INTO dbo.CharacterFilmAppearances (CharacterID, FilmID, RoleType, BillingOrder)
VALUES
(1, 1, 'Lead', 1),   -- Tony in Iron Man
(5, 2, 'Lead', 1),   -- Bruce in Incredible Hulk
(1, 3, 'Lead', 1),   -- Tony in Iron Man 2
(4, 3, 'Supporting', 2), -- Natasha in Iron Man 2
(3, 4, 'Lead', 1),   -- Thor in Thor
(2, 5, 'Lead', 1),   -- Steve in Cap 1
(1, 6, 'Lead', 1),   -- Avengers ensemble
(2, 6, 'Lead', 2),
(3, 6, 'Lead', 3),
(4, 6, 'Lead', 4),
(5, 6, 'Lead', 5);

-- Quick sanity checks
SELECT * FROM dbo.Characters;
SELECT * FROM dbo.Films;
SELECT * FROM dbo.CharacterFilmAppearances;